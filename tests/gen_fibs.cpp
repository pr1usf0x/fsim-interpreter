#include <cstdint>
#include <fstream>
#include <iostream>
#include <utility>
#include <vector>
#include "encoding.hpp"
#include "kernel.hpp"
#include "machine.hpp"
#include "microasm.hpp"

using namespace toy_sim;
int main() {
  std::ofstream out("tests/fibs.bin", std::ios::binary);
  // X9 - zero register
  std::vector<toy_sim::uint32_t> prog = {
    GenSyscallInstr(static_cast<uint32_t>(Syscalls::kScanUnsigned)),
    GenAddInstr(Register::kX0, Register::kX9, Register::kX10),
    GenAddiInstr(Register::kX9, Register::kX11, 0),
    GenAddiInstr(Register::kX9, Register::kX12, 1),
// X10 = input // X11 = fibs(n-2) // X12 = fibs(n-1) // X13 = fibs(n)
    GenAddiInstr(Register::kX10, Register::kX10, -1),
    GenAddInstr(Register::kX11, Register::kX12, Register::kX13),
    GenAddInstr(Register::kX12, Register::kX9, Register::kX11),
    GenAddInstr(Register::kX13, Register::kX9, Register::kX12),
    GenBeqInstr(Register::kX10, Register::kX9, 2),
    GenJInstr(4),
///////////////////////////////////////////////////////////////////////////////

    GenAddInstr(Register::kX11, Register::kX9, Register::kX1),
    GenSyscallInstr(static_cast<uint32_t>(Syscalls::kPrintUnsigned)),
    GenSyscallInstr(static_cast<uint32_t>(Syscalls::kExit))};

  out.write(reinterpret_cast<char*>(prog.data()), prog.size() * 4);
}