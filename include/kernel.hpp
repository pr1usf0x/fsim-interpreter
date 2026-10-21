#ifndef KERNEL_HPP_
#define KERNEL_HPP_

#include <cstdint>
#include <string_view>
#include "cpu/cpu.hpp"
#include "memory.hpp"

namespace toy_sim {

enum class SyscallNum : uint16_t {
  kScanUnsigned = 0,
  kPrintUnsigned = 1,
  kExit = 60,
  kAbort = 61,

  kReturnToExecution = 0xFFFF - 1,
  kUnknownSyscall = 0xFFFF,
};

struct SyscallException : std::exception {
  SyscallNum syscall;
  explicit SyscallException(SyscallNum syscall_) : syscall{syscall_} {}
};

class Kernel {
 public:
  explicit Kernel(Cpu& cpu, Memory& memory) : cpu_(cpu), memory_(memory) {}

  SyscallNum HandleSyscall(SyscallNum syscall);
  uint32_t MmapFile(std::string_view filename);

 private:
  Cpu& cpu_;
  Memory& memory_;
};
}  // namespace toy_sim

#endif  // KERNEL_HPP_
