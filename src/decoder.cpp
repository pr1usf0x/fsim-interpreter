#include "cpu/decoder.hpp"
#include <cassert>
#include <stdexcept>
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

bool CheckIfTerminator(Instruction decoded) {
  return decoded.type_ == CommandType::kJ ||
         decoded.type_ == CommandType::kBeq ||
         decoded.type_ == CommandType::kSyscall;
}
}  // namespace

// ================================ DECODER ===================================

Instruction Decode(uint32_t instr_code) {
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

BasicBlock DecodeBB(Memory& memory, uint32_t pc) {
  BasicBlock bb{};
  Instruction decoded{};
  do {
    decoded = Decode(memory.Read(pc));
    bb.push_back(decoded);
    pc += sizeof(uint32_t);
  } while (!CheckIfTerminator(decoded));
  return bb;
}
}  // namespace toy_sim
