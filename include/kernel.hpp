#ifndef KERNEL_HPP_
#define KERNEL_HPP_

#include "cpu.hpp"

namespace toy_sim {

enum class Syscalls {
  kReturnToExecution = 0,
  kUnknownSyscall = 1,
  kPrintUnsigned = 2,
  kAbort = 3,
  kExit = 67,
};

struct SyscallException {
  Syscalls syscall;
};

class Kernel {
 public:
  explicit Kernel(Cpu& cpu) : cpu_(cpu) {}

  Syscalls HandleSyscall(SyscallException exception);

 private:
  toy_sim::Cpu& cpu_;
};
}  // namespace toy_sim

#endif  // KERNEL_HPP_