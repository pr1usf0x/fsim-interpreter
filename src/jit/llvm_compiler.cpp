#include "jit/llvm_compiler.hpp"

#include <cstdint>
#include <memory>
#include <string>
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

ToyISAModule::ToyISAModule(uint32_t pc, llvm::LLVMContext& ctx,
                           const DecodedBlock& decoded_bb)
    : ctx_(ctx),
      module_(std::make_unique<llvm::Module>("ToyIsa JIT" + kGetBlockName(pc),
                                             ctx_)),
      builder_(ctx_) {

  auto* ft = llvm::FunctionType::get(
      llvm::Type::getInt32Ty(ctx_),
      {llvm::PointerType::get(ctx_, 0), llvm::PointerType::get(ctx_, 0)},
      false);
  fn_ = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                               kGetBlockName(pc), module_.get());

  bb_ = llvm::BasicBlock::Create(ctx, "entry", fn_);

  builder_.SetInsertPoint(bb_);
  auto* ptr_to_reg = GetRegisterPtr(Register::kX0);
  auto* reg_val = builder_.CreateLoad(builder_.getInt32Ty(), ptr_to_reg);
  builder_.CreateRet(reg_val);

  Decode
  fn_->print(llvm::errs());
}

// helpers
llvm::Value* ToyISAModule::GetRegisterPtr(Register reg) {
  return builder_.CreateGEP(builder_.getInt32Ty(), fn_->getArg(kRegArg),
                            {builder_.getInt32(static_cast<int>(reg))});
}

llvm::Value* ToyISAModule::GetMemPtr(uint32_t mem_addr) {
  return builder_.CreateGEP(builder_.getInt8Ty(), fn_->getArg(kMemArg),
                            {builder_.getInt32(mem_addr)});
}

// void LLVMCompileBlock::emitLD(const Instruction)
}  // namespace toy_sim
