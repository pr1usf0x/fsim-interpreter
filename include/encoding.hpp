#ifndef ENCODING_HPP_
#define ENCODING_HPP_

#include <cstdint>
#include <cstdlib>

namespace toy_sim {

using uint32_t = uint32_t;

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

constexpr uint16_t ConvertToCommandType(uint8_t opcode, uint8_t funct) {
  return (static_cast<uint16_t>(opcode) << 6) | static_cast<uint16_t>(funct);
}
enum class CommandType : uint16_t {
  kUnknown = ConvertToCommandType(0b000000, 0b000000),
  kLd = ConvertToCommandType(0b010111, 0b000000),
  kAdd = ConvertToCommandType(0b000000, 0b011000),
  kBeq = ConvertToCommandType(0b001101, 0b000000),
  kLi = ConvertToCommandType(0b101011, 0b000000),
  kSt = ConvertToCommandType(0b101100, 0b000000),
  kStp = ConvertToCommandType(0b111111, 0b000000),
  kAddi = ConvertToCommandType(0b001010, 0b000000),
  kJ = ConvertToCommandType(0b110111, 0b000000),
  kLdPost = ConvertToCommandType(0b000111, 0b000000),
  kNor = ConvertToCommandType(0b000000, 0b101001),
  kSsat = ConvertToCommandType(0b010100, 0b000000),
  kRbit = ConvertToCommandType(0b000000, 0b111110),
  kSyscall = ConvertToCommandType(0b000000, 0b010000),
  kBext = ConvertToCommandType(0b000000, 0b100110),
  kUsat = ConvertToCommandType(0b110000, 0b000000),
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
}  // namespace toy_sim

#endif  // ENCODING_HPP_
