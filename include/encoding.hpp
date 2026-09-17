#ifndef ENCODING_HPP_
#define ENCODING_HPP_

namespace toy_sim {
enum class reg {
  kX0 = 0b00000,
  kX1 = 0b00001,
  kX2 = 0b00010,
  kX3 = 0b00011,
  kX4 = 0b00100,
  kX5 = 0b00101,
  kX6 = 0b00110,
  kX7 = 0b00111,
  kX8 = 0b01000,
  kX9 = 0b01001,
  kX10 = 0b01010,
  kX11 = 0b01011,
  kX12 = 0b01100,
  kX13 = 0b01101,
  kX14 = 0b01110,
  kX15 = 0b01111,
  kX16 = 0b10000,
  kX17 = 0b10001,
  kX18 = 0b10010,
  kX19 = 0b10011,
  kX20 = 0b10100,
  kX21 = 0b10101,
  kX22 = 0b10110,
  kX23 = 0b10111,
  kX24 = 0b11000,
  kX25 = 0b11001,
  kX26 = 0b11010,
  kX27 = 0b11011,
  kX28 = 0b11100,
  kX29 = 0b11101,
  kX30 = 0b11110,
  kX31 = 0b11111
};

enum class op_codes {
  kNop = 0b000000,
  kLd = 0b010111,
  kAdd = 0b000000,
  kBeq = 0b001101,
  kLi = 0b101011,
  kSt = 0b101100,
  kStp = 0b111111,
  kAddi = 0b001010,
  kJ = 0b110111,
  kLdPostIndex = 0b000111,
  kNor = 0b000000,
  kSsat = 0b010100,
  kRbit = 0b000000,
  kSyscall = 0b000000,
  kBext = 0b000000,
  kUsat = 0b110000
};
}  // namespace toy_sim

#endif  // ENCODING_HPP_
