#ifndef CPU_DECODER_HPP_
#define CPU_DECODER_HPP_

#include <cstdint>
#include <unordered_map>
#include <vector>
#include "encoding.hpp"
#include "cpu/fetcher.hpp"

namespace toy_sim {

struct DecodedBlock {
  uint32_t pc;
  std::vector<Instruction> instructions;
};

using DecoderCache = std::unordered_map<uint32_t, DecodedBlock>;

class Decoder {
 public:
  explicit Decoder(Fetcher& fetcher) : fetcher_(fetcher){}

  static Instruction DecodeInstr(uint32_t instr);
  const DecodedBlock& Decode(uint32_t pc);

 private:
  DecodedBlock DecodeBB(uint32_t pc);
  Fetcher& fetcher_;
  DecoderCache decoder_cache_;
};

}  // namespace toy_sim

#endif  // CPU_DECODER_HPP_
