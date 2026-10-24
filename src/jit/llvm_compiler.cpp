#include "jit/llvm_compiler.hpp"

#include <cassert>
#include <cstdint>
#include <memory>
#include <string>
#include <utility>
#include "cpu/decoder.hpp"
#include "encoding.hpp"

#include "llvm/ADT/APInt.h"
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

void ToySimBBBuilder::EmitLd(const Instruction& instr, llvm::Value* mem,
                             llvm::Value* regs, llvm::Value* pc) {
  assert(mem);
  assert(regs);
  assert(pc);

  uint32_t imm_signed = SignExtend(instr.imm_, 14);

}



}  // namespace toy_sim
