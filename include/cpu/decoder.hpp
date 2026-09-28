#ifndef CPU_DECODER_HPP_
#define CPU_DECODER_HPP_

#include <cstdint>
#include <unordered_map>
#include <vector>
#include "encoding.hpp"

namespace toy_sim {

class Memory;

using BasicBlock = std::vector<Instruction>;
class Cpu;

class Decoder {
 public:
  explicit Decoder(Cpu& cpu) : cpu_(cpu){}

  static Instruction DecodeInstr(uint32_t instr);
  const BasicBlock& Decode(uint32_t pc);

 private:
  BasicBlock DecodeBB(uint32_t pc);
  Cpu& cpu_;
  std::unordered_map<uint32_t, BasicBlock> decoder_cache_;
};

}  // namespace toy_sim

#endif  // CPU_DECODER_HPP_
