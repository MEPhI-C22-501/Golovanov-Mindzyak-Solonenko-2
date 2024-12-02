library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LSU_tester is 
    Port ( 
        o_clk, o_error, o_regWrite, o_r_type, o_i_type, o_s_type, o_u_type : out STD_LOGIC;
        o_opcode_decoder : out std_logic_vector (16 downto 0);
        o_rs1_decoder, o_rs2_decoder, o_rd_decoder, o_imm_decoder : out std_logic_vector (31 downto 0);
        o_rs1_csr, o_rs2_csr, o_rd_csr : out std_logic_vector (31 downto 0);

        i_opcode_csr, i_opcode_alu : in std_logic_vector (16 downto 0); 
        i_rs1_csr, i_rs2_csr, i_rd_csr : in std_logic_vector (31 downto 0);
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
