#include <bitset>
#include <exception>
#include <iostream>
#include <stdexcept>
#include "machine.hpp"

int main() {
  try {
    toy_sim::Machine machine(1 << 16);
    machine.RunProgram("tests/fibs.bin");
  } catch (const std::exception& e) {
    std::cerr << e.what();
  }
  return 0;
}