#ifndef MODULE_COMPILER_HPP_
#define MODULE_COMPILER_HPP_

#include <cstddef>
#include <cstdint>
#include <memory>
#include <string>
#include "cpu/decoder.hpp"
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

  struct CompileCtx {
    llvm::LLVMContext& llvm_ctx;
    llvm::BasicBlock* bb;
    ToySimBBBuilder& builder;
    size_t bb_pc;
    ToySimBBBuilder::BuilderCtx& builder_ctx;
    llvm::Function* function;
  };

  void CompileJ(const Instruction& instr, CompileCtx* ctx);

  void CompileBeq(const Instruction& instr, CompileCtx* ctx);

  static void CompileSyscall(const Instruction& instr, CompileCtx* ctx);

  static void CompileInstruction(const Instruction& instr, CompileCtx* ctx);

  void CompileTerminator(const Instruction& instr, CompileCtx* ctx);

  static constexpr size_t kMemArg = 0;
  static constexpr size_t kRegArg = 1;
  static constexpr size_t kPcArg = 2;

 public:
  explicit LLVMModuleCompiler(DecoderCache& decoder_cache)
      : decoder_cache_(decoder_cache) {}

  llvm::orc::ThreadSafeModule CreateBlockFunction(
      const DecodedBlock& decoded_bb);

  static constexpr uint32_t kSyscallReturnCode =
      static_cast<uint32_t>(CommandType::kSyscall);
  static constexpr uint32_t kJReturnCode =
      static_cast<uint32_t>(CommandType::kJ);
  static constexpr uint32_t kBeqReturnCode =
      static_cast<uint32_t>(CommandType::kBeq);
};
}  // namespace toy_sim

#endif  // MODULE_COMPILER_HPP_
