#ifndef CPU_HPP_
#define CPU_HPP_

#include <cstdint>
#include <unordered_map>
#include "cpu_state.hpp"
#include "decoder.hpp"
#include "encoding.hpp"
#include "executor.hpp"
#include "fetcher.hpp"
#include "llvm/jit.hpp"
#include "memory.hpp"
#include "transitions.hpp"

namespace toy_sim {

class Cpu {
 public:

  using Transition = toy_sim::Transition;
  using TransitionTable = toy_sim::TransitionTable;

  explicit Cpu(Memory& memory, size_t threshold)
      : fetcher_(memory),
        decoder_(fetcher_),
        interpreter_(memory, cpu_state_),
#ifndef NO_JIT
        threshold_(threshold),
        jit_(decoder_.GetDecoderCache(), transitions_),
#endif  // NO_JIT
        memory_(memory) {
  }

  void Execute() {
    for (;;) {
      uint32_t pc = cpu_state_.GetRegister(Register::kPc);
      DecodedBlock& bb = decoder_.Decode(pc);
      ++bb.call_amount;
#ifndef NO_JIT
      if (bb.call_amount > threshold_) {
        auto compiled = jit_.GetCompiled(pc);
        if (compiled(memory_.GetDataPtr(0), cpu_state_.GetRegisterPtr(),
                     cpu_state_.GetPcPtr()) ==
            static_cast<uint32_t>(CommandType::kSyscall))
          toy_sim::Executor::ExecuteInstr(cpu_state_, memory_,
                                          {.type_ = CommandType::kSyscall});
      } else {
        interpreter_.ExecuteBB(bb);
        const uint32_t pc_after = cpu_state_.GetRegister(Register::kPc);
        auto& transition = transitions_[pc];
        (cpu_state_.IsBranchTaken() ? transition.taken : transition.not_taken) =
            pc_after;
      }
#else
        interpreter_.ExecuteBB(bb);
#endif  // NO_JIT
    }
  }

  Memory& GetMemory() { return memory_; }
  CpuState& GetCpuState() { return cpu_state_; }

 private:
  CpuState cpu_state_;
  Fetcher fetcher_;
  Decoder decoder_;
#ifndef NO_JIT
  TransitionTable transitions_;
#endif  // NO_JIT
  Executor interpreter_;
#ifndef NO_JIT
  size_t threshold_;
  LLVMCompiler jit_;
#endif  // NO_JIT

  Memory& memory_;
};

}  // namespace toy_sim

#endif  // CPU_HPP_
