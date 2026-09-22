#ifndef MICROASM_HPP_
#define MICROASM_HPP_

#include <cassert>
#include <cstddef>
#include <cstdint>
#include "encoding.hpp"

namespace toy_sim {

// ================================ HELPERS ===================================

constexpr uint32_t GenOpCode(Opcode op) {
  return static_cast<uint32_t>(op) << 26;
}
constexpr uint32_t GenReg1(Register reg) {
  assert(static_cast<uint32_t>(reg) < 32);
  return static_cast<uint32_t>(reg) << 21;
}

constexpr uint32_t GenReg2(Register reg) {
  assert(static_cast<uint32_t>(reg) < 32);
  return static_cast<uint32_t>(reg) << 16;
}

constexpr uint32_t GenReg3(Register reg) {
  assert(static_cast<uint32_t>(reg) < 32);
  return static_cast<uint32_t>(reg) << 11;
}

constexpr uint32_t GenBits(uint32_t bits, std::size_t low_b, std::size_t up_b) {
  assert(up_b < 8 * sizeof(bits));
  assert(low_b < 8 * sizeof(bits));
  assert(low_b <= up_b);

  std::size_t n = up_b - low_b + 1;
  uint32_t mask = (~uint32_t{0}) >> (8 * sizeof(bits) - n);
  return (bits & mask) << low_b;
}

// ================================ GENERATORS ================================

constexpr uint32_t GenLdInstr(Register base, Register rt, uint32_t imm) {
  return GenOpCode(kLd) | GenReg1(base) | GenReg2(rt) | GenBits(0b00, 14, 15) |
         GenBits(imm, 0, 13);
}

constexpr uint32_t GenAddInstr(Register rs, Register rt, Register rd) {
  return GenOpCode(kAdd) | GenReg1(rs) | GenReg2(rt) | GenReg3(rd) |
         GenBits(0b00000, 6, 10) | GenBits(0b011000, 0, 5);
}

constexpr uint32_t GenBeqInstr(Register rs, Register rt, uint32_t offset) {
  return GenOpCode(kBeq) | GenReg1(rs) | GenReg2(rt) | GenBits(offset, 0, 15);
}

constexpr uint32_t GenLiInstr(Register rt, uint32_t imm) {
  return GenOpCode(kLi) | GenBits(0b00000, 21, 25) | GenReg2(rt) |
         GenBits(imm, 0, 15);
}

constexpr uint32_t GenStInstr(Register base, Register rt, uint32_t imm) {
  return GenOpCode(kSt) | GenReg1(base) | GenReg2(rt) | GenBits(0b00, 14, 15) |
         GenBits(imm, 0, 13);
}

constexpr uint32_t GenStpInstr(Register base, Register rt1, Register rt2,
                               uint32_t offset) {
  return GenOpCode(kStp) | GenReg1(base) | GenReg2(rt1) | GenReg3(rt2) |
         GenBits(offset, 0, 10);
}

constexpr uint32_t GenAddiInstr(Register rs, Register rt, uint32_t imm) {
  return GenOpCode(kAddi) | GenReg1(rs) | GenReg2(rt) | GenBits(imm, 0, 15);
}

constexpr uint32_t GenJInstr(uint32_t instr_index) {
  return GenOpCode(kJ) | GenBits(instr_index, 0, 25);
}

constexpr uint32_t GenLdPostInstr(Register base, Register rt, uint32_t imm) {
  return GenOpCode(kLdPost) | GenReg1(base) | GenReg2(rt) |
         GenBits(0b10, 14, 15) | GenBits(imm, 0, 13);
}

constexpr uint32_t GenNorInstr(Register rs, Register rt, Register rd) {
  return GenOpCode(kNor) | GenReg1(rs) | GenReg2(rt) | GenReg3(rd) |
         GenBits(0b101001, 0, 5);
}

constexpr uint32_t GenSsatInstr(Register rd, Register rs, uint32_t imm) {
  return GenOpCode(kSsat) | GenReg1(rd) | GenReg2(rs) | GenBits(imm, 11, 15);
}

constexpr uint32_t GenRbitInstr(Register rd, Register rs) {
  return GenOpCode(kRbit) | GenReg1(rd) | GenReg2(rs) | GenBits(0b111110, 0, 5);
}

constexpr uint32_t GenSyscallInstr(uint32_t code) {
  return GenOpCode(kSyscall) | GenBits(code, 6, 25) | GenBits(0b010000, 0, 5);
}

constexpr uint32_t GenBextInstr(Register rd, Register rs1, Register rs2) {
  return GenOpCode(kBext) | GenReg1(rd) | GenReg2(rs1) | GenReg3(rs2) |
         GenBits(0b100110, 0, 5);
}

constexpr uint32_t GenUsatInstr(Register rd, Register rs, uint32_t imm) {
  return GenOpCode(kUsat) | GenReg1(rd) | GenReg2(rs) | GenBits(imm, 11, 15);
}

}  // namespace toy_sim

#endif  // MICROASM_HPP_
