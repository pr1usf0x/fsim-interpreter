#ifndef CPU_DECODER_HPP_
#define CPU_DECODER_HPP_

#include <cstdint>
#include <vector>
#include "encoding.hpp"

namespace toy_sim {

class Memory;

struct Instruction {
  CommandType type_;
  Register r1_;
  Register r2_;
  Register r3_;
  uint32_t imm_;
};

using BasicBlock = std::vector<Instruction>;

Instruction Decode(uint32_t instr);
BasicBlock DecodeBB(Memory& memory, uint32_t pc);

}  // namespace toy_sim

#endif  // CPU_DECODER_HPP_
