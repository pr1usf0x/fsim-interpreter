#ifndef ENCODING_HPP_
#define ENCODING_HPP_

#include <array>
#include <cstdint>
#include <cstdlib>

namespace toy_sim {

enum Opcode : uint8_t {
  kLd = 0b010111,
  kAdd = 0b000000,
  kBeq = 0b001101,
  kLi = 0b101011,
  kSt = 0b101100,
  kStp = 0b111111,
  kAddi = 0b001010,
  kJ = 0b110111,
  kLdPost = 0b000111,
  kNor = 0b000000,
  kSsat = 0b010100,
  kRbit = 0b000000,
  kSyscall = 0b000000,
  kBext = 0b000000,
  kUsat = 0b110000,
};

enum class CommandType {
  kUnknown,
  kLd,
  kAdd,
  kBeq,
  kLi,
  kSt,
  kStp,
  kAddi,
  kJ,
  kLdPost,
  kNor,
  kSsat,
  kRbit,
  kSyscall,
  kBext,
  kUsat
};
const size_t kInstructionCount = 16;

struct OpcodeExtra {
  uint32_t mask;
  uint32_t requirements;
};
constexpr const auto kOpcodeExtraArr = [] () {
  std::array<OpcodeExtra, kInstructionCount> extra_arr = {};
  extra_arr[static_cast<size_t>(CommandType::kUnknown)] = {
      .mask=0b00000000000000000000000000000000, .requirements=0b00000000000000000000000000000000};
  extra_arr[static_cast<size_t>(CommandType::kLd)] = {
      .mask=0b111111'00000'00000'11'00000000000000, .requirements=0b010111'00000'00000'00'00000000000000};
  extra_arr[static_cast<size_t>(CommandType::kAdd)] = {
      .mask=0b111111'00000'00000'00000'11111'111111, .requirements=0b000000'00000'00000'00000'00000'011000};
  extra_arr[static_cast<size_t>(CommandType::kBeq)] = {
      .mask=0b111111'00000'00000'0000000000000000, .requirements=0b001101'00000'00000'0000000000000000};
  extra_arr[static_cast<size_t>(CommandType::kLi)] = {
      .mask=0b111111'11111'00000'0000000000000000, .requirements=0b101011'00000'00000'0000000000000000};
  extra_arr[static_cast<size_t>(CommandType::kSt)] = {
      .mask=0b111111'00000'00000'11'00000000000000, .requirements=0b101100'00000'00000'00'00000000000000};
  extra_arr[static_cast<size_t>(CommandType::kStp)] = {
      .mask=0b111111'00000'00000'00000'00000000000, .requirements=0b111111'00000'00000'00000'00000000000};
  extra_arr[static_cast<size_t>(CommandType::kAddi)] = {
      .mask=0b111111'00000'00000'0000000000000000, .requirements=0b001010'00000'00000'0000000000000000};
  extra_arr[static_cast<size_t>(CommandType::kJ)] = {
      .mask=0b111111'00000000000000000000000000, .requirements=0b110111'00000000000000000000000000};
  extra_arr[static_cast<size_t>(CommandType::kLdPost)] = {
      .mask=0b111111'00000'00000'11'00000000000000, .requirements=0b000111'00000'00000'10'00000000000000};
  extra_arr[static_cast<size_t>(CommandType::kNor)] = {
      .mask=0b111111'00000'00000'00000'11111'111111, .requirements=0b000000'00000'00000'00000'00000'101001};
  extra_arr[static_cast<size_t>(CommandType::kSsat)] = {
      .mask=0b111111'00000'00000'00000'11111111111, .requirements=0b010100'00000'00000'00000'00000000000};
  extra_arr[static_cast<size_t>(CommandType::kRbit)] = {
      .mask=0b111111'00000'00000'1111111111'111111, .requirements=0b000000'00000'00000'0000000000'111110};
  extra_arr[static_cast<size_t>(CommandType::kSyscall)] = {
      .mask=0b111111'00000000000000000000'111111, .requirements=0b000000'00000000000000000000'010000};
  extra_arr[static_cast<size_t>(CommandType::kBext)] = {
      .mask=0b111111'00000'00000'00000'11111'111111, .requirements=0b000000'00000'00000'00000'00000'100110};
  extra_arr[static_cast<size_t>(CommandType::kUsat)] = {
      .mask=0b111111'00000'00000'00000'11111111111, .requirements=0b110000'00000'00000'00000'00000000000};
  return extra_arr;
};

constexpr bool CheckIfCommandType(uint16_t command_type) {
  switch (static_cast<CommandType>(command_type)) {
    case CommandType::kLd:
    case CommandType::kAdd:
    case CommandType::kBeq:
    case CommandType::kLi:
    case CommandType::kSt:
    case CommandType::kStp:
    case CommandType::kAddi:
    case CommandType::kJ:
    case CommandType::kLdPost:
    case CommandType::kNor:
    case CommandType::kSsat:
    case CommandType::kRbit:
    case CommandType::kSyscall:
    case CommandType::kBext:
    case CommandType::kUsat:
      return true;
    default:
      return false;
  }
}

constexpr size_t kRegCount = 32;
enum class Register : uint8_t {
  kX0 = 0,
  kX1 = 1,
  kX2 = 2,
  kX3 = 3,
  kX4 = 4,
  kX5 = 5,
  kX6 = 6,
  kX7 = 7,
  kX8 = 8,
  kX9 = 9,
  kX10 = 10,
  kX11 = 11,
  kX12 = 12,
  kX13 = 13,
  kX14 = 14,
  kX15 = 15,
  kX16 = 16,
  kX17 = 17,
  kX18 = 18,
  kX19 = 19,
  kX20 = 20,
  kX21 = 21,
  kX22 = 22,
  kX23 = 23,
  kX24 = 24,
  kX25 = 25,
  kX26 = 26,
  kX27 = 27,
  kX28 = 28,
  kX29 = 29,
  kX30 = 30,
  kX31 = 31,
  kPc = 32
};

struct Instruction {
  CommandType type_;
  Register r1_;
  Register r2_;
  Register r3_;
  uint32_t imm_;
};
}  // namespace toy_sim

#endif  // ENCODING_HPP_
