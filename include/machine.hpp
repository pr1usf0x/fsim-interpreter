#ifndef MACHINE_HPP_
#define MACHINE_HPP_

#include <cassert>
#include "cpu.hpp"
#include "encoding.hpp"
#include "kernel.hpp"
#include "memory.hpp"

namespace toy_sim {

const uint32_t kDefaultStart = 0;
class Machine {
 public:
  explicit Machine(size_t mem_size)
      : memory_(mem_size), cpu_(memory_), kernel_(cpu_, memory_) {};

  uint32_t RunProgram(const std::string& filename) {
    kernel_.MmapFile(filename, kDefaultStart);
    cpu_.SetRegister(Register::kPc, kDefaultStart);
    for (;;) {
      try {
        cpu_.RunProgram();
      } catch (const SyscallException& e) {
        switch (kernel_.HandleSyscall(e.syscall)) {
          case Syscalls::kReturnToExecution:
            break;
          case Syscalls::kExit:
            return cpu_.GetRegister(Register::kX1);
          case Syscalls::kAbort:  // ADD core dump
            return 0;
          default:
            assert(0);
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