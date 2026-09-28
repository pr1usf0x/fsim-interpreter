#ifndef CPU_EXECUTOR_HPP_
#define CPU_EXECUTOR_HPP_

#include "cpu/decoder.hpp"

namespace toy_sim {

class Cpu;
void Execute(Cpu& cpu, Instruction instr);

void ExecuteLd(Cpu&, const Instruction*);
void ExecuteSt(Cpu&, const Instruction*);
void ExecuteStp(Cpu&, const Instruction*);
void ExecuteLdPost(Cpu&, const Instruction*);
void ExecuteAdd(Cpu&, const Instruction*);
void ExecuteBeq(Cpu&, const Instruction*);
void ExecuteLi(Cpu&, const Instruction*);
void ExecuteAddi(Cpu&, const Instruction*);
void ExecuteJ(Cpu&, const Instruction*);
void ExecuteNor(Cpu&, const Instruction*);
void ExecuteSsat(Cpu&, const Instruction*);
void ExecuteRbit(Cpu&, const Instruction*);
void ExecuteSyscall(Cpu&, const Instruction*);
void ExecuteBext(Cpu&, const Instruction*);
void ExecuteUsat(Cpu&, const Instruction*);
void ExecuteUnknown(Cpu&, const Instruction*);

}  // namespace toy_sim

#endif  // CPU_EXECUTOR_HPP_
