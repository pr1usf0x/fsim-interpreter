#include "kernel.hpp"
#include <fstream>
#include <ios>
#include <iostream>
#include <stdexcept>
#include "encoding.hpp"
#include "memory.hpp"

namespace toy_sim {
namespace {
uint32_t PrintUnsigned(uint32_t num) {
  std::cout << num << "\n";
  return 0;
}

uint32_t ScanUnsigned() {
  size_t num = 0;
  std::cin >> num;
  return num;
}
}  // namespace

void Kernel::MmapFile(const std::string& filename, uint32_t addr) {
    std::ifstream in(filename, std::ios::binary);
    if (!in) {
        throw std::runtime_error{"Kernel : file open error"};
    }
    const size_t tmp_max_size = 1024;
    in.read(memory_.GetDataPtr(addr), tmp_max_size);
}

Syscalls Kernel::HandleSyscall(Syscalls syscall) {
  switch (syscall) {
    case Syscalls::kPrintUnsigned:
      PrintUnsigned(cpu_.GetRegister(Register::kX1));
      return Syscalls::kReturnToExecution;

    case Syscalls::kScanUnsigned:
      cpu_.SetRegister(Register::kX0, ScanUnsigned());
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