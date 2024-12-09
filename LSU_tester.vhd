library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.my_vector_pkg.all;

entity LSU_tester is 
    Port ( 
        o_clk, o_regWrite_decoder, o_regWrite_ans : out std_logic;
        o_opcode_decoder : out std_logic_vector (16 downto 0);
        o_rs1_decoder, o_rs2_decoder, o_rd_decoder : out std_logic_vector (5 downto 0);
        o_imm_decoder, o_rd_ans : out std_logic_vector (31 downto 0);
        o_rs_csr : out my_vector;

        i_regWrite_alu  : in std_logic;
        i_opcode_alu : in std_logic_vector (16 downto 0);
        i_rs_csr : in my_vector;
        i_rs1_alu, i_rs2_alu, i_rd_alu, i_imm_alu : in std_logic_vector (31 downto 0));
end entity;




architecture LSU_tester_arch of LSU_tester is

    signal clk_sig : STD_LOGIC := '1';

    constant clockPeriod : time := 1 sec;
    signal clk : std_logic := '0';

    begin
        
        clk <= not clk after clockPeriod / 10;
        o_clk <= clk;
	
	process 
	begin
		

        
	end process;
		
end architecture;
