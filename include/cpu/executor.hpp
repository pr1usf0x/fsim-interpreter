#ifndef CPU_EXECUTOR_HPP_
#define CPU_EXECUTOR_HPP_

#include "cpu/cpu_state.hpp"
#include "cpu/decoder.hpp"
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

class Executor {
 public:
  explicit Executor(Memory& memory, CpuState& cpu_state)
      : memory_(memory), cpu_state_(cpu_state) {}
  void ExecuteBB(const BasicBlock& bb) {
    return GetNextHandler(bb.front().type_)(cpu_state_, memory_, bb.data());
  }
  void static ExecuteInstr(CpuState& cpu_state, Memory& memory, Instruction instr);
  using handler = void (*)(CpuState&, Memory&, const Instruction*);

 private:
  static void ExecuteLd(CpuState&, Memory&, const Instruction*);
  static void ExecuteSt(CpuState&, Memory&, const Instruction*);
  static void ExecuteStp(CpuState&, Memory&, const Instruction*);
  static void ExecuteLdPost(CpuState&, Memory&, const Instruction*);
  static void ExecuteAdd(CpuState&, Memory&, const Instruction*);
  static void ExecuteBeq(CpuState&, Memory&, const Instruction*);
  static void ExecuteLi(CpuState&, Memory&, const Instruction*);
  static void ExecuteAddi(CpuState&, Memory&, const Instruction*);
  static void ExecuteJ(CpuState&, Memory&, const Instruction*);
  static void ExecuteNor(CpuState&, Memory&, const Instruction*);
  static void ExecuteSsat(CpuState&, Memory&, const Instruction*);
  static void ExecuteRbit(CpuState&, Memory&, const Instruction*);
  static void ExecuteSyscall(CpuState&, Memory&, const Instruction*);
  static void ExecuteBext(CpuState&, Memory&, const Instruction*);
  static void ExecuteUsat(CpuState&, Memory&, const Instruction*);
  static void ExecuteUnknown(CpuState&, Memory&, const Instruction*);

  static handler GetNextHandler(CommandType type) {
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
    return handler_arr[static_cast<size_t>(type)];
  };

  Memory& memory_;
  CpuState& cpu_state_;
};
}  // namespace toy_sim

#endif  // CPU_EXECUTOR_HPP_
