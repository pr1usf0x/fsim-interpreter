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

 private:
  // static constexpr size_t kPcArg = 0;
  // static constexpr size_t kRegArg = 1;
  // static constexpr size_t kMemArg = 2;
  // static constexpr auto kGetBlockName = [](uint32_t pc) {
  //   return "block_" + std::to_string(pc);
  // };

  // emiters

  void EmitLd(const Instruction& instr, llvm::Value* mem, llvm::Value* regs,
              llvm::Value* pc);

  llvm::Value* GetRegisterPtr(Register reg);
  llvm::Value* GetMemPtr(uint32_t mem_addr);

  llvm::IRBuilder<> b_;
};
}  // namespace toy_sim

#endif  // LLVM_COMPILER_HPP_
