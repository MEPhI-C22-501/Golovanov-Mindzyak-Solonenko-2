library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.register_file_pkg.all;

entity LSU_decoder_tb is
end LSU_decoder_tb;

architecture LSU_decoder_tb_arch of LSU_decoder_tb is

    signal clk_s : std_logic := '0';
   	signal rst_s : std_logic := '0';
	
    signal tester_decoder_instr : std_logic_vector(31 downto 0);
    
    signal decoder_LSU_write_enable : std_logic;
    signal decoder_LSU_reg_or_memory_flag : std_logic;
    signal decoder_LSU_rs1 : std_logic_vector(4 downto 0);
    signal decoder_LSU_rs2 : std_logic_vector(4 downto 0);
    signal decoder_LSU_rd : std_logic_vector(4 downto 0);
    signal decoder_LSU_imm : std_logic_vector(11 downto 0);
    signal decoder_LSU_opcode : std_logic_vector (16 downto 0);
    signal decoder_LSU_opcode_write :std_logic_vector (16 downto 0);

    signal tester_LSU_rs_csr : registers_array;
    signal LSU_tester_rs_csr : registers_array;

    signal LSU_LSUMEM_write_enable_memory : std_logic;
    signal LSU_LSUMEM_addr_memory : std_logic_vector (15 downto 0);
    signal LSU_LSUMEM_write_data_memory : std_logic_vector (31 downto 0);

    signal LSU_tester_opcode_alu : std_logic_vector (16 downto 0);
    signal LSU_tester_rs1_alu : std_logic_vector (31 downto 0);
    signal LSU_tester_rs2_alu : std_logic_vector (31 downto 0);
    signal LSU_tester_write_enable_csr  : std_logic;
    signal LSU_tester_rd_csr : std_logic_vector(4 downto 0);
    signal LSU_tester_addr_spec_reg_csr : std_logic_vector (11 downto 0);

    --signal LSUMEM_tester_ : ;
    
    signal tester_LSU_rd_ans : std_logic_vector(31 downto 0);
    signal tester_LSU_program_counter_csr : std_logic_vector (15 downto 0);

    begin

        LSU_decoder_tester : entity work.LSU_decoder_tester(LSU_decoder_tester_arch) port map(

        i_LSU_tester_opcode_alu => LSU_tester_opcode_alu,
        i_LSU_tester_rs1_alu => LSU_tester_rs1_alu,
        i_LSU_tester_rs2_alu => LSU_tester_rs2_alu,
        i_LSU_tester_write_enable_csr => LSU_tester_write_enable_csr,
        i_LSU_tester_rd_csr => LSU_tester_rd_csr,
        i_LSU_tester_addr_spec_reg_csr => LSU_tester_addr_spec_reg_csr,
        i_rs_csr => LSU_tester_rs_csr,

        o_rs_csr => tester_LSU_rs_csr,
        o_tester_decoder_instr => tester_decoder_instr,
        o_clk => clk_s,
        o_rst => rst_s,
        o_tester_LSU_rd_ans => tester_LSU_rd_ans,
        o_tester_LSU_program_counter_csr => tester_LSU_program_counter_csr

        );

        command_decoder_v1 : entity work.command_decoder_v1(rtl) port map (

            i_clk => clk_s,
            i_rst => rst_s,
            i_instr => tester_decoder_instr,
                
            o_rs1 => decoder_LSU_rs1,
            o_rs2 => decoder_LSU_rs2,
            o_imm => decoder_LSU_imm,
            o_rd => decoder_LSU_rd,
            o_write_to_LSU => decoder_LSU_write_enable,
            o_LSU_code => decoder_LSU_opcode,
            o_LSU_code_post	=> decoder_LSU_opcode_write,
            o_LSU_reg_or_memory_flag => decoder_LSU_reg_or_memory_flag
            --o_wb_result_src => 

        );

        LSU : entity work.LSU(LSU_arch) port map (

            i_clk => clk_s,
            i_rst => rst_s,
            i_rs_csr => tester_LSU_rs_csr,
            i_write_enable_decoder => decoder_LSU_write_enable,
            i_opcode_decoder => decoder_LSU_opcode,
            i_opcode_write_decoder => decoder_LSU_opcode_write,
            i_rs1_decoder => decoder_LSU_rs1,
            i_rs2_decoder => decoder_LSU_rs2,
            i_rd_decoder  => decoder_LSU_rd,
            i_rd_ans => tester_LSU_rd_ans,
            i_imm_decoder => decoder_LSU_imm,
            i_spec_reg_or_memory_decoder => decoder_LSU_reg_or_memory_flag,
            i_program_counter_csr => tester_LSU_program_counter_csr,

            o_opcode_alu => LSU_tester_opcode_alu,
            o_rs_csr => LSU_tester_rs_csr,
            o_rs1_alu => LSU_tester_rs1_alu, 
            o_rs2_alu => LSU_tester_rs2_alu, 
            o_write_enable_memory => LSU_LSUMEM_write_enable_memory, 
            o_write_enable_csr => LSU_tester_write_enable_csr,
            o_addr_memory => LSU_LSUMEM_addr_memory,
            o_write_data_memory => LSU_LSUMEM_write_data_memory,
            o_rd_csr => LSU_tester_rd_csr,
            o_addr_spec_reg_csr => LSU_tester_addr_spec_reg_csr
            --o_program_counter 
            --o_program_counter_write_enable 

        );

        LSUMEM : entity work.LSUMEM(LSUMEM_arch) port map (

            i_clk => clk_s,
            i_rst => rst_s,
            i_write_enable_LSU => LSU_LSUMEM_write_enable_memory,
            i_addr_LSU => LSU_LSUMEM_addr_memory,
            i_write_data_LSU => LSU_LSUMEM_write_data_memory

            --o_write_enable_memory => ,
            --o_addr_memory => ,
            --o_write_data_memory => 
            
        );

end LSU_decoder_tb_arch;