library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.my_vector_pkg.all;

entity LSU_tb is
end entity;

architecture LSU_tb_arch of LSU_tb is

    signal clk, regWrite_decoder, regWrite_ans, regWrite_alu : std_logic;
    signal opcode_decoder, opcode_alu : std_logic_vector (16 downto 0);
    signal rs1_decoder, rs2_decoder, rd_decoder : std_logic_vector (5 downto 0);
    signal imm_decoder, rd_ans, rs1_alu, rs2_alu, rd_alu, imm_alu : std_logic_vector (31 downto 0);
    signal i_rs_csr_tb, o_rs_csr_tb : my_vector; --вот тут не очень понятно

    begin

        LSU_tester : entity work.LSU_tester(LSU_tester_arch) port map(
            o_clk => clk,
            o_regWrite_decoder => regWrite_decoder,
            o_opcode_decoder => opcode_decoder,
            o_rs1_decoder => rs1_decoder,
            o_rs2_decoder => rs2_decoder,
            o_rd_decoder => rd_decoder,
            o_imm_decoder => imm_decoder,
            o_rd_ans => rd_ans,
            o_rs_csr => o_rs_csr_tb,

            i_regWrite_alu => regWrite_alu,
            i_opcode_alu => opcode_alu,
            i_rs_csr => i_rs_csr_tb,
            i_rs1_alu => rs1_alu, 
            i_rs2_alu => rs2_alu,
            i_rd_alu => rd_alu,
            i_imm_alu => imm_alu
        );

        LSU : entity work.LSU(LSU_arch) port map(
            i_clk => clk, 
            i_regWrite_decoder => regWrite_decoder, 
            i_regWrite_ans => regWrite_ans,
            i_opcode_decoder => opcode_decoder,
            i_rs1_decoder => rs1_decoder, 
            i_rs2_decoder => rs2_decoder, 
            i_rd_decoder => rd_decoder,
            i_imm_decoder => imm_decoder, 
            i_rd_ans => rd_ans,
            i_rs_csr => i_rs_csr_tb,

            o_regWrite_alu => regWrite_alu,
            o_opcode_alu => opcode_alu,
            o_rs_csr => o_rs_csr_tb,
            o_rs1_alu => rs1_alu, 
            o_rs2_alu => rs2_alu, 
            o_rd_alu => rd_alu, 
            o_imm_alu => imm_alu
        );

end architecture;
