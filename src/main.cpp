#include <CLI/CLI.hpp>
#include <exception>
#include <iostream>
#include "llvm/IR/LLVMContext.h"
#include "llvm/builder_wrapper.hpp"
#include "machine.hpp"

constexpr size_t kDefaultThreshold = 100;
const size_t kDefaultMemSize = 1U << 19;

int main(int argc, char** argv) {
  CLI::App app{"Toy simulator for toy ISA."};
  argv = app.ensure_utf8(argv);
  std::string file_input{};
  size_t threshold = kDefaultThreshold;
  size_t mem_size = kDefaultMemSize;
  app.add_option("-f,--file,file", file_input, "File Input")->required();
  app.add_option("-t,--threshold,threshold", threshold, "Threshold");
  app.add_option("-m,--memory-size,memory-size", mem_size, "Machine memory size");
  CLI11_PARSE(app, argc, argv);
  try {
    toy_sim::Machine machine(mem_size, threshold);
    machine.RunProgram(file_input);
  } catch (const std::exception& e) {
    std::cerr << e.what();
  }
  return 0;
}

// 2) advanced
// check(arg = ReadArg(), arr[push].flags)
// codePush(arg)
