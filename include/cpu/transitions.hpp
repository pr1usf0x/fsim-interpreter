#ifndef CPU_TRANSITIONS_HPP_
#define CPU_TRANSITIONS_HPP_

#include <cstdint>
#include <unordered_map>

namespace toy_sim {

struct Transition {
  uint32_t taken{};
  uint32_t not_taken{};
};

using TransitionTable = std::unordered_map<uint32_t, Transition>;

}  // namespace toy_sim

#endif  // CPU_TRANSITIONS_HPP_
