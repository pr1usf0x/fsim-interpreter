#include "cpu/executor.hpp"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <algorithm>
#include "cpu/decoder.hpp"
#include "encoding.hpp"
#include "kernel.hpp"
#include "memory.hpp"

namespace toy_sim {

// ================================== EXECUTION ===============================

namespace {
inline uint32_t SignExtend(uint32_t num, size_t n) {
  assert(n < 32);
  if (n == 0) return 0;
  n = 32 - n;
  return (static_cast<int32_t>(num << n) >> n);
}

inline uint32_t SaturateSigned(uint32_t num, size_t n) {
  assert(n <= 31);
  if (n == 0)
    return 0;
  int32_t min_n_int = -(1U << (n - 1));
  int32_t max_n_int = (1U << (n - 1)) - 1;
  return static_cast<int32_t>(num) > 0
             ? std::min<int32_t>(max_n_int, static_cast<int32_t>(num))
             : std::max<int32_t>(min_n_int, static_cast<int32_t>(num));
}

inline uint32_t SaturateUnsigned(uint32_t num, size_t n) {
  assert(n <= 32);
  uint32_t max_n_uint = ~0U >> (sizeof(uint32_t) * 8 - n);
  return std::min<uint32_t>(max_n_uint, num);
}

inline uint32_t ReverseBit(uint32_t num) {
  num = ((num & 0x55555555) << 1) | ((num & 0xAAAAAAAA) >> 1);
  num = ((num & 0x33333333) << 2) | ((num & 0xCCCCCCCC) >> 2);
  num = ((num & 0x0F0F0F0F) << 4) | ((num & 0xF0F0F0F0) >> 4);
  num = ((num & 0x00FF00FF) << 8) | ((num & 0xFF00FF00) >> 8);
  num = ((num & 0x0000FFFF) << 16) | ((num & 0xFFFF0000) >> 16);
  return num;
}

inline uint32_t BitExtract(uint32_t num, uint32_t mask) {
  uint32_t c = 0;
  uint32_t m = 1;
  while (mask) {
    uint32_t b = (mask) & (-mask);
    if (num & b)
      c |= m;
    mask -= b;
    m <<= 1;
  }
  return c;
}

void CheckAlignment(size_t addr) {
  if (addr % sizeof(uint32_t))
    throw std::runtime_error("Executor: MisalignedAccess");
}

#define DISPATCH()                                      \
  ++instr;                                              \
  [[clang::musttail]] return GetNextHandler(instr->type_)(cpu, memory, instr);

}  // namespace

void Executor::ExecuteLd(CpuState& cpu, Memory& memory, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  cpu.SetRegister(instr->r2_, memory.Read(addr));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteSt(CpuState& cpu, Memory& memory, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  memory.Write(addr, cpu.GetRegister(instr->r2_));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteStp(CpuState& cpu, Memory& memory, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 11);
  CheckAlignment(addr);
  memory.Write(addr, cpu.GetRegister(instr->r2_));
  memory.Write(addr + sizeof(uint32_t), cpu.GetRegister(instr->r3_));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteLdPost(CpuState& cpu, Memory& memory, const Instruction* instr) {
  CheckAlignment(cpu.GetRegister(instr->r1_));
  cpu.SetRegister(instr->r2_,
                  memory.Read(cpu.GetRegister(instr->r1_)));
  cpu.SetRegister(instr->r1_,
                  cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteAdd(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r3_,
                  cpu.GetRegister(instr->r1_) + cpu.GetRegister(instr->r2_));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteBeq(CpuState& cpu, Memory&, const Instruction* instr) {
  bool cond = cpu.GetRegister(instr->r1_) == cpu.GetRegister(instr->r2_);
  if (cond) {
    cpu.SetRegister(Register::kPc,
                    cpu.GetRegister(Register::kPc) + instr->imm_);
  } else {
    cpu.Step();
  }
}

void Executor::ExecuteLi(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, SignExtend(instr->imm_, 16));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteAddi(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r2_,
                  cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 16));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteJ(CpuState& cpu, Memory&, const Instruction* instr) {
  cpu.SetRegister(Register::kPc, (cpu.GetRegister(Register::kPc) & 0xF0000000) |
                                     (instr->imm_ << 2));
}

void Executor::ExecuteNor(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r3_,
                  ~(cpu.GetRegister(instr->r1_) | cpu.GetRegister(instr->r2_)));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteSsat(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r1_,
                  SaturateSigned(cpu.GetRegister(instr->r2_), instr->imm_));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteRbit(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, ReverseBit(cpu.GetRegister(instr->r2_)));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteSyscall(CpuState& cpu, Memory&, const Instruction* instr) {
  cpu.Step();
  throw SyscallException(static_cast<Syscalls>(instr->imm_));
}

void Executor::ExecuteBext(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, BitExtract(cpu.GetRegister(instr->r2_),
                                         cpu.GetRegister(instr->r3_)));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteUsat(CpuState& cpu, Memory& memory, const Instruction* instr) {
  cpu.SetRegister(instr->r1_,
                  SaturateUnsigned(cpu.GetRegister(instr->r2_), instr->imm_));
  cpu.Step();
  DISPATCH();
}

void Executor::ExecuteUnknown(CpuState&, Memory&, const Instruction*) {
  throw std::runtime_error("Executor: Unknown Instruction");
}

//////////////////////////////// FOR TESTS ////////////////////////////////////

void Executor::ExecuteInstr(CpuState& cpu_state, Memory& memory, Instruction instr) {
  const BasicBlock pseudo_block = {
      instr,
      {.type_ = CommandType::kBeq,
       .r1_ = Register::kX0,
       .r2_ = Register::kX0,
       .r3_ = Register::kX0,
       .imm_ = 0},
  };
  return GetNextHandler(instr.type_)(cpu_state, memory, pseudo_block.data());
}

}  // namespace toy_sim

#undef DISPATCH
