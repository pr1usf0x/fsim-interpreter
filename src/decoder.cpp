#include "cpu/decoder.hpp"
#include <cassert>
#include <cstdint>
#include <stdexcept>
#include "cpu/cpu.hpp"
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

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

bool CheckIfCommand(uint32_t word, CommandType type) {
  const auto full_opcode = kOpcodeExtraArr()[static_cast<size_t>(type)];
  return (word & full_opcode.mask) == full_opcode.requirements;
}

const uint8_t kFuncMask = 0b00111111;
CommandType GetFuncType(uint32_t word) {
  switch (word & kFuncMask) {
    case (kOpcodeExtraArr())[static_cast<size_t>(CommandType::kRbit)]
        .requirements& kFuncMask:
    return CommandType::kRbit;

    case (kOpcodeExtraArr())[static_cast<size_t>(CommandType::kNor)]
        .requirements& kFuncMask:
    return CommandType::kNor;

    case (kOpcodeExtraArr())[static_cast<size_t>(CommandType::kSyscall)]
        .requirements& kFuncMask:
    return CommandType::kSyscall;

    case (kOpcodeExtraArr())[static_cast<size_t>(CommandType::kBext)]
        .requirements& kFuncMask:
    return CommandType::kBext;

    case (kOpcodeExtraArr())[static_cast<size_t>(CommandType::kAdd)]
        .requirements& kFuncMask:
    return CommandType::kAdd;

    default:
      return CommandType::kUnknown;
  }
}

CommandType GetCommandType(uint32_t word) {
  auto opcode = GetBits(word, 26, 31);
  CommandType command_type = CommandType::kUnknown;
  switch (opcode) {
    case kLd:
    case kLdPost:
      if (CheckIfCommand(word, CommandType::kLd))
        return CommandType::kLd;
      else if (CheckIfCommand(word, CommandType::kLdPost))
        return CommandType::kLdPost;
      else
        return CommandType::kUnknown;
      break;
    case kAddi:
      command_type = CommandType::kAddi;
      break;
    case kBeq:
      command_type = CommandType::kBeq;
      break;
    case kSsat:
      command_type = CommandType::kSsat;
      break;
    case kLi:
      command_type = CommandType::kLi;
      break;
    case kSt:
      command_type = CommandType::kSt;
      break;
    case kUsat:
      command_type = CommandType::kUsat;
      break;
    case kJ:
      command_type = CommandType::kJ;
      break;
    case kStp:
      command_type = CommandType::kStp;
      break;
    case kRbit: { // всякая такая дичь
      command_type = GetFuncType(word);
      break;
    }
    default:
      return CommandType::kUnknown;
  }

  return CheckIfCommand(word, command_type) ? command_type
                                            : CommandType::kUnknown;
}

bool CheckIfTerminator(Instruction decoded) {
  return decoded.type_ == CommandType::kJ ||
         decoded.type_ == CommandType::kBeq ||
         decoded.type_ == CommandType::kSyscall;
}
}  // namespace

// ================================ DECODER ===================================

Instruction Decoder::DecodeInstr(uint32_t instr_code) {
  auto command_type = GetCommandType(instr_code);
  Instruction instr{};
  instr.type_ = command_type;
  switch (command_type) {
    case CommandType::kLd:
    case CommandType::kSt:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 13);
      break;

    case CommandType::kAdd:
    case CommandType::kNor:
    case CommandType::kBext:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.r3_ = DecodeReg3(instr_code);
      break;

    case CommandType::kBeq:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 15) << 2;
      break;

    case CommandType::kAddi:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 0, 15);
      break;

    case CommandType::kLi:
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
      instr.imm_ = GetBits(instr_code, 0, 13);
      break;

    case CommandType::kSsat:
    case CommandType::kUsat:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
      instr.imm_ = GetBits(instr_code, 11, 15);
      break;

    case CommandType::kRbit:
      instr.r1_ = DecodeReg1(instr_code);
      instr.r2_ = DecodeReg2(instr_code);
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

BasicBlock Decoder::DecodeBB(uint32_t pc) {
  BasicBlock bb{};
  Instruction decoded{};
  do {
    decoded = DecodeInstr(cpu_.GetMemory().Read(pc));
    bb.push_back(decoded);
    pc += sizeof(uint32_t);
  } while (!CheckIfTerminator(decoded));
  return bb;
}

const BasicBlock& Decoder::Decode(uint32_t pc) {
  auto bb = decoder_cache_.find(pc);
  if (bb == decoder_cache_.end()) {
    auto decoded_bb = DecodeBB(pc);
    bb = decoder_cache_.insert(std::make_pair(pc, std::move(decoded_bb))).first;
  }
  return bb->second;
}
}  // namespace toy_sim
