#include "llvm/builder_wrapper.hpp"

#include <cassert>
#include <cstdint>
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Value.h"

#define assert_ctx(CTX____) \
  do {                      \
    assert((CTX____).mem);  \
    assert((CTX____).pc);   \
    assert((CTX____).regs); \
  } while (0)

namespace toy_sim {

void ToySimBBBuilder::EmitLd(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kLd);
  assert_ctx(ctx);

  uint32_t imm_signed = SignExtend(instr.imm_, 14);
  // idk how to check alignment here 😭, it was exception btw
  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* virt_addr = b_.CreateAdd(r1, b_.getInt32(imm_signed), "addr");
  llvm::Value* loaded = ReadInt32FromMem(virt_addr, ctx);
  SetRegister(instr.r2_, loaded, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitSt(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kSt);
  assert_ctx(ctx);

  uint32_t imm_signed = SignExtend(instr.imm_, 14);
  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* virt_addr = b_.CreateAdd(r1, b_.getInt32(imm_signed), "addr");
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  WriteToMem(r2, virt_addr, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitStp(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kStp);
  assert_ctx(ctx);

  uint32_t imm_signed = SignExtend(instr.imm_, 11);
  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* virt_addr_1 = b_.CreateAdd(r1, b_.getInt32(imm_signed), "addr");
  llvm::Value* virt_addr_2 = b_.CreateAdd(virt_addr_1, b_.getInt32(4), "addr4");
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* r3 = ReadRegister(instr.r3_, ctx);
  WriteToMem(r2, virt_addr_1, ctx);
  WriteToMem(r3, virt_addr_2, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitLdPost(const Instruction& instr,
                                 const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kLdPost);
  assert_ctx(ctx);

  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* i32_from_mem = ReadInt32FromMem(r1, ctx);
  SetRegister(instr.r2_, i32_from_mem, ctx);
  r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* r1_new =
      b_.CreateAdd(r1, b_.getInt32(SignExtend(instr.imm_, 14)));
  SetRegister(instr.r1_, r1_new, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitAdd(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kAdd);
  assert_ctx(ctx);

  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* r2_new = b_.CreateAdd(r1, r2, "r2new");
  SetRegister(instr.r3_, r2_new, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitBeq(const Instruction& instr,
                              llvm::BasicBlock* true_bb,
                              llvm::BasicBlock* false_bb,
                              const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kBeq);
  assert(true_bb);
  assert(false_bb);
  assert_ctx(ctx);

  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* cond = b_.CreateICmpEQ(r1, r2, "beq_cond");
  llvm::Value* pc = b_.CreateLoad(b_.getInt32Ty(), ctx.pc, "pcbefore");
  llvm::Value* true_pc =
      b_.CreateAdd(pc, b_.getInt32(instr.imm_), "beq_true_pc");
  llvm::Value* false_pc = b_.CreateAdd(pc, b_.getInt32(4), "beq_false_pc");
  llvm::Value* new_pc = b_.CreateSelect(cond, true_pc, false_pc, "pcafter");
  b_.CreateStore(new_pc, ctx.pc);
  b_.CreateCondBr(cond, true_bb, false_bb);
}

void ToySimBBBuilder::EmitLi(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kLi);
  assert_ctx(ctx);

  SetRegister(instr.r1_, b_.getInt32(SignExtend(instr.imm_, 16)), ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitAddi(const Instruction& instr,
                               const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kAddi);
  assert_ctx(ctx);

  llvm::Value* r1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* r2_new =
      b_.CreateAdd(r1, b_.getInt32(SignExtend(instr.imm_, 16)), "r2new");
  SetRegister(instr.r2_, r2_new, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitJ(const Instruction& instr, llvm::BasicBlock* bb,
                            const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kJ);
  assert(bb);
  assert_ctx(ctx);

  llvm::Value* pc = b_.CreateLoad(b_.getInt32Ty(), ctx.pc);
  llvm::Value* target = b_.CreateOr(
      b_.CreateAnd(pc, b_.getInt32(0xF0000000)),
      b_.getInt32(instr.imm_ << 2));
  b_.CreateStore(target, ctx.pc);
  b_.CreateBr(bb);
}

void ToySimBBBuilder::EmitNor(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kBeq);
  assert_ctx(ctx);

  llvm::Value* reg1 = ReadRegister(instr.r1_, ctx);
  llvm::Value* reg2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* or_value = b_.CreateOr(reg1, reg2, "or");
  llvm::Value* nor_value = b_.CreateNot(or_value, "nor");
  SetRegister(instr.r3_, nor_value, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitSsat(const Instruction& instr,
                               const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kSsat);
  assert(instr.imm_ <= 31);
  assert_ctx(ctx);

  if (instr.imm_ == 0) {
    SetRegister(instr.r1_, b_.getInt32(0), ctx);
    Step(ctx);
    return;
  }

  uint32_t max_value = (1U << (instr.imm_ - 1)) - 1;
  uint32_t min_value = -(1U << (instr.imm_ - 1));
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* positive = b_.CreateICmpSGT(r2, b_.getInt32(0));
  llvm::Value* min = b_.CreateBinaryIntrinsic(llvm::Intrinsic::smax, r2,
                                              b_.getInt32(min_value));
  llvm::Value* max = b_.CreateBinaryIntrinsic(llvm::Intrinsic::umin, r2,
                                              b_.getInt32(max_value));
  llvm::Value* saturated = b_.CreateSelect(positive, max, min, "ssat");
  SetRegister(instr.r1_, saturated, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitRbit(const Instruction& instr,
                               const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kRbit);
  assert_ctx(ctx);

  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* reversed =
      b_.CreateUnaryIntrinsic(llvm::Intrinsic::bitreverse, r2);
  SetRegister(instr.r1_, reversed, ctx);
  Step(ctx);
}

void ToySimBBBuilder::EmitBext(const Instruction& instr, const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kBext);
  assert_ctx(ctx);

  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* r3 = ReadRegister(instr.r3_, ctx);
  llvm::Value* extracted = b_.CreateBinaryIntrinsic(llvm::Intrinsic::pext, r2, r3);
  SetRegister(instr.r1_, extracted, ctx);

  Step(ctx);
}

void ToySimBBBuilder::EmitUsat(const Instruction& instr,
                               const BuilderCtx& ctx) {
  assert(instr.type_ == CommandType::kUsat);
  assert(instr.imm_ <= 32);
  assert_ctx(ctx);

  uint32_t max_value = instr.imm_ == 32 ? ~0U : (1U << instr.imm_) - 1;
  llvm::Value* r2 = ReadRegister(instr.r2_, ctx);
  llvm::Value* saturated = b_.CreateBinaryIntrinsic(llvm::Intrinsic::umin, r2,
                                                    b_.getInt32(max_value));
  SetRegister(instr.r1_, saturated, ctx);
  Step(ctx);
}

// syscall is handled by interpreter lol

// =================================== HELPERS ================================

llvm::Value* ToySimBBBuilder::ReadRegister(Register reg,
                                           const BuilderCtx& ctx) {
  assert_ctx(ctx);

  llvm::Value* reg_ptr = GetRegisterPtr(reg, ctx);
  return b_.CreateLoad(b_.getInt32Ty(), reg_ptr, "reg_val");
}

void ToySimBBBuilder::SetRegister(Register reg, llvm::Value* val,
                                  const BuilderCtx& ctx) {
  assert(val);
  assert_ctx(ctx);

  llvm::Value* reg_ptr = GetRegisterPtr(reg, ctx);
  b_.CreateStore(val, reg_ptr);
}

llvm::Value* ToySimBBBuilder::GetRegisterPtr(Register reg,
                                             const BuilderCtx& ctx) {
  assert_ctx(ctx);

  return b_.CreateGEP(b_.getInt32Ty(), ctx.regs,
                      {b_.getInt32(static_cast<int>(reg))});
}

llvm::Value* ToySimBBBuilder::ReadInt32FromMem(llvm::Value* virt_addr,
                                               const BuilderCtx& ctx) {
  assert(virt_addr);
  assert_ctx(ctx);

  llvm::Value* mem_ptr = GetRealMemPtr(virt_addr, ctx);
  return b_.CreateLoad(b_.getInt32Ty(), mem_ptr, "int32frommem");
}

void ToySimBBBuilder::WriteToMem(llvm::Value* val, llvm::Value* virt_addr,
                                 const BuilderCtx& ctx) {
  assert(val);
  assert(virt_addr);
  assert_ctx(ctx);

  llvm::Value* mem_ptr = GetRealMemPtr(virt_addr, ctx);
  b_.CreateStore(val, mem_ptr);
}

llvm::Value* ToySimBBBuilder::GetRealMemPtr(llvm::Value* ptr,
                                            const BuilderCtx& ctx) {
  assert(ptr);
  assert_ctx(ctx);

  return b_.CreateGEP(b_.getInt8Ty(), ctx.mem, ptr);
}

void ToySimBBBuilder::Step(const BuilderCtx& ctx) {
  assert_ctx(ctx);

  llvm::Value* pc = b_.CreateLoad(b_.getInt32Ty(), ctx.pc, "pcbefore");
  llvm::Value* new_pc = b_.CreateAdd(pc, b_.getInt32(4), "pcafter");
  b_.CreateStore(new_pc, ctx.pc);
}

void ToySimBBBuilder::SetPc(uint32_t new_pc, const BuilderCtx& ctx) {
  assert_ctx(ctx);

  b_.CreateStore(b_.getInt32(new_pc), ctx.pc);
}
}  // namespace toy_sim

#undef assert_ctx
