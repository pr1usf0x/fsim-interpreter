#include "kernel.hpp"
#include <iostream>
#include "encoding.hpp"

namespace toy_sim {
namespace {
uint32_t PrintUnsigned(uint32_t num) {
  std::cout << num << "\n";
  return 0;
}
}  // namespace

Syscalls Kernel::HandleSyscall(SyscallException exception) {
  switch (exception.syscall) {
    case Syscalls::kPrintUnsigned:
      PrintUnsigned(cpu_.GetRegister(Register::kX1));
      return Syscalls::kReturnToExecution;

    case Syscalls::kExit:
      return Syscalls::kExit;
    case Syscalls::kAbort:
      return Syscalls::kAbort;
    case Syscalls::kUnknownSyscall:
    default:
      return Syscalls::kUnknownSyscall;
  }
}

}  // namespace toy_sim