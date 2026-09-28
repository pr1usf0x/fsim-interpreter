#include "cpu/executor.hpp"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <utility>
#include "cpu/cpu.hpp"
#include "encoding.hpp"
#include "kernel.hpp"

namespace toy_sim {

// ================================== EXECUTION ===============================

void Cpu::RunProgram() {
  for (;;) {
    const BasicBlock& bb = Fetch();
    kHandlers()[static_cast<size_t>(bb.front().type_)](*this, bb.data());
  }
}

namespace {
inline int32_t SignExtend(uint32_t num, size_t n) {
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
  const auto index = static_cast<size_t>(instr->type_); \
  [[clang::musttail]] return kHandlers()[index](cpu, instr);

}  // namespace

void ExecuteLd(Cpu& cpu, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  cpu.SetRegister(instr->r2_, cpu.GetMemory().Read(addr));
  cpu.Step();
  DISPATCH();
}

void ExecuteSt(Cpu& cpu, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14);
  CheckAlignment(addr);
  cpu.GetMemory().Write(addr, cpu.GetRegister(instr->r2_));
  cpu.Step();
  DISPATCH();
}

void ExecuteStp(Cpu& cpu, const Instruction* instr) {
  size_t addr = cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 11);
  CheckAlignment(addr);
  cpu.GetMemory().Write(addr, cpu.GetRegister(instr->r2_));
  cpu.GetMemory().Write(addr + sizeof(uint32_t), cpu.GetRegister(instr->r3_));
  cpu.Step();
  DISPATCH();
}

void ExecuteLdPost(Cpu& cpu, const Instruction* instr) {
  CheckAlignment(cpu.GetRegister(instr->r1_));
  cpu.SetRegister(instr->r2_,
                  cpu.GetMemory().Read(cpu.GetRegister(instr->r1_)));
  cpu.SetRegister(instr->r1_,
                  cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 14));
  cpu.Step();
  DISPATCH();
}

void ExecuteAdd(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r3_,
                  cpu.GetRegister(instr->r1_) + cpu.GetRegister(instr->r2_));
  cpu.Step();
  DISPATCH();
}

void ExecuteBeq(Cpu& cpu, const Instruction* instr) {
  bool cond = cpu.GetRegister(instr->r1_) == cpu.GetRegister(instr->r2_);
  if (cond) {
    cpu.SetRegister(Register::kPc,
                    cpu.GetRegister(Register::kPc) + instr->imm_);
  } else {
    cpu.Step();
  }
}

void ExecuteLi(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, SignExtend(instr->imm_, 16));
  cpu.Step();
  DISPATCH();
}

void ExecuteAddi(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r2_,
                  cpu.GetRegister(instr->r1_) + SignExtend(instr->imm_, 16));
  cpu.Step();
  DISPATCH();
}

void ExecuteJ(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(Register::kPc, (cpu.GetRegister(Register::kPc) & 0xF0000000) |
                                     (instr->imm_ << 2));
}

void ExecuteNor(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r3_,
                  ~(cpu.GetRegister(instr->r1_) | cpu.GetRegister(instr->r2_)));
  cpu.Step();
  DISPATCH();
}

void ExecuteSsat(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r1_,
                  SaturateSigned(cpu.GetRegister(instr->r2_), instr->imm_));
  cpu.Step();
  DISPATCH();
}

void ExecuteRbit(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, ReverseBit(cpu.GetRegister(instr->r2_)));
  cpu.Step();
  DISPATCH();
}

void ExecuteSyscall(Cpu& cpu, const Instruction* instr) {
  cpu.Step();
  throw SyscallException(static_cast<Syscalls>(instr->imm_));
}

void ExecuteBext(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r1_, BitExtract(cpu.GetRegister(instr->r2_),
                                         cpu.GetRegister(instr->r3_)));
  cpu.Step();
  DISPATCH();
}

void ExecuteUsat(Cpu& cpu, const Instruction* instr) {
  cpu.SetRegister(instr->r1_,
                  SaturateUnsigned(cpu.GetRegister(instr->r2_), instr->imm_));
  cpu.Step();
  DISPATCH();
}

void ExecuteUnknown(Cpu&, const Instruction*) {
  throw std::runtime_error("Executor: Unknown Instruction");
}

// ================================ FETCH =====================================

const BasicBlock& Cpu::Fetch() {
  auto bb = decoder_cache_.find(pc_);
  if (bb == decoder_cache_.end()) {
    auto decoded_bb = DecodeBB(memory_, pc_);
    bb = decoder_cache_.insert(std::make_pair(pc_, decoded_bb)).first;
  }

  return bb->second;
}

//////////////////////////////// FOR TESTS ////////////////////////////////////

void Execute(Cpu& cpu, Instruction instr) {
  const Instruction pseudo_block[] = {
      instr,
      {.type_ = CommandType::kBeq,
       .r1_ = Register::kX0,
       .r2_ = Register::kX0,
       .r3_ = Register::kX0,
       .imm_ = 0},
  };
  switch (instr.type_) {
    case CommandType::kLd:
      ExecuteLd(cpu, pseudo_block);
      break;
    case CommandType::kAdd:
      ExecuteAdd(cpu, pseudo_block);
      break;
    case CommandType::kBeq:
      ExecuteBeq(cpu, pseudo_block);
      break;
    case CommandType::kLi:
      ExecuteLi(cpu, pseudo_block);
      break;
    case CommandType::kSt:
      ExecuteSt(cpu, pseudo_block);
      break;
    case CommandType::kStp:
      ExecuteStp(cpu, pseudo_block);
      break;
    case CommandType::kAddi:
      ExecuteAddi(cpu, pseudo_block);
      break;
    case CommandType::kJ:
      ExecuteJ(cpu, pseudo_block);
      break;
    case CommandType::kLdPost:
      ExecuteLdPost(cpu, pseudo_block);
      break;
    case CommandType::kNor:
      ExecuteNor(cpu, pseudo_block);
      break;
    case CommandType::kSsat:
      ExecuteSsat(cpu, pseudo_block);
      break;
    case CommandType::kRbit:
      ExecuteRbit(cpu, pseudo_block);
      break;
    case CommandType::kSyscall:
      ExecuteSyscall(cpu, pseudo_block);
      break;
    case CommandType::kBext:
      ExecuteBext(cpu, pseudo_block);
      break;
    case CommandType::kUsat:
      ExecuteUsat(cpu, pseudo_block);
      break;
    case CommandType::kUnknown:
    default:
      ExecuteUnknown(cpu, pseudo_block);
  }
}

}  // namespace toy_sim

#undef DISPATCH
