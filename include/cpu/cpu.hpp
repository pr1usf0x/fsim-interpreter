#ifndef CPU_HPP_
#define CPU_HPP_

#include <array>
#include <cstdint>
#include <unordered_map>
#include <vector>
#include "cpu/decoder.hpp"
#include "cpu/executor.hpp"
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

class Cpu {
 public:
  explicit Cpu(Memory& memory) : registers_(kRegCount), memory_(memory) {}
  void RunProgram();
  void Step() { pc_ += sizeof(uint32_t); }

  // setters
  void SetRegister(Register reg, uint32_t value) {
    reg != Register::kPc ? registers_[static_cast<size_t>(reg)] = value
                         : pc_ = value;
  }
  // getters
  Memory& GetMemory() { return memory_; }

  uint32_t GetRegister(Register reg) const {
    return reg != Register::kPc ? registers_[static_cast<size_t>(reg)] : pc_;
  }

 private:
  std::vector<uint32_t> registers_;
  uint32_t pc_{};

  const BasicBlock& Fetch();

  Memory& memory_;
};

constexpr auto kHandlers = [] {
  using handler = void (*)(Cpu&, const Instruction*);
  std::array<handler, kInstructionCount> handler_arr = {};
  handler_arr[static_cast<size_t>(CommandType::kUnknown)] = ExecuteUnknown;
  handler_arr[static_cast<size_t>(CommandType::kLd)] = ExecuteLd;
  handler_arr[static_cast<size_t>(CommandType::kAdd)] = ExecuteAdd;
  handler_arr[static_cast<size_t>(CommandType::kBeq)] = ExecuteBeq;
  handler_arr[static_cast<size_t>(CommandType::kLi)] = ExecuteLi;
  handler_arr[static_cast<size_t>(CommandType::kSt)] = ExecuteSt;
  handler_arr[static_cast<size_t>(CommandType::kStp)] = ExecuteStp;
  handler_arr[static_cast<size_t>(CommandType::kAddi)] = ExecuteAddi;
  handler_arr[static_cast<size_t>(CommandType::kJ)] = ExecuteJ;
  handler_arr[static_cast<size_t>(CommandType::kLdPost)] = ExecuteLdPost;
  handler_arr[static_cast<size_t>(CommandType::kNor)] = ExecuteNor;
  handler_arr[static_cast<size_t>(CommandType::kSsat)] = ExecuteSsat;
  handler_arr[static_cast<size_t>(CommandType::kRbit)] = ExecuteRbit;
  handler_arr[static_cast<size_t>(CommandType::kSyscall)] = ExecuteSyscall;
  handler_arr[static_cast<size_t>(CommandType::kBext)] = ExecuteBext;
  handler_arr[static_cast<size_t>(CommandType::kUsat)] = ExecuteUsat;
  return handler_arr;
};
}  // namespace toy_sim

#endif  // CPU_HPP_
