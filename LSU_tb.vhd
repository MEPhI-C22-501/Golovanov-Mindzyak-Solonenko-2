library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use work.csr_array_pkg.all;

entity LSU_tb is
end entity;

architecture LSU_tb_arch of LSU_tb is

    signal clk, rst, write_enable_tester_LSU, write_enable_LSU_memory, write_enable_memory_tester : std_logic;
    signal opcode_decoder, opcode_alu, opcode_write : std_logic_vector (16 downto 0);
    signal rs1_decoder, rs2_decoder, rd_decoder : std_logic_vector (4 downto 0);
    signal rd_ans, rs1_alu, rs2_alu, write_data_LSU_memory, write_data_memor_tester : std_logic_vector (31 downto 0);
    signal i_rs_csr_tb, o_rs_csr_tb : csr_array;
    signal addr_tester_LSU, addr_LSU_memory, addr_memory_tester : std_logic_vector (15 downto 0);
    signal imm_decoder : std_logic_vector (11 downto 0);

    begin

        LSU_tester : entity work.LSU_tester(LSU_tester_arch) port map(
            o_clk => clk,
            o_rst => rst,
            o_write_enable_decoder => write_enable_tester_LSU,
            o_opcode_decoder => opcode_decoder,
            o_rs1_decoder => rs1_decoder,
            o_rs2_decoder => rs2_decoder,
            o_rd_decoder => rd_decoder,
            o_imm_decoder => imm_decoder,
            o_rd_ans => rd_ans,
            o_rs_csr => o_rs_csr_tb,
            o_opcode_write_decoder => opcode_write,
            o_addr_memory_decoder  => addr_tester_LSU,

            i_opcode_alu => opcode_alu,
            i_rs_csr => i_rs_csr_tb,
            i_rs1_alu => rs1_alu, 
            i_rs2_alu => rs2_alu,
            i_write_enable_memory => write_enable_memory_tester,
            i_addr_memory => addr_memory_tester,
            i_write_data_memory => write_data_memor_tester
        );

        LSU : entity work.LSU(LSU_arch) port map(
            i_clk => clk, 
            i_rst => rst, 
            i_write_enable_decoder => write_enable_tester_LSU, 
            i_opcode_decoder => opcode_decoder,
            i_rs1_decoder => rs1_decoder, 
            i_rs2_decoder => rs2_decoder, 
            i_rd_decoder => rd_decoder,
            i_imm_decoder => imm_decoder, 
            i_rd_ans => rd_ans,
            i_rs_csr => o_rs_csr_tb,
            i_addr_memory_decoder => addr_tester_LSU,
            i_opcode_write_decoder => opcode_write,

            o_opcode_alu => opcode_alu,
            o_rs_csr => i_rs_csr_tb,
            o_rs1_alu => rs1_alu, 
            o_rs2_alu => rs2_alu,
            o_write_enable_memory => write_enable_LSU_memory,
            o_addr_memory => addr_LSU_memory,
            o_write_data_memory => write_data_LSU_memory
        );

        LSUMEM : entity work.LSUMEM(LSUMEM_arch) port map(
            
            i_clk => clk, 
            i_rst => rst, 
            i_write_enable_LSU => write_enable_LSU_memory, 
            i_addr_LSU => addr_LSU_memory, 
            i_write_data_LSU => write_data_LSU_memory, 

            o_write_enable_memory => write_enable_memory_tester, 
            o_addr_memory => addr_memory_tester,
            o_write_data_memory => write_data_memor_tester

        );

end architecture;
