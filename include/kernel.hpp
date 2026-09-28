#ifndef KERNEL_HPP_
#define KERNEL_HPP_

#include "cpu/cpu.hpp"
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {

enum class Syscalls : uint16_t {
  kScanUnsigned = 0,
  kPrintUnsigned = 1,
  kExit = 60,
  kAbort = 61,

  kReturnToExecution = 0xFFFF - 1,
  kUnknownSyscall = 0xFFFF,
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
