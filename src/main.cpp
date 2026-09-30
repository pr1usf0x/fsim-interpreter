#include <exception>
#include <iostream>
#include "machine.hpp"
#include <CLI/CLI.hpp>

int main(int argc, char** argv) {
  CLI::App app{"Toy simulator for toy ISA."};
  argv = app.ensure_utf8(argv);
  std::string config_filename{};
  app.add_option("-f,--file,file", config_filename, "Config")->required();
  CLI11_PARSE(app, argc, argv);

  try {
    toy_sim::Machine machine(1 << 16);
    machine.RunProgram(config_filename);
  } catch (const std::exception& e) {
    std::cerr << e.what();
  }
  return 0;
}