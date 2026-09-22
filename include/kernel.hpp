#ifndef KERNEL_HPP_
#define KERNEL_HPP_

#include "cpu.hpp"
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

enum class Syscalls {
  kReturnToExecution = 0,
  kUnknownSyscall = 1,
  kPrintUnsigned = 2,
  kScanUnsigned = 3,
  kAbort = 4,
  kExit = 67,
};

struct SyscallException {
  Syscalls syscall;
};

class Kernel {
 public:
  explicit Kernel(Cpu& cpu, Memory& memory) : cpu_(cpu), memory_(memory) {}

  Syscalls HandleSyscall(Syscalls syscall);
  void MmapFile(const std::string& filename, uint32_t addr);

 private:
  Cpu& cpu_;
  Memory& memory_;
};
}  // namespace toy_sim

#endif  // KERNEL_HPP_