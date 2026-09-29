#ifndef CPU_HPP_
#define CPU_HPP_

#include "cpu/cpu_state.hpp"
#include "cpu/decoder.hpp"
#include "cpu/executor.hpp"
#include "cpu/fetcher.hpp"
#include "encoding.hpp"
#include "fetcher.hpp"
#include "memory.hpp"

namespace toy_sim {

class Cpu {
 public:
  explicit Cpu(Memory& memory)
      : fetcher_(memory),
        decoder_(fetcher_),
        executor_(memory, cpu_state_),
        memory_(memory) {}

  void RunProgram() {
    for (;;) {
      const BasicBlock& bb =
          decoder_.Decode(cpu_state_.GetRegister(Register::kPc));
      executor_.ExecuteBB(bb);
    }
  }

  Memory& GetMemory() { return memory_; }
  CpuState& GetCpuState() { return cpu_state_; }

 private:
  CpuState cpu_state_;
  Fetcher fetcher_;
  Decoder decoder_;
  Executor executor_;

  Memory& memory_;
};

}  // namespace toy_sim

#endif  // CPU_HPP_
