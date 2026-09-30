#ifndef CPU_DECODER_HPP_
#define CPU_DECODER_HPP_

#include <cstdint>
#include <unordered_map>
#include <vector>
#include "encoding.hpp"
#include "cpu/fetcher.hpp"

namespace toy_sim {

using BasicBlock = std::vector<Instruction>;

class Decoder {
 public:
  explicit Decoder(Fetcher& fetcher) : fetcher_(fetcher){}

  static Instruction DecodeInstr(uint32_t instr);
  const BasicBlock& Decode(uint32_t pc);

 private:
  BasicBlock DecodeBB(uint32_t pc);
  Fetcher& fetcher_;
  std::unordered_map<uint32_t, BasicBlock> decoder_cache_;
};

}  // namespace toy_sim

#endif  // CPU_DECODER_HPP_
