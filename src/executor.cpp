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

#define DISPATCH()                                                           \
  ++instr;                                                                   \
  [[clang::musttail]] return GetNextHandler(instr->type_)(cpu_state, memory, \
                                                          instr);

}  // namespace

void Executor::ExecuteLd(CpuState& cpu_state, Memory& memory,
                         const Instruction* instr) {
  size_t addr = cpu_state.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  cpu_state.SetRegister(instr->r2_, memory.Read(addr));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteSt(CpuState& cpu_state, Memory& memory,
                         const Instruction* instr) {
  size_t addr = cpu_state.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  memory.Write(addr, cpu_state.GetRegister(instr->r2_));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteStp(CpuState& cpu_state, Memory& memory,
                          const Instruction* instr) {
  size_t addr = cpu_state.GetRegister(instr->r1_) + SignExtend(instr->imm_, 11);
  CheckAlignment(addr);
  memory.Write(addr, cpu_state.GetRegister(instr->r2_));
  memory.Write(addr + sizeof(uint32_t), cpu_state.GetRegister(instr->r3_));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteLdPost(CpuState& cpu_state, Memory& memory,
                             const Instruction* instr) {
  CheckAlignment(cpu_state.GetRegister(instr->r1_));
  cpu_state.SetRegister(instr->r2_,
                        memory.Read(cpu_state.GetRegister(instr->r1_)));
  cpu_state.SetRegister(instr->r1_, cpu_state.GetRegister(instr->r1_) +
                                        SignExtend(instr->imm_, 14));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteAdd(CpuState& cpu_state, Memory& memory,
                          const Instruction* instr) {
  cpu_state.SetRegister(instr->r3_, cpu_state.GetRegister(instr->r1_) +
                                        cpu_state.GetRegister(instr->r2_));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteBeq(CpuState& cpu_state, Memory&,
                          const Instruction* instr) {
  bool cond =
      cpu_state.GetRegister(instr->r1_) == cpu_state.GetRegister(instr->r2_);
  if (cond) {
    cpu_state.SetRegister(Register::kPc,
                          cpu_state.GetRegister(Register::kPc) + instr->imm_);
  } else {
    cpu_state.Step();
  }
}

void Executor::ExecuteLi(CpuState& cpu_state, Memory& memory,
                         const Instruction* instr) {
  cpu_state.SetRegister(instr->r1_, SignExtend(instr->imm_, 16));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteAddi(CpuState& cpu_state, Memory& memory,
                           const Instruction* instr) {
  cpu_state.SetRegister(instr->r2_, cpu_state.GetRegister(instr->r1_) +
                                        SignExtend(instr->imm_, 16));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteJ(CpuState& cpu_state, Memory&,
                        const Instruction* instr) {
  cpu_state.SetRegister(
      Register::kPc,
      (cpu_state.GetRegister(Register::kPc) & 0xF0000000) | (instr->imm_ << 2));
}

void Executor::ExecuteNor(CpuState& cpu_state, Memory& memory,
                          const Instruction* instr) {
  cpu_state.SetRegister(instr->r3_, ~(cpu_state.GetRegister(instr->r1_) |
                                      cpu_state.GetRegister(instr->r2_)));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteSsat(CpuState& cpu_state, Memory& memory,
                           const Instruction* instr) {
  cpu_state.SetRegister(
      instr->r1_,
      SaturateSigned(cpu_state.GetRegister(instr->r2_), instr->imm_));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteRbit(CpuState& cpu_state, Memory& memory,
                           const Instruction* instr) {
  cpu_state.SetRegister(instr->r1_,
                        ReverseBit(cpu_state.GetRegister(instr->r2_)));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteSyscall(CpuState& cpu_state, Memory&,
                              [[maybe_unused]] const Instruction* instr) {
  auto syscall = static_cast<Syscalls>(cpu_state.GetRegister(Register::kX0));
  cpu_state.Step();
  throw SyscallException(syscall);
}

void Executor::ExecuteBext(CpuState& cpu_state, Memory& memory,
                           const Instruction* instr) {
  cpu_state.SetRegister(instr->r1_,
                        BitExtract(cpu_state.GetRegister(instr->r2_),
                                   cpu_state.GetRegister(instr->r3_)));
  cpu_state.Step();
  DISPATCH();
}

void Executor::ExecuteUsat(CpuState& cpu_state, Memory& memory,
                           const Instruction* instr) {
  cpu_state.SetRegister(
      instr->r1_,
      SaturateUnsigned(cpu_state.GetRegister(instr->r2_), instr->imm_));
  cpu_state.Step();
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
