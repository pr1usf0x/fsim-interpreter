#ifndef CPU_DECODER_HPP_
#define CPU_DECODER_HPP_

#include <cstdint>
#include <unordered_map>
#include <vector>
#include "encoding.hpp"
#include "cpu/fetcher.hpp"

namespace toy_sim {

using block_func = uint32_t (*)(std::byte* , uint32_t*, uint32_t*);
struct DecodedBlock {
  uint32_t pc;
  std::vector<Instruction> instructions;
  size_t call_amount;
  block_func compiled = nullptr;
};

using DecoderCache = std::unordered_map<uint32_t, DecodedBlock>;

class Decoder {
 public:
  explicit Decoder(Fetcher& fetcher) : fetcher_(fetcher){}

  static Instruction DecodeInstr(uint32_t instr);
  DecodedBlock& Decode(uint32_t pc);
  DecoderCache& GetDecoderCache() { return decoder_cache_; }

 private:
  DecodedBlock DecodeBB(uint32_t pc);
  Fetcher& fetcher_;
  DecoderCache decoder_cache_;
};

}  // namespace toy_sim

#endif  // CPU_DECODER_HPP_
