#include <gtest/gtest.h>
#include <cstddef>
#include "cpu.hpp"
#include "encoding.hpp"
#include "kernel.hpp"
#include "machine.hpp"
#include "memory.hpp"
#include "microasm.hpp"

namespace toy_sim {
namespace {
constexpr size_t kMemorySize = 1 << 16;
}  // namespace

class FuckedExecutorLdTest : public testing::Test {
 protected:
  void Test(uint32_t addr, uint32_t val, Register base, Register target,
            int32_t offset) {
    memory_.Write(addr + offset, val);
    cpu_.SetRegister(base, addr);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kLd,
                  .r1_ = base,
                  .r2_ = target,
                  .r3_ = Register::kX0,
                  .imm_ = static_cast<uint32_t>(offset)});
    EXPECT_EQ(cpu_.GetRegister(target), val);
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedExecutorLdTest, LdTest1) {
  Test(0x0, 1488, Register::kX1, Register::kX3, 0x0);
}
TEST_F(FuckedExecutorLdTest, LdTest2) {
  Test(0x100, 666, Register::kX4, Register::kX14, 0xFC);
}
TEST_F(FuckedExecutorLdTest, LdTest3) {
  Test(0x200, 6767, Register::kX10, Register::kX3, 0x08);
}
TEST_F(FuckedExecutorLdTest, LdTest4) {
  Test(0x500, 0xFFFF, Register::kX22, Register::kX23, -8);
}

class FuckedExecutorAddTest : public testing::Test {
 protected:
  void Test(uint32_t val1, uint32_t val2, Register rs, Register rt,
            Register rd) {
    cpu_.SetRegister(rs, val1);
    cpu_.SetRegister(rt, val2);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kAdd,
                  .r1_ = rs,
                  .r2_ = rt,
                  .r3_ = rd,
                  .imm_ = 0});
    EXPECT_EQ(cpu_.GetRegister(rd), val1 + val2);
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedExecutorAddTest, AddTest1) {
  Test(100, 200, Register::kX1, Register::kX2, Register::kX3);
}
TEST_F(FuckedExecutorAddTest, AddTest2) {
  Test(67, 67, Register::kX2, Register::kX1, Register::kX31);
}
TEST_F(FuckedExecutorAddTest, AddTest3) {
  Test(0x55555555, 0xAAAAAAAA, Register::kX14, Register::kX23, Register::kX30);
}
TEST_F(FuckedExecutorAddTest, AddTest4) {
  Test(0xFFFF, 1, Register::kX31, Register::kX30, Register::kX1);
}

class FuckedExecutorBeqTest : public testing::Test {
 protected:
  void Test(uint32_t pc_val, uint32_t val1, uint32_t val2, Register rs,
            Register rt, int32_t offset) {
    cpu_.SetRegister(Register::kPc, pc_val);
    cpu_.SetRegister(rs, val1);
    cpu_.SetRegister(rt, val2);
    cpu_.Execute({.type_ = CommandType::kBeq,
                  .r1_ = rs,
                  .r2_ = rt,
                  .r3_ = Register::kX0,
                  .imm_ = static_cast<uint32_t>(offset)});
    if (val1 == val2) {
      EXPECT_EQ(cpu_.GetRegister(Register::kPc), pc_val + offset * 4);
    } else {
      EXPECT_EQ(cpu_.GetRegister(Register::kPc), pc_val + sizeof(uint32_t));
    }
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedExecutorBeqTest, BeqTest1) {
  Test(100, 5, 5, Register::kX1, Register::kX2, 2);
}
TEST_F(FuckedExecutorBeqTest, BeqTest2) {
  Test(100, 5, 666, Register::kX20, Register::kX2, -25);
}
TEST_F(FuckedExecutorBeqTest, BeqTest3) {
  Test(9000, 67, 67, Register::kX22, Register::kX29, 30);
}
TEST_F(FuckedExecutorBeqTest, BeqTest4) {
  Test(9000, 67, 67, Register::kX22, Register::kX29, -9000);
}

class FuckedExecutorStTest : public testing::Test {
 protected:
  void Test(uint32_t addr, uint32_t val, Register base, Register rt,
            int32_t offset) {
    cpu_.SetRegister(base, addr);
    cpu_.SetRegister(rt, val);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kSt,
                  .r1_ = base,
                  .r2_ = rt,
                  .r3_ = Register::kX0,
                  .imm_ = static_cast<uint32_t>(offset)});
    EXPECT_EQ(memory_.Read(addr + offset), val);
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedExecutorStTest, StTest1) {
  Test(1000, 666, Register::kX6, Register::kX7, 16);
}
TEST_F(FuckedExecutorStTest, StTest2) {
  Test(1488, 1337, Register::kX13, Register::kX17, 0);
}
TEST_F(FuckedExecutorStTest, StTest3) {
  Test(3000, 0x67676767, Register::kX10, Register::kX22, -1000);
}
TEST_F(FuckedExecutorStTest, StTest4) {
  Test(4000, 0, Register::kX4, Register::kX5, 100);
}

class FuckedStpTest : public testing::Test {
 protected:
  void Test(uint32_t addr, uint32_t val1, uint32_t val2, Register base,
            Register rt1, Register rt2, int32_t offset) {
    cpu_.SetRegister(base, addr);
    cpu_.SetRegister(rt1, val1);
    cpu_.SetRegister(rt2, val2);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kStp,
                  .r1_ = base,
                  .r2_ = rt1,
                  .r3_ = rt2,
                  .imm_ = static_cast<uint32_t>(offset)});
    EXPECT_EQ(memory_.Read(addr + offset), val1);
    EXPECT_EQ(memory_.Read(addr + offset + sizeof(uint32_t)), val2);
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedStpTest, StpTest1) {
  Test(1000, 0x67676767, 0x14881488, Register::kX11, Register::kX15,
       Register::kX17, 16);
}
TEST_F(FuckedStpTest, StpTest2) {
  Test(3000, 0x0, 0x0, Register::kX10, Register::kX1, Register::kX22, -1000);
}
TEST_F(FuckedStpTest, StpTest3) {
  Test(1488, 1, 2, Register::kX9, Register::kX31, Register::kX12, 200);
}
TEST_F(FuckedStpTest, StpTest4) {
  Test(100, 6, 7, Register::kX4, Register::kX5, Register::kX1, 0);
}

class FuckedAddiTest : public testing::Test {
 protected:
  void Test(uint32_t val, Register rs, Register rt, uint32_t imm) {
    cpu_.SetRegister(rs, val);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kAddi,
                  .r1_ = rs,
                  .r2_ = rt,
                  .r3_ = Register::kX0,
                  .imm_ = imm});
    EXPECT_EQ(cpu_.GetRegister(rt), val + imm);
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedAddiTest, AddiTest1) {
  Test(100, Register::kX15, Register::kX15, 20);
}
TEST_F(FuckedAddiTest, AddiTest2) {
  Test(1488, Register::kX10, Register::kX2, -67);
}
TEST_F(FuckedAddiTest, AddiTest3) {
  Test(0x10, Register::kX9, Register::kX5, 67);
}
TEST_F(FuckedAddiTest, AddiTest4) {
  Test(0, Register::kX1, Register::kX31, 1488);
}

class FuckedJTest : public testing::Test {
 protected:
  void Test(uint32_t pc, uint32_t index) {
    cpu_.SetRegister(Register::kPc, pc);
    cpu_.Execute({.type_ = CommandType::kJ,
                  .r1_ = Register::kX0,
                  .r2_ = Register::kX0,
                  .r3_ = Register::kX0,
                  .imm_ = index});
    EXPECT_EQ(cpu_.GetRegister(Register::kPc),
              (pc & 0xF0000000) | (index << 2));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedJTest, JTest1) {
  Test(0x67676700, 0);
}
TEST_F(FuckedJTest, JTest2) {
  Test(0x1000, 1488);
}
TEST_F(FuckedJTest, JTest3) {
  Test(0, 12);
}
TEST_F(FuckedJTest, JTest4) {
  Test(0x100000, 0xFF0);
}

class FuckedExecutorLdPostTest : public testing::Test {
 protected:
  void Test(uint32_t addr, uint32_t val, Register base, Register rt,
            int32_t offset) {
    memory_.Write(addr, val);
    cpu_.SetRegister(base, addr);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kLdPost,
                  .r1_ = base,
                  .r2_ = rt,
                  .r3_ = Register::kX0,
                  .imm_ = static_cast<uint32_t>(offset)});
    EXPECT_EQ(cpu_.GetRegister(rt), val);
    EXPECT_EQ(cpu_.GetRegister(base), (uint32_t)(addr + offset));
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedExecutorLdPostTest, LdPostTest1) {
  Test(0x0, 1488, Register::kX1, Register::kX3, 0);
}
TEST_F(FuckedExecutorLdPostTest, LdPostTest2) {
  Test(0x200, 6767, Register::kX10, Register::kX3, 8);
}
TEST_F(FuckedExecutorLdPostTest, LdPostTest3) {
  Test(0xFF0, 0, Register::kX10, Register::kX20, 0x10);
}
TEST_F(FuckedExecutorLdPostTest, LdPostTest4) {
  Test(0x2000, 42, Register::kX5, Register::kX31, -1488);
}

class FuckedNorTest : public testing::Test {
 protected:
  void Test(uint32_t val1, uint32_t val2, Register rs, Register rt,
            Register rd) {
    cpu_.SetRegister(rs, val1);
    cpu_.SetRegister(rt, val2);
    size_t old_pc = cpu_.GetRegister(Register::kPc);
    cpu_.Execute({.type_ = CommandType::kNor,
                  .r1_ = rs,
                  .r2_ = rt,
                  .r3_ = rd,
                  .imm_ = 0});
    EXPECT_EQ(cpu_.GetRegister(rd), ~(val1 | val2));
    EXPECT_EQ(cpu_.GetRegister(Register::kPc), old_pc + sizeof(uint32_t));
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedNorTest, NorTest1) {
  Test(1488, 67, Register::kX14, Register::kX17, Register::kX27);
}

TEST_F(FuckedNorTest, NorTest2) {
  Test(100, 200, Register::kX2, Register::kX1, Register::kX31);
}

TEST_F(FuckedNorTest, NorTest3) {
  Test(0xFFFFFFFF, 0, Register::kX31, Register::kX6, Register::kX7);
}

TEST_F(FuckedNorTest, NorTest4) {
  Test(0, 0, Register::kX1, Register::kX1, Register::kX1);
}

//TODO сделать тесты для usat ssat ну и всякой арифметической херни

class FuckedSyscallTest : public testing::Test {
 protected:
  void Test(Syscalls syscall_num) {
    EXPECT_THROW(cpu_.Execute({.type_ = CommandType::kSyscall,
                               .r1_ = Register::kX0,
                               .r2_ = Register::kX0,
                               .r3_ = Register::kX0,
                               .imm_ = static_cast<uint32_t>(syscall_num)});
                 , SyscallException);
  }

  Memory memory_{kMemorySize};
  Cpu cpu_{memory_};
};

TEST_F(FuckedSyscallTest, NorTest1) {
  Test(Syscalls::kExit);
}

TEST(ThreadedExecutionTest, BranchesJumpsAndSyscallResume) {
  Memory memory{kMemorySize};
  Cpu cpu{memory};
  const uint32_t program[] = {
      GenLiInstr(Register::kX1, 1),
      GenBeqInstr(Register::kX1, Register::kX0, 3),
      GenAddiInstr(Register::kX1, Register::kX1, 1),
      GenBeqInstr(Register::kX1, Register::kX1, 2),
      GenAddiInstr(Register::kX1, Register::kX1, 100),
      GenJInstr(7),
      GenAddiInstr(Register::kX1, Register::kX1, 100),
      GenSyscallInstr(static_cast<uint32_t>(Syscalls::kPrintUnsigned)),
      GenAddiInstr(Register::kX1, Register::kX1, 3),
      GenSyscallInstr(static_cast<uint32_t>(Syscalls::kExit)),
  };
  for (size_t i = 0; i < sizeof(program) / sizeof(program[0]); ++i)
    memory.Write(i * sizeof(uint32_t), program[i]);

  try {
    cpu.RunProgram();
    FAIL() << "Expected syscall";
  } catch (const SyscallException& e) {
    EXPECT_EQ(e.syscall, Syscalls::kPrintUnsigned);
  }
  EXPECT_EQ(cpu.GetRegister(Register::kX1), 2u);
  EXPECT_EQ(cpu.GetRegister(Register::kPc), 8 * sizeof(uint32_t));

  try {
    cpu.RunProgram();
    FAIL() << "Expected syscall";
  } catch (const SyscallException& e) {
    EXPECT_EQ(e.syscall, Syscalls::kExit);
  }
  EXPECT_EQ(cpu.GetRegister(Register::kX1), 5u);
  EXPECT_EQ(cpu.GetRegister(Register::kPc), sizeof(program));
}

TEST(ThreadedExecutionTest, LongBasicBlock) {
  constexpr size_t kInstructionCount = 100000;
  Memory memory{(kInstructionCount + 1) * sizeof(uint32_t)};
  Cpu cpu{memory};
  for (size_t i = 0; i < kInstructionCount; ++i)
    memory.Write(i * sizeof(uint32_t),
                 GenAddiInstr(Register::kX1, Register::kX1, 1));
  memory.Write(kInstructionCount * sizeof(uint32_t),
               GenSyscallInstr(static_cast<uint32_t>(Syscalls::kExit)));

  EXPECT_THROW(cpu.RunProgram(), SyscallException);
  EXPECT_EQ(cpu.GetRegister(Register::kX1), kInstructionCount);
  EXPECT_EQ(cpu.GetRegister(Register::kPc),
            (kInstructionCount + 1) * sizeof(uint32_t));
}

}  // namespace toy_sim
