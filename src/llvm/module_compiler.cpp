#include "llvm/module_compiler.hpp"
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <stdexcept>
#include <utility>
#include <vector>
#include "cpu/decoder.hpp"
#include "encoding.hpp"
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar/ADCE.h"
#include "llvm/Transforms/Scalar/DeadStoreElimination.h"
#include "llvm/Transforms/Scalar/EarlyCSE.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar/Reassociate.h"
#include "llvm/Transforms/Scalar/SimplifyCFG.h"

#define assert_ctx(CTX____)                   \
  do {                                        \
    assert((CTX____));                        \
    assert((CTX____)->bb);                    \
    assert((CTX____)->function_ctx.function); \
  } while (0)

namespace toy_sim {

std::optional<uint32_t> LLVMModuleCompiler::GetTransitionPc(uint32_t pc,
                                                            bool taken) const {
  auto transition = transitions_.find(pc);
  if (transition == transitions_.end())
    return std::nullopt;
  uint32_t target =
      taken ? transition->second.taken : transition->second.not_taken;
  if (target == 0)
    return std::nullopt;
  return target;
}

llvm::BasicBlock* LLVMModuleCompiler::GetTransitionBlock(BlockCtx* ctx,
                                                         bool taken,
                                                         uint32_t return_code) {
  std::optional<uint32_t> pc = GetTransitionPc(ctx->bb_pc, taken);
  if (pc.has_value() && decoder_cache_.contains(*pc))
    return CompileBlock(&ctx->function_ctx, *pc);

  llvm::BasicBlock* bb = llvm::BasicBlock::Create(
      ctx->function_ctx.llvm_ctx, "return_block", ctx->function_ctx.function);
  llvm::IRBuilder<> ret(bb);
  ret.CreateRet(ret.getInt32(return_code));
  return bb;
}

void LLVMModuleCompiler::CompileBeqWrapper(const Instruction& instr,
                                           BlockCtx* ctx,
                                           ToySimBBBuilder& builder) {
  assert(instr.type_ == CommandType::kBeq);
  assert_ctx(ctx);

  auto* true_bb = GetTransitionBlock(ctx, true, kBeqReturnCode);
  auto* false_bb = GetTransitionBlock(ctx, false, kBeqReturnCode);
  builder.EmitBeq(instr, true_bb, false_bb, ctx->function_ctx.builder_ctx);
}

void LLVMModuleCompiler::CompileJWrapper(const Instruction& instr,
                                         BlockCtx* ctx,
                                         ToySimBBBuilder& builder) {
  assert(instr.type_ == CommandType::kJ);
  assert_ctx(ctx);

  auto* bb = GetTransitionBlock(ctx, true, kJReturnCode);
  builder.EmitJ(instr, bb, ctx->function_ctx.builder_ctx);
}

void LLVMModuleCompiler::CompileSyscallWrapper(const Instruction& instr,
                                               BlockCtx* ctx,
                                               ToySimBBBuilder& builder) {
  assert(instr.type_ == CommandType::kSyscall);
  assert_ctx(ctx);

  auto& builder_ref = builder.GetBuilder();
  builder_ref.CreateRet(builder_ref.getInt32(kSyscallReturnCode));
}

void LLVMModuleCompiler::CompileInstruction(const Instruction& instr,
                                            BlockCtx* ctx,
                                            ToySimBBBuilder& builder) {
  assert_ctx(ctx);

  switch (instr.type_) {
    case CommandType::kLd:
      return builder.EmitLd(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kAdd:
      return builder.EmitAdd(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kLi:
      return builder.EmitLi(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kSt:
      return builder.EmitSt(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kStp:
      return builder.EmitStp(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kAddi:
      return builder.EmitAddi(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kLdPost:
      return builder.EmitLdPost(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kNor:
      return builder.EmitNor(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kSsat:
      return builder.EmitSsat(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kRbit:
      return builder.EmitRbit(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kBext:
      return builder.EmitBext(instr, ctx->function_ctx.builder_ctx);
    case CommandType::kUsat:
      return builder.EmitUsat(instr, ctx->function_ctx.builder_ctx);
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
                                           BlockCtx* ctx,
                                           ToySimBBBuilder& builder) {
  assert_ctx(ctx);
  switch (instr.type_) {
    case CommandType::kBeq:
      return CompileBeqWrapper(instr, ctx, builder);
    case CommandType::kJ:
      return CompileJWrapper(instr, ctx, builder);
    case CommandType::kSyscall:
      return CompileSyscallWrapper(instr, ctx, builder);
    default:
      assert(0 && "Compiler: unknown terminator");
      std::unreachable();
  }
}

void LLVMModuleCompiler::OptimizeFunction(llvm::Function& function) {
  llvm::LoopAnalysisManager loop_analysis_mngr{};
  llvm::FunctionAnalysisManager function_analysis_mngr{};
  llvm::CGSCCAnalysisManager cgscc_analysis_mngr{};
  llvm::ModuleAnalysisManager module_analysis_mngr{};
  llvm::PassBuilder pass_builder;
  pass_builder.registerModuleAnalyses(module_analysis_mngr);
  pass_builder.registerCGSCCAnalyses(cgscc_analysis_mngr);
  pass_builder.registerFunctionAnalyses(function_analysis_mngr);
  pass_builder.registerLoopAnalyses(loop_analysis_mngr);
  pass_builder.crossRegisterProxies(loop_analysis_mngr, function_analysis_mngr,
                                    cgscc_analysis_mngr, module_analysis_mngr);

  llvm::FunctionPassManager function_pass_mngr{};
  function_pass_mngr.addPass(llvm::EarlyCSEPass(true));
  function_pass_mngr.addPass(llvm::InstCombinePass());
  function_pass_mngr.addPass(llvm::ReassociatePass());
  function_pass_mngr.addPass(llvm::GVNPass());
  function_pass_mngr.addPass(llvm::InstCombinePass());
  function_pass_mngr.addPass(llvm::SimplifyCFGPass());

  function_pass_mngr.run(function, function_analysis_mngr);
}

llvm::BasicBlock* LLVMModuleCompiler::CompileBlock(FunctionCtx* ctx,
                                                   uint32_t pc) {
  for (const auto& [block_pc, block] : ctx->blocks) {
    if (block_pc == pc)
      return block;
  }
  auto* bb =
      llvm::BasicBlock::Create(ctx->llvm_ctx, kGetNameByPc(pc), ctx->function);
  ctx->blocks.emplace_back(pc, bb);
  BlockCtx block_ctx{
      .function_ctx = *ctx,
      .bb = bb,
      .bb_pc = pc,
  };

  ToySimBBBuilder builder{bb};
  auto cached_block = decoder_cache_.find(pc);
  assert(cached_block != decoder_cache_.end() &&
         "Compiler: block must be cached");
  DecodedBlock& decoded = cached_block->second;

  size_t i = 0;
  for (; !IsTerminator(decoded.instructions[i]); ++i) {
    CompileInstruction(decoded.instructions[i], &block_ctx, builder);
  }
  CompileTerminator(decoded.instructions[i], &block_ctx, builder);

  return bb;
}

llvm::orc::ThreadSafeModule LLVMModuleCompiler::CreateBlockFunction(
    uint32_t pc) {

  // ------------------------------- fuction_preparation ------------------------

  auto llvm_ctx = std::make_unique<llvm::LLVMContext>();
  std::unique_ptr<llvm::Module> module =
      std::make_unique<llvm::Module>(kGetNameByPc(pc), *llvm_ctx);

  auto* ptr_type = llvm::PointerType::get(*llvm_ctx, 0);
  const std::vector<llvm::Type*> args = {ptr_type, ptr_type, ptr_type};
  llvm::FunctionType* func_type =
      llvm::FunctionType::get(llvm::Type::getInt32Ty(*llvm_ctx), args, false);

  llvm::Function* function = llvm::Function::Create(
      func_type, llvm::Function::ExternalLinkage, kGetNameByPc(pc), *module);

  function->getArg(kMemArg)->setName("mem");
  function->getArg(kMemArg)->addAttr(llvm::Attribute::AttrKind::NoAlias);
  function->getArg(kRegArg)->setName("regs");
  function->getArg(kRegArg)->addAttr(llvm::Attribute::AttrKind::NoAlias);
  function->getArg(kPcArg)->setName("pc");
  function->getArg(kPcArg)->addAttr(llvm::Attribute::AttrKind::NoAlias);

  // --------------------------- end_function_preparation -----------------------

  FunctionCtx function_ctx{
      .llvm_ctx = *llvm_ctx,
      .function = function,
      .builder_ctx =
          {
              .mem = function->getArg(kMemArg),
              .regs = function->getArg(kRegArg),
              .pc = function->getArg(kPcArg),
          },
      .blocks = {},
  };
  llvm::BasicBlock* entry =
      llvm::BasicBlock::Create(*llvm_ctx, "entry", function);
  llvm::BasicBlock* first_bb = CompileBlock(&function_ctx, pc);
  llvm::IRBuilder<>(entry).CreateBr(first_bb);

  if (llvm::verifyFunction(*function)) {
    throw std::runtime_error("JIT : incorrect function");
  }
  if (llvm::verifyModule(*module)) {
    throw std::runtime_error("JIT : incorrect module");
  }
  OptimizeFunction(*function);

  return {std::move(module), std::move(llvm_ctx)};
}

}  // namespace toy_sim

#undef assert_ctx
