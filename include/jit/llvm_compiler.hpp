#ifndef LLVM_COMPILER_HPP_
#define LLVM_COMPILER_HPP_

#include <cstdint>
#include <memory>
#include <string>
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
class ToyISAModule {
 public:
  static constexpr auto kGetBlockName = [](uint32_t pc) {
    return "block_" + std::to_string(pc);
  };

  explicit ToyISAModule(uint32_t pc, llvm::LLVMContext& ctx,
                        const DecodedBlock& decoded);

 private:
  static constexpr size_t kPcArg = 0;
  static constexpr size_t kRegArg = 1;
  static constexpr size_t kMemArg = 2;

  llvm::Value* GetRegisterPtr(Register reg);
  llvm::Value* GetMemPtr(uint32_t mem_addr);

  llvm::LLVMContext& ctx_;
  std::unique_ptr<llvm::Module> module_;
  llvm::IRBuilder<> builder_;
  llvm::Function* fn_{nullptr};
  llvm::BasicBlock* bb_{nullptr};
};
}  // namespace toy_sim

#endif  // LLVM_COMPILER_HPP_
