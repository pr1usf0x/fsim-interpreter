#ifndef CPU_HPP_
#define CPU_HPP_

#include <cstdint>
#include <memory>
#include <unordered_map>
#include <utility>
#include <vector>
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

struct Instruction {
  CommandType type_;
  Register r1_;
  Register r2_;
  Register r3_;
  uint32_t imm_;
};

using BasicBlock = std::vector<Instruction>;

constexpr size_t kDecoderCacheSize = 30;
class Cpu {
 public:
  explicit Cpu(Memory& memory) : registers_(kRegCount), memory_(memory) {}
  void RunProgram();

  // setters
  void SetRegister(Register reg, uint32_t value) {
    reg != Register::kPc ? registers_[static_cast<size_t>(reg)] = value
                         : pc_ = value;
  }
  // getters
  uint32_t GetRegister(Register reg) const {
    return reg != Register::kPc ? registers_[static_cast<size_t>(reg)] : pc_;
  }

#ifndef ENABLE_TEST
 private:
#endif

  std::vector<uint32_t> registers_;
  uint32_t pc_{};

  const BasicBlock& Fetch();
  BasicBlock DecodeBB();
  static Instruction Decode(uint32_t instr);
  void Execute(Instruction instr);

  Memory& memory_;
  std::unordered_map<uint32_t, BasicBlock> decoder_cache_;
};
}  // namespace toy_sim

#endif  // CPU_HPP_