#include "llvm/module_compiler.hpp"
#include <cassert>
#include <memory>
#include <stdexcept>
#include <utility>
#include <vector>
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"

#define assert_ctx(CTX____)      \
  do {                           \
    assert((CTX____));           \
    assert((CTX____)->bb);       \
    assert((CTX____)->function); \
  } while (0)

namespace toy_sim {

void LLVMModuleCompiler::CompileBeq(const Instruction& instr, CompileCtx* ctx) {
  assert(instr.type_ == CommandType::kBeq);
  assert_ctx(ctx);

  llvm::BasicBlock* true_bb =
      llvm::BasicBlock::Create(ctx->llvm_ctx, "beq_true", ctx->function);
  llvm::IRBuilder<> true_builder(true_bb);
  true_builder.CreateRet(true_builder.getInt32(kBeqReturnCode));

  llvm::BasicBlock* false_bb =
      llvm::BasicBlock::Create(ctx->llvm_ctx, "beq_false", ctx->function);
  llvm::IRBuilder<> false_builder(false_bb);
  false_builder.CreateRet(false_builder.getInt32(kBeqReturnCode));

  ctx->builder.EmitBeq(instr, true_bb, false_bb, ctx->builder_ctx);
}
void LLVMModuleCompiler::CompileJ(const Instruction& instr, CompileCtx* ctx) {
  assert(instr.type_ == CommandType::kJ);
  assert_ctx(ctx);

  // construct return basic block
  llvm::BasicBlock* return_bb =
      llvm::BasicBlock::Create(ctx->llvm_ctx, "return_block", ctx->function);
  llvm::IRBuilder<> ret_builder(return_bb);
  ret_builder.CreateRet(ret_builder.getInt32(kJReturnCode));

  ctx->builder.EmitJ(instr, return_bb, ctx->builder_ctx);
}

void LLVMModuleCompiler::CompileSyscall(const Instruction& instr,
                                        CompileCtx* ctx) {
  assert(instr.type_ == CommandType::kSyscall);
  assert_ctx(ctx);

  auto& builder_ref = ctx->builder.GetBuilder();
  builder_ref.CreateRet(builder_ref.getInt32(kSyscallReturnCode));
}

void LLVMModuleCompiler::CompileInstruction(const Instruction& instr,
                                            CompileCtx* ctx) {
  assert_ctx(ctx);

  switch (instr.type_) {
    case CommandType::kLd:
      return ctx->builder.EmitLd(instr, ctx->builder_ctx);
    case CommandType::kAdd:
      return ctx->builder.EmitAdd(instr, ctx->builder_ctx);
    case CommandType::kLi:
      return ctx->builder.EmitLi(instr, ctx->builder_ctx);
    case CommandType::kSt:
      return ctx->builder.EmitSt(instr, ctx->builder_ctx);
    case CommandType::kStp:
      return ctx->builder.EmitStp(instr, ctx->builder_ctx);
    case CommandType::kAddi:
      return ctx->builder.EmitAddi(instr, ctx->builder_ctx);
    case CommandType::kLdPost:
      return ctx->builder.EmitLdPost(instr, ctx->builder_ctx);
    case CommandType::kNor:
      return ctx->builder.EmitNor(instr, ctx->builder_ctx);
    case CommandType::kSsat:
      return ctx->builder.EmitSsat(instr, ctx->builder_ctx);
    case CommandType::kRbit:
      return ctx->builder.EmitRbit(instr, ctx->builder_ctx);
    case CommandType::kBext:
      return ctx->builder.EmitBext(instr, ctx->builder_ctx);
    case CommandType::kUsat:
      return ctx->builder.EmitUsat(instr, ctx->builder_ctx);
    case toy_sim::CommandType::kJ:
    case toy_sim::CommandType::kBeq:
    case toy_sim::CommandType::kSyscall:
      assert(0 && "Compiler : non terminator expected");
    case CommandType::kUnknown:
    default:
      assert(0 && "Compiler : unknown construction in compiling block");
      std::unreachable();
      break;
  }
}

void LLVMModuleCompiler::CompileTerminator(const Instruction& instr,
                                           CompileCtx* ctx) {
  assert_ctx(ctx);
  switch (instr.type_) {
    case CommandType::kBeq:
      return CompileBeq(instr, ctx);
    case CommandType::kJ:
      return CompileJ(instr, ctx);
    case CommandType::kSyscall:
      return CompileSyscall(instr, ctx);
    default:
      assert(0 && "Compiler: unknown terminator");
      std::unreachable();
  }
}

llvm::orc::ThreadSafeModule LLVMModuleCompiler::CreateBlockFunction(
    const DecodedBlock& decoded) {

  auto llvm_ctx = std::make_unique<llvm::LLVMContext>();
  std::unique_ptr<llvm::Module> module =
      std::make_unique<llvm::Module>(kGetNameByPc(decoded.pc), *llvm_ctx);

  auto* ptr_type = llvm::PointerType::get(*llvm_ctx, 0);
  const std::vector<llvm::Type*> args = {ptr_type, ptr_type, ptr_type};
  llvm::FunctionType* func_type =
      llvm::FunctionType::get(llvm::Type::getInt32Ty(*llvm_ctx), args, false);

  llvm::Function* function = llvm::Function::Create(
      func_type, llvm::Function::ExternalLinkage, kGetNameByPc(decoded.pc),
      *module);

  function->getArg(kMemArg)->setName("mem");
  function->getArg(kRegArg)->setName("regs");
  function->getArg(kPcArg)->setName("pc");

  llvm::BasicBlock* bb = llvm::BasicBlock::Create(*llvm_ctx, "entry", function);
  ToySimBBBuilder builder{bb};
  ToySimBBBuilder::BuilderCtx ctx{
      .mem = function->getArg(kMemArg),
      .regs = function->getArg(kRegArg),
      .pc = function->getArg(kPcArg),
  };

  size_t i = 0;
  const size_t bb_pc = decoded.pc;
  CompileCtx compile_ctx{
      .llvm_ctx = *llvm_ctx,
      .bb = bb,
      .builder = builder,
      .bb_pc = bb_pc,
      .builder_ctx = ctx,
      .function = function,
  };

  for (; !IsTerminator(decoded.instructions[i]); ++i) {
    CompileInstruction(decoded.instructions[i], &compile_ctx);
  }
  CompileTerminator(decoded.instructions[i], &compile_ctx);

  if (llvm::verifyFunction(*function)) {
    throw std::runtime_error("JIT : incorrect function");
  }
  if (llvm::verifyModule(*module)) {
    throw std::runtime_error("JIT : incorrect module");
  }

  return {std::move(module), std::move(llvm_ctx)};
}

}  // namespace toy_sim

#undef assert_ctx
