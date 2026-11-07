#ifndef JIT_HPP_
#define JIT_HPP_

#include <cstddef>
#include <cstdint>
#include <memory>
#include <stdexcept>
#include <unordered_map>
#include <utility>
#include <vector>
#include "cpu/decoder.hpp"
#include "cpu/executor.hpp"
#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/ExecutorProcessControl.h"
#include "llvm/ExecutionEngine/Orc/IRCompileLayer.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/Mangling.h"
#include "llvm/ExecutionEngine/Orc/RTDyldObjectLinkingLayer.h"
#include "llvm/ExecutionEngine/Orc/SelfExecutorProcessControl.h"
#include "llvm/ExecutionEngine/Orc/Shared/ExecutorSymbolDef.h"
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Error.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/module_compiler.hpp"

namespace toy_sim {

class LLVMCompiler {
 private:
  std::unique_ptr<llvm::orc::ExecutionSession> es_;
  std::unique_ptr<llvm::DataLayout> dl_;
  std::unique_ptr<llvm::orc::MangleAndInterner> mangle_;
  std::unique_ptr<llvm::orc::RTDyldObjectLinkingLayer> object_layer_;
  std::unique_ptr<llvm::orc::IRCompileLayer> compile_layer_;
  llvm::orc::JITDylib* main_jd_;
  std::unique_ptr<LLVMModuleCompiler> module_compiler_;

 public:
  explicit LLVMCompiler(DecoderCache& decoder_cache) {
    if (llvm::InitializeNativeTarget() ||
        llvm::InitializeNativeTargetAsmPrinter()) {
      throw std::runtime_error("JIT: failed to initialize native target");
    }

    auto epc = llvm::orc::SelfExecutorProcessControl::Create();
    if (!epc)
      throw std::runtime_error("JIT: failed to construct JIT");
    es_ = std::make_unique<llvm::orc::ExecutionSession>(std::move(*epc));

    llvm::orc::JITTargetMachineBuilder jtmb(
        es_->getExecutorProcessControl().getTargetTriple());

    auto dl = jtmb.getDefaultDataLayoutForTarget();
    if (!dl)
      throw std::runtime_error("JIT: failed to get memory layout");
    dl_ = std::make_unique<llvm::DataLayout>(std::move(*dl));

    mangle_ = std::make_unique<llvm::orc::MangleAndInterner>(*es_, *dl_);
    object_layer_ = std::make_unique<llvm::orc::RTDyldObjectLinkingLayer>(
        *es_, [](const llvm::MemoryBuffer&) {
          return std::make_unique<llvm::SectionMemoryManager>();
        });
    compile_layer_ = std::make_unique<llvm::orc::IRCompileLayer>(
        *es_, *object_layer_,
        std::make_unique<llvm::orc::ConcurrentIRCompiler>(std::move(jtmb)));
    main_jd_ = &es_->createBareJITDylib("<main>");

    main_jd_->addGenerator(
        cantFail(llvm::orc::DynamicLibrarySearchGenerator::GetForCurrentProcess(
            dl_->getGlobalPrefix())));

    module_compiler_ = std::make_unique<LLVMModuleCompiler>(decoder_cache);
  }

  block_func Compile(const DecodedBlock& decoded_block) {
    auto rt = main_jd_->getDefaultResourceTracker();
    auto module = module_compiler_->CreateBlockFunction(decoded_block);
    module.getModuleUnlocked()->setDataLayout(*dl_);
    module.getModuleUnlocked()->print(llvm::outs(), nullptr);
    if (compile_layer_->add(rt, std::move(module))) {
      throw std::runtime_error("JIT : failed to compile");
    }
    return (es_->lookup({main_jd_}, (*mangle_)(kGetNameByPc(decoded_block.pc))))
        ->getAddress()
        .toPtr<uint32_t (*)(std::byte*, uint32_t*, uint32_t*)>();
    ;
  }

  ~LLVMCompiler() {
    if (auto err = es_->endSession())
      es_->reportError(std::move(err));
  }
};
}  // namespace toy_sim

#endif  // JIT_HPP_
