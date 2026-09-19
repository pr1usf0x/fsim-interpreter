#ifndef CPU_HPP_
#define CPU_HPP_

#include <cstdint>
#include <memory>
#include <vector>
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

constexpr size_t kRegCount = 32;
struct Instruction {
  CommandType type_;
  Register r1_;
  Register r2_;
  Register r3_;
  Word imm_;
};

class Cpu {
 public:
  explicit Cpu(Memory& memory) : registers_(kRegCount), memory_(memory) {}
  void RunProgram();

  // setters
  void SetRegister(Register reg, Word value) {
    reg != Register::kPc ? registers_[static_cast<size_t>(reg)] = value
                         : pc_ = value;
  }
  // getters
  Word GetRegister(Register reg) {
    return reg != Register::kPc ? registers_[static_cast<size_t>(reg)] : pc_;
  }

 private:
  std::vector<Word> registers_;
  Word pc_{};

  Word Fetch();
  static Instruction Decode(Word instr);
  void Execute(Instruction instr);

  Memory& memory_;
};
}  // namespace toy_sim

#endif  // CPU_HPP_