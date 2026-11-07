#ifndef CPU_HPP_
#define CPU_HPP_

#include <cstdint>
#include "cpu_state.hpp"
#include "decoder.hpp"
#include "encoding.hpp"
#include "executor.hpp"
#include "fetcher.hpp"
#include "llvm/jit.hpp"
#include "memory.hpp"

namespace toy_sim {

class Cpu {
 public:
  explicit Cpu(Memory& memory)
      : fetcher_(memory),
        decoder_(fetcher_),
        interpreter_(memory, cpu_state_),
        compiler_(decoder_.GetDecoderCache()),
        memory_(memory) {}

  void Execute() {
    for (;;) {
      DecodedBlock& bb = decoder_.Decode(cpu_state_.GetRegister(Register::kPc));
      ++bb.call_amount;
      if (bb.call_amount > kThreshold) {
        if (bb.compiled == nullptr) {
          bb.compiled = compiler_.Compile(bb);
        }
        if (bb.compiled(memory_.GetDataPtr(0), cpu_state_.GetRegisterPtr(),
                        cpu_state_.GetPcPtr()) ==
            static_cast<uint32_t>(CommandType::kSyscall))
          toy_sim::Executor::ExecuteInstr(cpu_state_, memory_,
                                          {.type_ = CommandType::kSyscall});
      } else {
        interpreter_.ExecuteBB(bb);
      }
    }
  }

  Memory& GetMemory() { return memory_; }
  CpuState& GetCpuState() { return cpu_state_; }

 private:
  static constexpr size_t kThreshold = 0;

  CpuState cpu_state_;
  Fetcher fetcher_;
  Decoder decoder_;
  Executor interpreter_;
  LLVMCompiler compiler_;

  Memory& memory_;
};

}  // namespace toy_sim

#endif  // CPU_HPP_
