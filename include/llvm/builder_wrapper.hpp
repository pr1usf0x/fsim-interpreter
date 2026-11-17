#ifndef BUILDER_WRAPPER_HPP
#define BUILDER_WRAPPER_HPP

#include <cstdint>
#include "encoding.hpp"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/IRBuilder.h"

namespace toy_sim {

class ToySimBBBuilder {
 public:
  template <typename... Args>
  explicit ToySimBBBuilder(Args&... args) : b_(args...) {}

  llvm::IRBuilder<>& GetBuilder() { return b_; }

  struct ArgumentCtx {
    llvm::Value* mem;
    llvm::Value* regs;
    llvm::Value* pc;
  };
  // emiters
  void EmitLd(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitSt(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitStp(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitLdPost(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitAdd(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitBeq(const Instruction& instr, llvm::BasicBlock* true_bb,
               llvm::BasicBlock* false_bb, const ArgumentCtx& ctx);
  void EmitLi(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitAddi(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitJ(const Instruction& instr, llvm::BasicBlock* bb,
             const ArgumentCtx& ctx);
  void EmitNor(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitSsat(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitRbit(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitBext(const Instruction& instr, const ArgumentCtx& ctx);
  void EmitUsat(const Instruction& instr, const ArgumentCtx& ctx);
  void SetRegister(Register reg, llvm::Value* val, const ArgumentCtx& ctx);
  void Step(const ArgumentCtx& ctx);
  void WriteToMem(llvm::Value* val, llvm::Value* virt_addr,
                  const ArgumentCtx& ctx);
  void SetPc(uint32_t new_pc, const ArgumentCtx& ctx);

 private:
  // helpers

  llvm::Value* GetRegisterPtr(Register reg, const ArgumentCtx& ctx);
  llvm::Value* GetRealMemPtr(llvm::Value* ptr, const ArgumentCtx& ctx);
  llvm::Value* ReadRegister(Register reg, const ArgumentCtx& ctx);
  llvm::Value* ReadInt32FromMem(llvm::Value* virt_addr, const ArgumentCtx& ctx);

  llvm::IRBuilder<> b_;
};
}  // namespace toy_sim

#endif  // BUILDER_WRAPPER_HPP_
