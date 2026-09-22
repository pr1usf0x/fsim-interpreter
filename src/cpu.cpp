#include "cpu.hpp"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <utility>
#include "encoding.hpp"
#include "kernel.hpp"

namespace toy_sim {

// ================================ FETCH =====================================

const BasicBlock& Cpu::Fetch() {
  auto bb = decoder_cache_.find(pc_);
  if (bb == decoder_cache_.end()) {
    auto decoded_bb = DecodeBB();
    bb = decoder_cache_.insert(std::make_pair(pc_, decoded_bb)).first;
  }

  return bb->second;
}

// ================================ DECODER ===================================

namespace {
inline uint32_t GetBits(uint32_t bits, size_t low_b, size_t up_b) {
  assert(up_b < 8 * sizeof(bits));
  assert(low_b < 8 * sizeof(bits));
  assert(low_b <= up_b);

  size_t n = up_b - low_b + 1;
  uint32_t mask = ~0U >> (8 * sizeof(bits) - n);
  return (bits >> low_b) & mask;
}

inline Register DecodeReg1(uint32_t word) {
  return static_cast<Register>(GetBits(word, 21, 25));
}

inline Register DecodeReg2(uint32_t word) {
  return static_cast<Register>(GetBits(word, 16, 20));
}

inline Register DecodeReg3(uint32_t word) {
  return static_cast<Register>(GetBits(word, 11, 15));
}

CommandType GetCommandType(uint32_t word) {
  // [31:26] - opcode
  // [5:0] - opcode_2 for similar opcodes
  auto opcode = GetBits(word, 26, 31);
  uint16_t command_type = 0;
  switch (opcode) {
    case kLdPost:
    case kAddi:
    case kBeq:
    case kSsat:
    case kLd:
    case kLi:
    case kSt:
    case kUsat:
    case kJ:
    case kStp:
      command_type = ConvertToCommandType(opcode, 0);
      break;
    case kRbit:
      // case kNor:
      // case kSyscall:
      // case kBext:
      // case kAdd:
      command_type = ConvertToCommandType(0, GetBits(word, 0, 5));
      if (CheckIfCommandType(command_type))
        break;
    default:
      return CommandType::kUnknown;
  }

  return static_cast<CommandType>(command_type);
}

}  // namespace

void Cpu::RunProgram() {
  for (;;) {
    const BasicBlock& bb = Fetch();
    for (auto instr : bb) {
      Execute(instr);
    }
  }
}

Instruction Cpu::Decode(uint32_t instr_code) {
  auto command_type = GetCommandType(instr_code);
  Instruction instr{};
  instr.type_ = command_type;
  switch (command_type) {
    case CommandType::kLd:
    case CommandType::kSt:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      if (GetBits(instr_code, 14, 15))
        throw std::runtime_error("Decoder: failed to identify the instruction");
      instr.imm_ = GetBits(instr_code, 0, 13);
      break;

    case CommandType::kAdd:
    case CommandType::kNor:
    case CommandType::kBext:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.r3_ = DecodeReg3(instr_code);
      if (GetBits(instr_code, 6, 10))
        throw std::runtime_error("Decoder: failed to identify the instruction");
      break;

    case CommandType::kBeq:
    case CommandType::kAddi:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 15);
      break;

    case CommandType::kLi:
      if (GetBits(instr_code, 21, 25))
        throw std::runtime_error("Decoder: failed to identify the instruction");
      instr.r1_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 15);
      break;

    case CommandType::kStp:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.r3_ = DecodeReg3(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 10);
      break;

    case CommandType::kJ:
      instr.imm_ = GetBits(instr_code, 0, 25);
      break;

    case CommandType::kLdPost:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      if (GetBits(instr_code, 14, 15) != 0b10)
        throw std::runtime_error("Decoder: failed to identify the instruction");
      instr.imm_ = GetBits(instr_code, 0, 13);
      break;

    case CommandType::kSsat:
    case CommandType::kUsat:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 11, 15);
      if (GetBits(instr_code, 0, 10))
        throw std::runtime_error("Decoder: failed to identify the instruction");
      break;

    case CommandType::kRbit:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      if (GetBits(instr_code, 6, 15))
        throw std::runtime_error("Decoder: failed to identify the instruction");
      break;

    case CommandType::kSyscall:
      instr.imm_ = GetBits(instr_code, 6, 25);
      break;

    case CommandType::kUnknown:
    default:
      throw std::runtime_error("Decoder: failed to identify the instruction");
  }
  return instr;
}

BasicBlock Cpu::DecodeBB() {
  uint32_t pc = pc_;
  BasicBlock bb{};
  Instruction decoded{};
  do {
    decoded = Decode(memory_.Read(pc));
    bb.push_back(decoded);
    pc += sizeof(uint32_t);
  } while (decoded.type_ != CommandType::kJ &&
           decoded.type_ != CommandType::kBeq &&
           decoded.type_ != CommandType::kSyscall);
  return bb;
}

// ================================== EXECUTION ===============================

namespace {

inline int32_t SignExtend(uint32_t num, size_t n) {
  assert(n <= 32);
  n = 32 - n;
  return (static_cast<int32_t>(num << n) >> n);
}

inline uint32_t SaturateSigned(uint32_t num, size_t n) {
  assert(n <= 31);
  if (n == 0)
    return 0;
  int32_t min_n_int = -(1U << (n - 1));
  int32_t max_n_int = (1U << (n - 1)) - 1;
  return static_cast<int32_t>(num) > 0
             ? std::min<int32_t>(max_n_int, static_cast<int32_t>(num))
             : std::max<int32_t>(min_n_int, static_cast<int32_t>(num));
}

inline uint32_t SaturateUnsigned(uint32_t num, size_t n) {
  assert(n <= 32);
  uint32_t max_n_uint = ~0U >> (sizeof(uint32_t) * 8 - n);
  return std::min<uint32_t>(max_n_uint, num);
}

inline uint32_t ReverseBit(uint32_t num) {
  num = ((num & 0x55555555) << 1) | ((num & 0xAAAAAAAA) >> 1);
  num = ((num & 0x33333333) << 2) | ((num & 0xCCCCCCCC) >> 2);
  num = ((num & 0x0F0F0F0F) << 4) | ((num & 0xF0F0F0F0) >> 4);
  num = ((num & 0x00FF00FF) << 8) | ((num & 0xFF00FF00) >> 8);
  num = ((num & 0x0000FFFF) << 16) | ((num & 0xFFFF0000) >> 16);
  return num;
}

inline uint32_t BitExtract(uint32_t num, uint32_t mask) {
  uint32_t c = 0;
  uint32_t m = 1;
  while (mask) {
    uint32_t b = (mask) & (-mask);
    if (num & b)
      c |= m;
    mask -= b;
    m <<= 1;
  }
  return c;
}
}  // namespace

void Cpu::Execute(const Instruction instr) {
  switch (instr.type_) {
    case CommandType::kLd: {
      size_t addr = GetRegister(instr.r1_) + SignExtend(instr.imm_, 14);
      if (addr % sizeof(uint32_t))
        throw std::runtime_error("Executor: MisalignedAccess");
      SetRegister(instr.r2_, memory_.Read(addr));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kAdd: {
      SetRegister(instr.r3_, GetRegister(instr.r1_) + GetRegister(instr.r2_));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kBeq: {
      size_t offset = SignExtend(instr.imm_, 16) << 2;
      bool cond = GetRegister(instr.r1_) == GetRegister(instr.r2_);
      pc_ = cond ? pc_ + offset : pc_ + sizeof(uint32_t);
      break;
    }

    case CommandType::kLi: {
      SetRegister(instr.r1_, SignExtend(instr.imm_, 16));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kSt: {
      size_t addr = GetRegister(instr.r1_) + SignExtend(instr.imm_, 14);
      if (addr % sizeof(uint32_t))
        throw std::runtime_error("Executor: MisalignedAccess");
      memory_.Write(addr, GetRegister(instr.r2_));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kStp: {
      size_t addr = GetRegister(instr.r1_) + SignExtend(instr.imm_, 11);
      if (addr % sizeof(uint32_t))
        throw std::runtime_error("Executor: MisalignedAccess");
      memory_.Write(addr, GetRegister(instr.r2_));
      memory_.Write(addr + sizeof(uint32_t), GetRegister(instr.r3_));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kAddi: {
      SetRegister(instr.r2_,
                  GetRegister(instr.r1_) + SignExtend(instr.imm_, 16));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kJ: {
      pc_ = (pc_ & 0xF0000000) | (instr.imm_ << 2);
      break;
    }

    case CommandType::kLdPost: {
      if (GetRegister(instr.r1_) % sizeof(uint32_t))
        throw std::runtime_error("Executor: MisalignedAccess");
      SetRegister(instr.r2_, memory_.Read(GetRegister(instr.r1_)));
      SetRegister(instr.r1_,
                  GetRegister(instr.r1_) + SignExtend(instr.imm_, 14));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kNor: {
      SetRegister(instr.r3_,
                  ~(GetRegister(instr.r1_) | GetRegister(instr.r2_)));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kSsat: {
      SetRegister(instr.r1_,
                  SaturateSigned(GetRegister(instr.r2_), instr.imm_));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kRbit: {
      SetRegister(instr.r1_, ReverseBit(GetRegister(instr.r2_)));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kSyscall: {
      pc_ += sizeof(uint32_t);
      throw SyscallException(static_cast<Syscalls>(instr.imm_));
      break;
    }

    case CommandType::kBext: {
      SetRegister(instr.r1_,
                  BitExtract(GetRegister(instr.r2_), GetRegister(instr.r3_)));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kUsat: {
      SetRegister(instr.r1_,
                  SaturateUnsigned(GetRegister(instr.r2_), instr.imm_));
      pc_ += sizeof(uint32_t);
      break;
    }

    case CommandType::kUnknown:
    default:
      assert(0 && "Executor: Unknown instruction");
  }
}

}  // namespace toy_sim
