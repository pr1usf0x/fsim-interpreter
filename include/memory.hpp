#ifndef MEMORY_HPP_
#define MEMORY_HPP_

#include <cstdint>
#include <stdexcept>
#include <vector>

#include "encoding.hpp"

namespace toy_sim {

constexpr size_t kMemorySize = 1 << 16;
class Memory {
  // https://godbolt.org/z/c9dE9W
 public:
  Memory() : data_(kMemorySize) {}

  uint32_t Read(uint32_t addr) {
    if (addr > kMemorySize - 4)
      throw std::runtime_error("Segfault");
    return static_cast<uint32_t>(data_[addr]) |
           static_cast<uint32_t>(data_[addr + 1]) << 8 |
           static_cast<uint32_t>(data_[addr + 2]) << 16 |
           static_cast<uint32_t>(data_[addr + 3]) << 24;
  }

  void Write(uint32_t addr, uint32_t var) {
    if (addr > kMemorySize - 4)
      throw std::runtime_error("Segfault");
    data_[addr] = static_cast<std::byte>(var);
    data_[addr + 1] = static_cast<std::byte>(var >> 8);
    data_[addr + 2] = static_cast<std::byte>(var >> 16);
    data_[addr + 3] = static_cast<std::byte>(var >> 24);
  }

 private:
  std::vector<std::byte> data_;
};
}  // namespace toy_sim

#endif  // MEMORY_HPP_