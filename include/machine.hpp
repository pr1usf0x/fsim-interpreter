#ifndef MACHINE_HPP_
#define MACHINE_HPP_

#include "cpu.hpp"
#include "memory.hpp"

namespace toy_sim {

class Machine {
 public:
  Machine() : memory_(), cpu_(memory_) {

  }

 private:
  Memory memory_;
  Cpu cpu_;
};
}  // namespace toy_sim

#endif  // MACHINE_HPP_