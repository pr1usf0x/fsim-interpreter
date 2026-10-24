#include <CLI/CLI.hpp>
#include <exception>
#include <iostream>
#include "llvm/IR/LLVMContext.h"
#include "machine.hpp"
#include "jit/llvm_compiler.hpp"


int main(int argc, char** argv) {
  CLI::App app{"Toy simulator for toy ISA."};
  argv = app.ensure_utf8(argv);
  std::string file_input{};
  app.add_option("-f,--file,file", file_input, "file_input")->required();
  CLI11_PARSE(app, argc, argv);

  try {
    const size_t k_mem_size = 1 << 19;
    toy_sim::Machine machine(k_mem_size);
    machine.RunProgram(file_input);
  } catch (const std::exception& e) {
    std::cerr << e.what();
  }
  return 0;
}