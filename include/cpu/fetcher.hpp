#ifndef FETCHER_HPP
#define FETCHER_HPP

#include <cctype>
#include <cstdint>
#include "memory.hpp"

namespace toy_sim {
class Fetcher {
 public:
  explicit Fetcher(const Memory& memory) : memory_(memory) {}
  uint32_t Fetch(uint32_t addr) const { return memory_.Read(addr); }

 private:
  const Memory& memory_;
};
} // namespace toy_sim

#endif  // FETCHER_HPP