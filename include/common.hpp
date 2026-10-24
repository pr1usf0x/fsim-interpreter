#ifndef COMMON_HPP
#define COMMON_HPP

#include <cassert>
#include <cstdlib>
#include <algorithm>

namespace toy_sim {

inline uint32_t SaturateSigned(uint32_t num, size_t n) {
  assert(n <= 31);
  if (n == 0)
    return 0;
  int32_t min_n_int = -(1U << (n - 1));
  int32_t max_n_int = (1U << (n - 1)) - 1;
  return static_cast<int32_t>(num) > 0
             ? std::min<int32_t>(max_n_int, static_cast<int32_t>(num))
             : std::max<int32_t>(min_n_int, static_cast<int32_t>(num));
}

inline uint32_t SaturateUnsigned(uint32_t num, size_t n) {
  assert(n <= 32);
  uint32_t max_n_uint = ~0U >> ((sizeof(uint32_t) * 8) - n);
  return std::min<uint32_t>(max_n_uint, num);
}

} // namespace toy_sim

#endif // COMMON_HPP