#include "kernel.hpp"
#include <cstdint>
#include <cstring>
#include <elfio/elfio.hpp>
#include <iostream>
#include <stdexcept>
#include <string_view>
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

uint32_t Kernel::MmapFile(std::string_view filename) {
  ELFIO::elfio reader;
  if (!reader.load(std::string{filename})) {
    throw std::invalid_argument{"No such file."};
  }
  if (reader.get_class() != ELFIO::ELFCLASS32 || // machine type
      reader.get_encoding() != ELFIO::ELFDATA2LSB ||
      reader.segments.size() != 1) { // 1 segment ???
    throw std::invalid_argument{"Incorrect ELF format"};
  }

  auto* segment = reader.segments[0];
  memcpy(memory_.GetDataPtr(segment->get_virtual_address()),
         segment->get_data(), segment->get_file_size());

  return reader.get_entry();
}

SyscallNum Kernel::HandleSyscall(SyscallNum syscall) {
  switch (syscall) {
    case SyscallNum::kPrintUnsigned:
      PrintUnsigned(cpu_.GetCpuState().GetRegister(Register::kX1));
      return SyscallNum::kReturnToExecution;

    case SyscallNum::kScanUnsigned:
      cpu_.GetCpuState().SetRegister(Register::kX0, ScanUnsigned());
      return SyscallNum::kReturnToExecution;

    case SyscallNum::kExit:
      return SyscallNum::kExit;
    case SyscallNum::kAbort:
      return SyscallNum::kAbort;
    case SyscallNum::kUnknownSyscall:
    default:
      return SyscallNum::kUnknownSyscall;
  }
}

}  // namespace toy_sim