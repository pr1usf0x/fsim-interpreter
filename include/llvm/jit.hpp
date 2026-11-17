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
 public:
  using CompiledFunction = uint32_t (*)(std::byte*, uint32_t*, uint32_t*);

 private:
  class BlockFunc {
   private:
    CompiledFunction block_ = nullptr;
    llvm::orc::ResourceTrackerSP resource_tracker_ = nullptr;

   public:
    BlockFunc() = default;
    BlockFunc(CompiledFunction block,
              llvm::orc::ResourceTrackerSP resource_tracker)
        : block_(block), resource_tracker_(std::move(resource_tracker)) {}

    CompiledFunction GetBlock() const { return block_; }
    const llvm::orc::ResourceTrackerSP& GetResourceTracker() const {
      return resource_tracker_;
    }

    BlockFunc(const BlockFunc&) = delete;
    BlockFunc& operator=(const BlockFunc&) = delete;
    BlockFunc(const BlockFunc&&) = delete;
    BlockFunc& operator=(const BlockFunc&&) = delete;
    ~BlockFunc() {
      if (resource_tracker_) {
        llvm::cantFail(resource_tracker_->remove());
      }
    };
  };

  std::unique_ptr<llvm::orc::ExecutionSession> es_;
  std::unique_ptr<llvm::DataLayout> dl_;
  std::unique_ptr<llvm::orc::MangleAndInterner> mangle_;
  std::unique_ptr<llvm::orc::RTDyldObjectLinkingLayer> object_layer_;
  std::unique_ptr<llvm::orc::IRCompileLayer> compile_layer_;
  llvm::orc::JITDylib* main_jd_;
  std::unique_ptr<LLVMModuleCompiler> module_compiler_;
  std::unordered_map<uint32_t, BlockFunc> compiled_blocks_;

 public:
  explicit LLVMCompiler(DecoderCache& decoder_cache,
                        const TransitionTable& transitions) {
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

    module_compiler_ =
        std::make_unique<LLVMModuleCompiler>(decoder_cache, transitions);
  }

  CompiledFunction GetCompiled(uint32_t pc) {
    auto it = compiled_blocks_.find(pc);
    if (it != compiled_blocks_.end()) {
      return it->second.GetBlock();
    }

    auto rt = main_jd_->createResourceTracker();
    auto module = module_compiler_->CreateBlockFunction(pc);
    module.getModuleUnlocked()->setDataLayout(*dl_);
    if (compile_layer_->add(rt, std::move(module))) {
      throw std::runtime_error("JIT : failed to compile");
    }
    auto symbol = es_->lookup({main_jd_}, (*mangle_)(kGetNameByPc(pc)));
    if (!symbol) {
      throw std::runtime_error(llvm::toString(symbol.takeError()));
    }
    auto block = symbol->getAddress().toPtr<CompiledFunction>();
    return compiled_blocks_.try_emplace(pc, block, std::move(rt))
        .first->second.GetBlock();
  }

  ~LLVMCompiler() {
    if (auto err = es_->endSession())
      es_->reportError(std::move(err));
  }
};
}  // namespace toy_sim

#endif  // JIT_HPP_
