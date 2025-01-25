library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use work.register_file_pkg.all;

entity LSU_tb is
end entity;

architecture LSU_tb_arch of LSU_tb is

    signal clk, rst : std_logic;
    signal connection_LSU_LSUMEM_write_enable : std_logic;
    signal connection_LSU_LSUMEM_addr_memory : ;
    signal connection_LSU_LSUMEM_write_data_memory : ;
    signal connection_decoder_LSU_rs1 : std_logic_vector (4 downto 0);
    signal connection_decoder_LSU_rs2 : std_logic_vector (4 downto 0);
    signal connection_decoder_LSU_imm : std_logic_vector (11 downto 0);
    signal connection_decoder_LSU_rd : std_logic_vector (4 downto 0);
    signal connection_decoder_LSU_opcode : std_logic_vector (16 downto 0);
    signal connection_decoder_LSU_opcode_write : std_logic_vector (16 downto 0);
    signal connection_decoder_LSU_write_enable : std_logic;

    begin

        --LSU_tester : entity work.LSU_tester(LSU_tester_arch) port map(

        --    o_clk => clk,
        --    o_rst => rst,
        --    o_write_enable_decoder => write_enable_tester_LSU,
        --    o_opcode_decoder => opcode_decoder,
        --    o_rs1_decoder => rs1_decoder,
        --    o_rs2_decoder => rs2_decoder,
        --    o_rd_decoder => rd_decoder,
        --    o_imm_decoder => imm_decoder,
        --    o_rd_ans => rd_ans,
        --    o_rs_csr => o_rs_csr_tb,
        --    o_opcode_write_decoder => opcode_write,
        --    o_addr_memory_decoder  => addr_tester_LSU,

        --    i_opcode_alu => opcode_alu,
        --    i_rs_csr => i_rs_csr_tb,
        --    i_rs1_alu => rs1_alu, 
        --    i_rs2_alu => rs2_alu,
        --    i_write_enable_memory => write_enable_memory_tester,
        --    i_addr_memory => addr_memory_tester,
        --    i_write_data_memory => write_data_memor_tester

        );

        command_decoder_v1 : entity work.command_decoder_v1(rtl) port map(

            i_clk => clk,
            i_rst => rst,        	
            i_instr => , --тут должна быть связь с тестером
            o_rs1 => connection_decoder_LSU_rs1, 
            o_rs2 => connection_decoder_LSU_rs2, 
            o_rd => connection_decoder_LSU_rd, 
            o_imm => connection_decoder_LSU_imm, 
            o_write_to_LSU => connection_decoder_LSU_write_enable, 
            o_LSU_code => connection_decoder_LSU_opcode,
            o_LSU_code_post => connection_decoder_LSU_opcode_write

        );

        LSU : entity work.LSU(LSU_arch) port map(

            i_clk => clk, 
            i_rst => rst, 
            i_write_enable_decoder => connection_decoder_LSU_write_enable, 
            i_opcode_decoder => connection_decoder_LSU_opcode,
            i_opcode_write_decoder => connection_decoder_LSU_opcode_write,
            i_rs1_decoder => connection_decoder_LSU_rs1, 
            i_rs2_decoder => connection_decoder_LSU_rs2, 
            i_rd_decoder => connection_decoder_LSU_rd,
            i_imm_decoder => connection_decoder_LSU_imm, 
            i_rd_ans => , --тут должна быть связь с тестером
            i_rs_csr => o_rs_csr_tb, --тут надо их крестом соединить с i_rs_csr_tb в тестере

            o_opcode_alu => , --тут должна быть связь с тестером
            o_rs_csr => i_rs_csr_tb, --тут надо их крестом соединить с o_rs_csr_tb в тестере
            o_rs1_alu => , --тут должна быть связь с тестером
            o_rs2_alu => , --тут должна быть связь с тестером
            o_write_enable_memory => connection_LSU_LSUMEM_write_enable,
            o_addr_memory => connection_LSU_LSUMEM_addr_memory, 
            o_write_data_memory => connection_LSU_LSUMEM_write_data_memory

        );

        LSUMEM : entity work.LSUMEM(LSUMEM_arch) port map(
            
            i_clk => clk, 
            i_rst => rst, 
            i_write_enable_LSU => connection_LSU_LSUMEM_write_enable, 
            i_addr_LSU => connection_LSU_LSUMEM_addr_memory, 
            i_write_data_LSU => connection_LSU_LSUMEM_write_data_memory, 

            o_write_enable_memory => , --тут должна быть связь с тестером
            o_addr_memory => , --тут должна быть связь с тестером
            o_write_data_memory => --тут должна быть связь с тестером

        );

end architecture;
