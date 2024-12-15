library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use work.my_vector_pkg.all;

entity LSU_tester is 
    Port ( 
        o_clk, o_rst, o_regWrite_decoder : out std_logic;
        o_opcode_decoder : out std_logic_vector (16 downto 0);
        o_rs1_decoder, o_rs2_decoder, o_rd_decoder : out std_logic_vector (4 downto 0);
        o_imm_decoder, o_rd_ans : out std_logic_vector (31 downto 0);
        o_rs_csr : out my_vector;

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

    gen_registers : for i in 0 to 31 generate

        o_rs_csr(i) <= i_rs_csr(i);

    end generate gen_registers;

	process 
	begin
		
        o_rst <= '1';
        wait for 0.2 sec;
        o_rst <= '0';

        --Load LB 00000000000000011
        o_opcode_decoder <= "00000000000000011";

        --Load LH 00000000010000011
        o_opcode_decoder <= "00000000010000011";

        --Load LW 00000000100000011  
         o_opcode_decoder <= "00000000100000011";

        --Load LBU 00000001000000011
        o_opcode_decoder <= "00000001000000011";

        --Load LHU 00000001010000011
        o_opcode_decoder <= "00000001010000011";

        --Store SB 00000000000100011
        --o_opcode_decoder <= "00000000000100011";
        --o_rd_decoder <= std_logic_vector(to_unsigned(0, 5));
        --o_imm_decoder <= std_logic_vector(to_unsigned(1, 32));
        --wait for 0.3 sec;

        --Store SH 00000000010100011
        --o_opcode_decoder <= "00000000010100011";
        --o_rd_decoder <= std_logic_vector(to_unsigned(1, 5));
        --o_imm_decoder <= std_logic_vector(to_unsigned(2, 32));
        --wait for 0.3 sec;

        --Store SW 00000000100100011
        --o_opcode_decoder <= "00000000100100011";
        --o_rd_decoder <= std_logic_vector(to_unsigned(2, 5));
        --o_imm_decoder <= std_logic_vector(to_unsigned(3, 32));
        --wait for 0.3 sec;


        --Arithmetic ADDI 00000000000010011
        o_opcode_decoder <= "00000000000010011";
        o_regWrite_decoder <= '1';
        o_rs1_decoder <= std_logic_vector(to_unsigned(1, 5)); 
        o_rd_decoder <= std_logic_vector(to_unsigned(2, 5));
        o_imm_decoder <= std_logic_vector(to_unsigned(5, 32));
        o_rd_ans <= std_logic_vector(to_unsigned(5, 32));
        wait for 0.3 sec;

        --Arithmetic ADD 00000000000110011
        o_opcode_decoder <= "00000000000110011";
        o_regWrite_decoder <= '1';
        o_rs1_decoder <= std_logic_vector(to_unsigned(1, 5));
        o_rs2_decoder <= std_logic_vector(to_unsigned(2, 5)); 
        o_rd_decoder <= std_logic_vector(to_unsigned(3, 5));
        o_rd_ans <= std_logic_vector(to_unsigned(5, 32));
        wait for 0.3 sec;

        --Arithmetic SUB 01000000000110011
        o_opcode_decoder <= "01000000000110011";
        o_regWrite_decoder <= '1';
        o_rs1_decoder <= std_logic_vector(to_unsigned(3, 5));
        o_rs2_decoder <= std_logic_vector(to_unsigned(4, 5)); 
        o_rd_decoder <= std_logic_vector(to_unsigned(5, 5));
        o_rd_ans <= std_logic_vector(to_unsigned(5, 32));
        wait for 0.3 sec;

        --Logical XORI 00000001000010011
        o_opcode_decoder <= "00000001000010011";

        --Logical ORI 00000001100010011
        o_opcode_decoder <= "00000001100010011";

        --Logical ANDI 00000001110010011
        o_opcode_decoder <= "00000001110010011";

        --Logical XOR 00000001000110011
        o_opcode_decoder <= "00000001000110011";

        --Logical OR 00000001100110011
        o_opcode_decoder <= "00000001100110011";

        --Logical AND 00000001110110011
        o_opcode_decoder <= "00000001110110011";

        --Compare SLTI 00000000100010011
        o_opcode_decoder <= "00000000100010011";

        --Compare SLTIU 00000000110010011
        o_opcode_decoder <= "00000000110010011";

        --Compare SLT 00000000100110011
        o_opcode_decoder <= "00000000100110011";

        --Compare SLTU 00000000110110011
        o_opcode_decoder <= "00000000110110011";

        --Shift SLLI 00000000010010011
        o_opcode_decoder <= "00000000010010011";

        --Shift SRLI 00000001010010010
        o_opcode_decoder <= "00000001010010010";

        --Shift SRAI 01000001010010011
        o_opcode_decoder <= "01000001010010011";

        --Shift SLL 00000000010110011
        o_opcode_decoder <= "00000000010110011";

        --Shift SRL 00000001010110011
        o_opcode_decoder <= "00000001010110011";

        --Shift SRA 01000001010110011
        o_opcode_decoder <= "01000001010110011";
        
        wait;
	end process;
		
end architecture;
