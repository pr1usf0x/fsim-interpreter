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
  // getters
  uint32_t GetRegister(Register reg) const {
    return reg != Register::kPc ? registers_[static_cast<size_t>(reg)] : pc_;
  }
 private:
  std::vector<uint32_t> registers_;
  uint32_t pc_{};
};
} // namespace toy_sim

#endif  // CPU_STATE_HPP_