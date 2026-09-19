#ifndef MACHINE_HPP_
#define MACHINE_HPP_

#include "cpu.hpp"
#include "memory.hpp"
#include "kernel.hpp"

namespace toy_sim {

class Machine {
 public:
  Machine() : cpu_(memory_) {};

 private:
  Memory memory_;
  Cpu cpu_;
  Kernel kernel_;
};
}  // namespace toy_sim

#endif  // MACHINE_HPP_