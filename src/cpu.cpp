#include "cpu.hpp"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <utility>
#include "encoding.hpp"
#include "kernel.hpp"

#define DISPATCH() [[clang:.musttail]] \ return (handlers[memory[pc]])()

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

void Cpu::Step() {
  pc_ += sizeof(uint32_t);
}

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

void CheckAlignment(size_t addr) {
  if (addr % sizeof(uint32_t))
    throw std::runtime_error("Executor: MisalignedAccess");
}

void ExecuteLoad(Cpu& cpu, Instruction instr) {
  size_t addr = cpu.GetRegister(instr.r1_) + SignExtend(instr.imm_, 14);
  CheckAlignment(addr);
  cpu.SetRegister(instr.r2_, cpu.GetMemory().Read(addr));
  cpu.Step();
}

void ExecuteStore(Cpu& cpu, Instruction instr) {
  size_t addr = cpu.GetRegister(instr.r1_) + SignExtend(instr.imm_, 14);
  CheckAlignment(addr);
  cpu.GetMemory().Write(addr, cpu.GetRegister(instr.r2_));
  cpu.Step();
}

void ExecuteStorePair(Cpu& cpu, Instruction instr) {
  size_t addr = cpu.GetRegister(instr.r1_) + SignExtend(instr.imm_, 11);
  CheckAlignment(addr);
  cpu.GetMemory().Write(addr, cpu.GetRegister(instr.r2_));
  cpu.GetMemory().Write(addr + sizeof(uint32_t), cpu.GetRegister(instr.r3_));
  cpu.Step();
}

void ExecuteLoadPost(Cpu& cpu, Instruction instr) {
  CheckAlignment(cpu.GetRegister(instr.r1_));
  cpu.SetRegister(instr.r2_, cpu.GetMemory().Read(cpu.GetRegister(instr.r1_)));
  cpu.SetRegister(instr.r1_,
                  cpu.GetRegister(instr.r1_) + SignExtend(instr.imm_, 14));
  cpu.Step();
}

void ExecuteAdd(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r3_,
                  cpu.GetRegister(instr.r1_) + cpu.GetRegister(instr.r2_));
  cpu.Step();
}

void ExecuteBranchEqual(Cpu& cpu, Instruction instr) {
  size_t offset = SignExtend(instr.imm_, 16) << 2;
  bool cond = cpu.GetRegister(instr.r1_) == cpu.GetRegister(instr.r2_);
  if (cond) {
    cpu.SetRegister(Register::kPc, cpu.GetRegister(Register::kPc) + offset);
  } else {
    cpu.Step();
  }
}

void ExecuteLoadImmediate(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r1_, SignExtend(instr.imm_, 16));
  cpu.Step();
}

void ExecuteAddImmediate(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r2_,
                  cpu.GetRegister(instr.r1_) + SignExtend(instr.imm_, 16));
  cpu.Step();
}

void ExecuteJump(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(Register::kPc, (cpu.GetRegister(Register::kPc) & 0xF0000000) |
                                     (instr.imm_ << 2));
}

void ExecuteNor(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r3_,
                  ~(cpu.GetRegister(instr.r1_) | cpu.GetRegister(instr.r2_)));
  cpu.Step();
}

void ExecuteSaturateSigned(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r1_,
                  SaturateSigned(cpu.GetRegister(instr.r2_), instr.imm_));
  cpu.Step();
}

void ExecuteReverseBit(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r1_, ReverseBit(cpu.GetRegister(instr.r2_)));
  cpu.Step();
}

[[noreturn]] void ExecuteSyscall(Cpu& cpu, Instruction instr) {
  cpu.Step();
  throw SyscallException(static_cast<Syscalls>(instr.imm_));
}

void ExecuteBitExtract(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r1_, BitExtract(cpu.GetRegister(instr.r2_),
                                        cpu.GetRegister(instr.r3_)));
  cpu.Step();
}

void ExecuteSaturateUnsigned(Cpu& cpu, Instruction instr) {
  cpu.SetRegister(instr.r1_,
                  SaturateUnsigned(cpu.GetRegister(instr.r2_), instr.imm_));
  cpu.Step();
}
}  // namespace

void Cpu::Execute(Instruction instr) {
  switch (instr.type_) {
    case CommandType::kLd:
      ExecuteLoad(*this, instr);
      break;
    case CommandType::kAdd:
      ExecuteAdd(*this, instr);
      break;
    case CommandType::kBeq:
      ExecuteBranchEqual(*this, instr);
      return;
    case CommandType::kLi:
      ExecuteLoadImmediate(*this, instr);
      break;
    case CommandType::kSt:
      ExecuteStore(*this, instr);
      break;
    case CommandType::kStp:
      ExecuteStorePair(*this, instr);
      break;
    case CommandType::kAddi:
      ExecuteAddImmediate(*this, instr);
      break;
    case CommandType::kJ:
      ExecuteJump(*this, instr);
      return;
    case CommandType::kLdPost:
      ExecuteLoadPost(*this, instr);
      break;
    case CommandType::kNor:
      ExecuteNor(*this, instr);
      break;
    case CommandType::kSsat:
      ExecuteSaturateSigned(*this, instr);
      break;
    case CommandType::kRbit:
      ExecuteReverseBit(*this, instr);
      break;
    case CommandType::kSyscall:
      ExecuteSyscall(*this, instr);
    case CommandType::kBext:
      ExecuteBitExtract(*this, instr);
      break;
    case CommandType::kUsat:
      ExecuteSaturateUnsigned(*this, instr);
      break;
    case CommandType::kUnknown:
    default:
      assert(0 && "Executor: Unknown instruction");
      return;
  }
}

}  // namespace toy_sim

#undef DISPATCH