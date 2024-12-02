library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LSU_tb is
end entity;

architecture LSU_tb_arch of LSU_tb is

    signal clk, error, regWrite, r_type, i_type, s_type, u_type : STD_LOGIC;
    signal opcode_decoder, opcode_csr, opcode_alu : std_logic_vector (16 downto 0);
    signal rs1_decoder, rs2_decoder, rd_decoder, imm_decoder : std_logic_vector (31 downto 0);
    signal rs1_csr, rs2_csr, rd_csr, rs1_alu, rs2_alu, rd_alu, imm_alu : std_logic_vector (31 downto 0);

    begin

        LSU_tester : entity work.LSU_tester(LSU_tester_arch) port map(
            o_clk => clk,
            o_error => error,
            o_regWrite => regWrite,
            o_r_type => r_type,
            o_i_type => i_type,
            o_s_type => s_type,
            o_u_type => u_type,
            o_opcode_decoder => opcode_decoder,
            o_rs1_decoder => rs1_decoder,
            o_rs2_decoder => rs2_decoder,
            o_rd_decoder => rd_decoder,
            o_imm_decoder => imm_decoder,
            o_rs1_csr => rs1_csr,
            o_rs2_csr => rs2_csr,
            o_rd_csr => rd_csr,

            i_opcode_csr => opcode_csr,
            i_opcode_alu => opcode_alu,
            i_rs1_csr => rs1_csr,
            i_rs2_csr => rs2_csr,
            i_rd_csr => rd_csr,
            i_rs1_alu => rs1_alu,
            i_rs2_alu => rs2_alu,
            i_rd_alu => rd_alu,
            i_imm_alu => imm_alu
        );

        LSU : entity work.LSU(LSU_arch) port map(
            i_clk => clk,
            i_error => error,
            i_regWrite => regWrite,
            i_r_type => r_type,
            i_i_type => i_type,
            i_s_type => s_type,
            i_u_type => u_type,
            i_opcode_decoder => opcode_decoder,
            i_rs1_decoder => rs1_decoder,
            i_rs2_decoder => rs2_decoder,
            i_rd_decoder => rd_decoder,
            i_imm_decoder => imm_decoder,
            i_rs1_csr => rs1_csr,
            i_rs2_csr => rs2_csr,
            i_rd_csr => rd_csr,

            o_opcode_csr => opcode_csr,
            o_opcode_alu => opcode_alu,
            o_rs1_csr => rs1_csr,
            o_rs2_csr => rs2_csr,
            o_rd_csr => rd_csr,
            o_rs1_alu => rs1_alu,
            o_rs2_alu => rs2_alu,
            o_rd_alu => rd_alu,
            o_imm_alu => imm_alu
        );

end architecture;
