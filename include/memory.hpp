#ifndef MEMORY_HPP_
#define MEMORY_HPP_

#include <algorithm>
#include <cstdint>
#include <cstring>
#include <stdexcept>
#include <vector>

#include "encoding.hpp"

namespace toy_sim {

class Memory {
 public:
  explicit Memory(size_t mem_size) : mem_size_(mem_size), data_(mem_size) {}

  uint32_t Read(uint32_t addr) {
    if (addr > mem_size_ - 4)
      throw std::runtime_error("Segfault");
#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
    uint32_t ret = static_cast<uint32_t>(data_[addr]) |
                   static_cast<uint32_t>(data_[addr + 1]) << 8 |
                   static_cast<uint32_t>(data_[addr + 2]) << 16 |
                   static_cast<uint32_t>(data_[addr + 3]) << 24;
#else
    uint32_t ret = 0;
    memcpy(&ret, data_.data() + addr, sizeof(uint32_t));

#endif

    return ret;
  }

  void Write(uint32_t addr, uint32_t var) {
    if (addr > mem_size_ - 4)
      throw std::runtime_error("Segfault");
#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
    data_[addr] = static_cast<std::byte>(var);
    data_[addr + 1] = static_cast<std::byte>(var >> 8);
    data_[addr + 2] = static_cast<std::byte>(var >> 16);
    data_[addr + 3] = static_cast<std::byte>(var >> 24);
#else
    memcpy(data_.data() + addr, &var, sizeof(uint32_t));
#endif
  }

 private:
  size_t mem_size_{};
  std::vector<std::byte> data_;
};
}  // namespace toy_sim

#endif  // MEMORY_HPP_