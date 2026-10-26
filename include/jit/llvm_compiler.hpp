#ifndef LLVM_COMPILER_HPP_
#define LLVM_COMPILER_HPP_

#include <cstdint>
#include <memory>
#include <string>
#include <unordered_map>
#include <utility>
#include "cpu/decoder.hpp"
#include "encoding.hpp"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/IRCompileLayer.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"

namespace toy_sim {

class ToySimBBBuilder {
 public:
  template <typename... Args>
  explicit ToySimBBBuilder(Args&... args) : b_(args...) {}

  llvm::IRBuilder<>& GetBuilder() { return b_; }

  struct BuilderCtx {
    llvm::Value* mem;
    llvm::Value* regs;
    llvm::Value* pc;
  };
  // emiters
  void EmitLd(const Instruction& instr, const BuilderCtx& ctx);
  void EmitSt(const Instruction& instr, const BuilderCtx& ctx);
  void EmitStp(const Instruction& instr, const BuilderCtx& ctx);
  void EmitLdPost(const Instruction& instr, const BuilderCtx& ctx);
  void EmitAdd(const Instruction& instr, const BuilderCtx& ctx);
  void EmitBeq(const Instruction& instr, llvm::BasicBlock* true_bb,
               llvm::BasicBlock* false_bb, const BuilderCtx& ctx);
  void EmitLi(const Instruction& instr, const BuilderCtx& ctx);
  void EmitAddi(const Instruction& instr, const BuilderCtx& ctx);
  void EmitJ(const Instruction& instr, llvm::BasicBlock* bb,
             const BuilderCtx& ctx);
  void EmitNor(const Instruction& instr, const BuilderCtx& ctx);
  void EmitSsat(const Instruction& instr, const BuilderCtx& ctx);
  void EmitRbit(const Instruction& instr, const BuilderCtx& ctx);
  void EmitUsat(const Instruction& instr, const BuilderCtx& ctx);

 private:
  // helpers

  llvm::Value* GetRegisterPtr(Register reg, const BuilderCtx& ctx);
  llvm::Value* GetRealMemPtr(llvm::Value* ptr, const BuilderCtx& ctx);
  llvm::Value* ReadRegister(Register reg, const BuilderCtx& ctx);
  llvm::Value* ReadInt32FromMem(llvm::Value* virt_addr, const BuilderCtx& ctx);
  void SetRegister(Register reg, llvm::Value* val, const BuilderCtx& ctx);
  void Step(const BuilderCtx& ctx);
  void WriteToMem(llvm::Value* val, llvm::Value* virt_addr,
                  const BuilderCtx& ctx);

  llvm::IRBuilder<> b_;
};
}  // namespace toy_sim

#endif  // LLVM_COMPILER_HPP_
