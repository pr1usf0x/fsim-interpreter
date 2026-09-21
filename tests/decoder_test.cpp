#include "cpu.hpp"
#include "encoding.hpp"
#include "microasm.hpp"

#include <gtest/gtest.h>

namespace toy_sim {

class FuckedDecoderTest : public testing::Test {
 protected:
  static void Test(Instruction decoder_output, Instruction ref) {
    EXPECT_EQ(decoder_output.type_, ref.type_);
    EXPECT_EQ(decoder_output.r1_, ref.r1_);
    EXPECT_EQ(decoder_output.r2_, ref.r2_);
    EXPECT_EQ(decoder_output.r3_, ref.r3_);
    EXPECT_EQ(decoder_output.imm_, ref.imm_);
  }
};

TEST_F(FuckedDecoderTest, LdTest1) {
  Instruction ref = {.type_ = CommandType::kLd,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenLdInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdTest2) {
  Instruction ref = {.type_ = CommandType::kLd,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 1337};
  Instruction out = Cpu::Decode(GenLdInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdTest3) {
  Instruction ref = {.type_ = CommandType::kLd,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenLdInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdTest4) {
  Instruction ref = {.type_ = CommandType::kLd,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 67};
  Instruction out = Cpu::Decode(GenLdInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddTest1) {
  Instruction ref = {.type_ = CommandType::kAdd,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX23,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenAddInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddTest2) {
  Instruction ref = {.type_ = CommandType::kAdd,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX30,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenAddInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddTest3) {
  Instruction ref = {.type_ = CommandType::kAdd,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX16,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenAddInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddTest4) {
  Instruction ref = {.type_ = CommandType::kAdd,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX20,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenAddInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BeqTest1) {
  Instruction ref = {.type_ = CommandType::kBeq,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenBeqInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BeqTest2) {
  Instruction ref = {.type_ = CommandType::kBeq,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 0xFFFF};
  Instruction out = Cpu::Decode(GenBeqInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BeqTest3) {
  Instruction ref = {.type_ = CommandType::kBeq,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 6767};
  Instruction out = Cpu::Decode(GenBeqInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BeqTest4) {
  Instruction ref = {.type_ = CommandType::kBeq,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenBeqInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LiTest1) {
  Instruction ref = {.type_ = CommandType::kLi,
                     .r1_ = Register::kX19,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenLiInstr(ref.r1_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LiTest2) {
  Instruction ref = {.type_ = CommandType::kLi,
                     .r1_ = Register::kX3,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0xFFFF};
  Instruction out = Cpu::Decode(GenLiInstr(ref.r1_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LiTest3) {
  Instruction ref = {.type_ = CommandType::kLi,
                     .r1_ = Register::kX23,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 6767};
  Instruction out = Cpu::Decode(GenLiInstr(ref.r1_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LiTest4) {
  Instruction ref = {.type_ = CommandType::kLi,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenLiInstr(ref.r1_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StTest1) {
  Instruction ref = {.type_ = CommandType::kSt,
                     .r1_ = Register::kX19,
                     .r2_ = Register::kX23,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenStInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StTest2) {
  Instruction ref = {.type_ = CommandType::kSt,
                     .r1_ = Register::kX3,
                     .r2_ = Register::kX23,
                     .r3_ = Register::kX0,
                     .imm_ = 0x1FFF};
  Instruction out = Cpu::Decode(GenStInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StTest3) {
  Instruction ref = {.type_ = CommandType::kSt,
                     .r1_ = Register::kX23,
                     .r2_ = Register::kX1,
                     .r3_ = Register::kX0,
                     .imm_ = 6767};
  Instruction out = Cpu::Decode(GenStInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StTest4) {
  Instruction ref = {.type_ = CommandType::kSt,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenStInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StpTest1) {
  Instruction ref = {.type_ = CommandType::kStp,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX23,
                     .imm_ = 666};
  Instruction out =
      Cpu::Decode(GenStpInstr(ref.r1_, ref.r2_, ref.r3_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StpTest2) {
  Instruction ref = {.type_ = CommandType::kStp,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX30,
                     .imm_ = 0x7FF};
  Instruction out =
      Cpu::Decode(GenStpInstr(ref.r1_, ref.r2_, ref.r3_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StpTest3) {
  Instruction ref = {.type_ = CommandType::kStp,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX16,
                     .imm_ = 0x400};
  Instruction out =
      Cpu::Decode(GenStpInstr(ref.r1_, ref.r2_, ref.r3_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, StpTest4) {
  Instruction ref = {.type_ = CommandType::kStp,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out =
      Cpu::Decode(GenStpInstr(ref.r1_, ref.r2_, ref.r3_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddiTest1) {
  Instruction ref = {.type_ = CommandType::kAddi,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenAddiInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddiTest2) {
  Instruction ref = {.type_ = CommandType::kAddi,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 0xFFFF};
  Instruction out = Cpu::Decode(GenAddiInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddiTest3) {
  Instruction ref = {.type_ = CommandType::kAddi,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 0x8000};
  Instruction out = Cpu::Decode(GenAddiInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, AddiTest4) {
  Instruction ref = {.type_ = CommandType::kAddi,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenAddiInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, JTest1) {
  Instruction ref = {.type_ = CommandType::kJ,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenJInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, JTest2) {
  Instruction ref = {.type_ = CommandType::kJ,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0x676767};
  Instruction out = Cpu::Decode(GenJInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, JTest3) {
  Instruction ref = {.type_ = CommandType::kJ,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0x2000000};
  Instruction out = Cpu::Decode(GenJInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, JTest4) {
  Instruction ref = {.type_ = CommandType::kJ,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenJInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdPostTest1) {
  Instruction ref = {.type_ = CommandType::kLdPost,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenLdPostInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdPostTest2) {
  Instruction ref = {.type_ = CommandType::kLdPost,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 0x3FFF};
  Instruction out = Cpu::Decode(GenLdPostInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdPostTest3) {
  Instruction ref = {.type_ = CommandType::kLdPost,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 0x2000};
  Instruction out = Cpu::Decode(GenLdPostInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, LdPostTest4) {
  Instruction ref = {.type_ = CommandType::kLdPost,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 67};
  Instruction out = Cpu::Decode(GenLdPostInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, NorTest1) {
  Instruction ref = {.type_ = CommandType::kNor,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX23,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenNorInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, NorTest2) {
  Instruction ref = {.type_ = CommandType::kNor,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX30,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenNorInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, NorTest3) {
  Instruction ref = {.type_ = CommandType::kNor,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX16,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenNorInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, NorTest4) {
  Instruction ref = {.type_ = CommandType::kNor,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenNorInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SsatTest1) {
  Instruction ref = {.type_ = CommandType::kSsat,
                     .r1_ = Register::kX19,
                     .r2_ = Register::kX23,
                     .r3_ = Register::kX0,
                     .imm_ = 6};
  Instruction out = Cpu::Decode(GenSsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SsatTest2) {
  Instruction ref = {.type_ = CommandType::kSsat,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 31};
  Instruction out = Cpu::Decode(GenSsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SsatTest3) {
  Instruction ref = {.type_ = CommandType::kSsat,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 16};
  Instruction out = Cpu::Decode(GenSsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SsatTest4) {
  Instruction ref = {.type_ = CommandType::kSsat,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenSsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, RbitTest1) {
  Instruction ref = {.type_ = CommandType::kRbit,
                     .r1_ = Register::kX19,
                     .r2_ = Register::kX23,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenRbitInstr(ref.r1_, ref.r2_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, RbitTest2) {
  Instruction ref = {.type_ = CommandType::kRbit,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenRbitInstr(ref.r1_, ref.r2_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, RbitTest3) {
  Instruction ref = {.type_ = CommandType::kRbit,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenRbitInstr(ref.r1_, ref.r2_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, RbitTest4) {
  Instruction ref = {.type_ = CommandType::kRbit,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenRbitInstr(ref.r1_, ref.r2_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SyscallTest1) {
  Instruction ref = {.type_ = CommandType::kSyscall,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 666};
  Instruction out = Cpu::Decode(GenSyscallInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SyscallTest2) {
  Instruction ref = {.type_ = CommandType::kSyscall,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 1488};
  Instruction out = Cpu::Decode(GenSyscallInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SyscallTest3) {
  Instruction ref = {.type_ = CommandType::kSyscall,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0x80000};
  Instruction out = Cpu::Decode(GenSyscallInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, SyscallTest4) {
  Instruction ref = {.type_ = CommandType::kSyscall,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX0,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenSyscallInstr(ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BextTest1) {
  Instruction ref = {.type_ = CommandType::kBext,
                     .r1_ = Register::kX1,
                     .r2_ = Register::kX18,
                     .r3_ = Register::kX23,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenBextInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BextTest2) {
  Instruction ref = {.type_ = CommandType::kBext,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX30,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenBextInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BextTest3) {
  Instruction ref = {.type_ = CommandType::kBext,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX16,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenBextInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, BextTest4) {
  Instruction ref = {.type_ = CommandType::kBext,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenBextInstr(ref.r1_, ref.r2_, ref.r3_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, UsatTest1) {
  Instruction ref = {.type_ = CommandType::kUsat,
                     .r1_ = Register::kX19,
                     .r2_ = Register::kX23,
                     .r3_ = Register::kX0,
                     .imm_ = 6};
  Instruction out = Cpu::Decode(GenUsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, UsatTest2) {
  Instruction ref = {.type_ = CommandType::kUsat,
                     .r1_ = Register::kX31,
                     .r2_ = Register::kX4,
                     .r3_ = Register::kX0,
                     .imm_ = 31};
  Instruction out = Cpu::Decode(GenUsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, UsatTest3) {
  Instruction ref = {.type_ = CommandType::kUsat,
                     .r1_ = Register::kX21,
                     .r2_ = Register::kX9,
                     .r3_ = Register::kX0,
                     .imm_ = 16};
  Instruction out = Cpu::Decode(GenUsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

TEST_F(FuckedDecoderTest, UsatTest4) {
  Instruction ref = {.type_ = CommandType::kUsat,
                     .r1_ = Register::kX0,
                     .r2_ = Register::kX31,
                     .r3_ = Register::kX0,
                     .imm_ = 0};
  Instruction out = Cpu::Decode(GenUsatInstr(ref.r1_, ref.r2_, ref.imm_));
  Test(out, ref);
};

}  // namespace toy_sim