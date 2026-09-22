#ifndef CPU_HPP_
#define CPU_HPP_

#include <cstdint>
#include <memory>
#include <vector>
#include <unordered_map>
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

  uint32_t Fetch();
  static Instruction Decode(uint32_t instr);
  void Execute(Instruction instr);

  Memory& memory_;

};
}  // namespace toy_sim

#endif  // CPU_HPP_