#ifndef MACHINE_HPP_
#define MACHINE_HPP_

#include "cpu.hpp"
#include "kernel.hpp"
#include "memory.hpp"

namespace toy_sim {

class Machine {
 public:
  explicit Machine(size_t mem_size)
      : memory_(mem_size), cpu_(memory_), kernel_(cpu_) {};

 private:
  Memory memory_;
  Cpu cpu_;
  Kernel kernel_;
};
}  // namespace toy_sim

#endif  // MACHINE_HPP_