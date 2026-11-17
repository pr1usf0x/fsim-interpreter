#ifndef MODULE_COMPILER_HPP_
#define MODULE_COMPILER_HPP_

#include <cstddef>
#include <cstdint>
#include <memory>
#include <optional>
#include <string>
#include <utility>
#include <vector>
#include "cpu/decoder.hpp"
#include "cpu/transitions.hpp"
#include "encoding.hpp"
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/IR/Module.h"
#include "llvm/builder_wrapper.hpp"

namespace llvm {
class BasicBlock;
class Function;
class LLVMContext;
}  // namespace llvm

constexpr auto kGetNameByPc = [](uint32_t pc) {
  return "block_" + std::to_string(pc);
};

namespace toy_sim {
class LLVMModuleCompiler {
 private:
  DecoderCache& decoder_cache_;
  const TransitionTable& transitions_;
  struct FunctionCtx {
    llvm::LLVMContext& llvm_ctx;
    llvm::Function* function;
    ToySimBBBuilder::ArgumentCtx builder_ctx;
    std::vector<std::pair<uint32_t, llvm::BasicBlock*>> blocks;
  };

  struct BlockCtx {
    FunctionCtx& function_ctx;
    llvm::BasicBlock* bb;
    size_t bb_pc;
  };

  std::optional<uint32_t> GetTransitionPc(uint32_t pc, bool taken) const;
  llvm::BasicBlock* GetTransitionBlock(BlockCtx* ctx, bool taken,
                                       uint32_t return_code);

  void CompileJWrapper(const Instruction& instr, BlockCtx* ctx,
                       ToySimBBBuilder& builder);

  void CompileBeqWrapper(const Instruction& instr, BlockCtx* ctx,
                         ToySimBBBuilder& builder);

  static void CompileSyscallWrapper(const Instruction& instr, BlockCtx* ctx,
                                    ToySimBBBuilder& builder);

  static void CompileInstruction(const Instruction& instr, BlockCtx* ctx,
                                 ToySimBBBuilder& builder);

  void CompileTerminator(const Instruction& instr, BlockCtx* ctx,
                         ToySimBBBuilder& builder);

  llvm::BasicBlock* CompileBlock(FunctionCtx* ctx, uint32_t pc);

  static constexpr size_t kMemArg = 0;
  static constexpr size_t kRegArg = 1;
  static constexpr size_t kPcArg = 2;

 public:
  explicit LLVMModuleCompiler(DecoderCache& decoder_cache,
                              const TransitionTable& transitions)
      : decoder_cache_(decoder_cache), transitions_(transitions) {}

  llvm::orc::ThreadSafeModule CreateBlockFunction(uint32_t pc);

  static void OptimizeFunction(llvm::Function& function);

  static constexpr uint32_t kSyscallReturnCode =
      static_cast<uint32_t>(CommandType::kSyscall);
  static constexpr uint32_t kJReturnCode =
      static_cast<uint32_t>(CommandType::kJ);
  static constexpr uint32_t kBeqReturnCode =
      static_cast<uint32_t>(CommandType::kBeq);
};
}  // namespace toy_sim

#endif  // MODULE_COMPILER_HPP_
