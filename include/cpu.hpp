#ifndef CPU_HPP_
#define CPU_HPP_

#include <memory>
#include "memory.hpp"

namespace toy_sim {
class Cpu {
 public:
  explicit Cpu(Memory& memory) : memory_(memory) {};

 private:
  Memory& memory_;
};
}  // namespace toy_sim

#endif  // CPU_HPP_