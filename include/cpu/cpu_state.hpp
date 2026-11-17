#ifndef CPU_STATE_HPP_
#define CPU_STATE_HPP_

#include <cstdint>
#include <vector>
#include "encoding.hpp"

namespace toy_sim {
class CpuState {
 public:
  CpuState() : registers_(kRegCount) {}

  void Step() { pc_ += sizeof(uint32_t); }
  // setters
  void SetRegister(Register reg, uint32_t value) {
    reg != Register::kPc ? registers_[static_cast<size_t>(reg)] = value
                         : pc_ = value;
  }
  void SetBranchTaken(bool taken) { branch_taken_ = taken; }
  // getters
  uint32_t GetRegister(Register reg) const {
    return reg != Register::kPc ? registers_[static_cast<size_t>(reg)] : pc_;
  }
  uint32_t* GetRegisterPtr() { return registers_.data(); }
  uint32_t* GetPcPtr() { return &pc_; }
  bool IsBranchTaken() const { return branch_taken_; }

 private:
  std::vector<uint32_t> registers_;
  uint32_t pc_{};
  bool branch_taken_{};
};
}  // namespace toy_sim

#endif  // CPU_STATE_HPP_