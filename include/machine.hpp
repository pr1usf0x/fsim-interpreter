#ifndef MACHINE_HPP_
#define MACHINE_HPP_

#include <cassert>
#include <cstdint>
#include <string_view>
#include "cpu/cpu.hpp"
#include "encoding.hpp"
#include "kernel.hpp"
#include "memory.hpp"

namespace toy_sim {

class Machine {
 public:
  explicit Machine(size_t mem_size)
      : memory_(mem_size), cpu_(memory_), kernel_(cpu_, memory_) {};

  uint32_t RunProgram(std::string_view file) {
    uint32_t start_addr = kernel_.MmapFile(file);
    cpu_.GetCpuState().SetRegister(Register::kPc, start_addr);
    for (;;) {
      try {
        cpu_.Execute();
      } catch (const SyscallException& e) {
        switch (kernel_.HandleSyscall(e.syscall)) {
          case SyscallNum::kReturnToExecution:
            break;
          case SyscallNum::kExit:
            return cpu_.GetCpuState().GetRegister(Register::kX1);
          case SyscallNum::kAbort:  // ADD core dump
            return 0;
          case SyscallNum::kUnknownSyscall:
          default:
            return 0; // tmp
        }
      }
    }
  }

 private:
  Memory memory_;
  Cpu cpu_;
  Kernel kernel_;
};
}  // namespace toy_sim

#endif  // MACHINE_HPP_