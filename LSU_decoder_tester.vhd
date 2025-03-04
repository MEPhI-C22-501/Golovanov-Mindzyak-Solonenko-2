library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.register_file_pkg.all;

entity LSU_decoder_tester is 
    Port (

        signal i_LSU_tester_opcode_alu : in std_logic_vector (16 downto 0);
        signal i_LSU_tester_rs1_alu : in std_logic_vector (31 downto 0);
        signal i_LSU_tester_rs2_alu : in std_logic_vector (31 downto 0);
        signal i_LSU_tester_write_enable_csr  : in std_logic;
        signal i_LSU_tester_rd_csr : in std_logic_vector(4 downto 0);
        signal i_LSU_tester_addr_spec_reg_csr : in std_logic_vector (11 downto 0);
        signal i_rs_csr : in registers_array;

        signal o_rs_csr : out registers_array;
        signal o_tester_decoder_instr : out std_logic_vector(31 downto 0);
        signal o_clk : out std_logic;
        signal o_rst : out std_logic;
        signal o_tester_LSU_rd_ans : out std_logic_vector(31 downto 0);
        signal o_tester_LSU_program_counter_csr : out std_logic_vector (15 downto 0)

    );
end LSU_decoder_tester;

architecture LSU_decoder_tester_arch of LSU_decoder_tester is 

    constant clk_period : time := 10 ns;
    signal clk_s : std_logic := '0';
    signal counter_s : std_logic_vector (15 downto 0) := (others => '0');
    signal rst_s : std_logic := '0';

    procedure wait_clk(constant j: in integer) is 
        variable ii: integer := 0;
        begin
        while ii < j loop
            if (rising_edge(clk_s)) then
                ii := ii + 1;
            end if;
            wait for 10 ps;
        end loop;
    end;

    begin

	    o_clk <= clk_s;
        o_rst <= rst_s;
        o_tester_LSU_program_counter_csr <= counter_s;
        clk_s <= not clk_s after clk_period / 2;

        counter_s <= counter_s + 1 after clk_period;

        process
        begin

            wait_clk(1);
        
            rst_s <= '1';

            wait_clk(2);

            rst_s <= '0';

            o_tester_LSU_rd_ans <= std_logic_vector(to_unsigned(11, 32));
            o_tester_LSU_rd_ans(31 downto 20) <= (others => '1');  

            for i in 0 to 31 loop

                o_rs_csr(i) <= std_logic_vector(to_unsigned(i, 32));
                o_rs_csr(i)(25) <= '1';

            end loop;

            o_tester_decoder_instr <= "11000000111001111000010000000011";  -- LB
            report "LB";

            wait_clk(1);

            o_tester_decoder_instr <= "00001010001101000001001000000011";  -- LH
            report "LH";

            wait_clk(1);

            o_tester_decoder_instr <= "10101000010110001010100000000011";  -- LW MEMORY
            report "LW MEMORY";

            wait_clk(1);

            o_tester_decoder_instr <= "00000000000000001010100000000011";  -- LW CSR
            report "LW CSR";

            wait_clk(1);

            o_tester_decoder_instr <= "11100100000110010100000000000011";  -- LBU
            report "LBU";

            wait_clk(1);

            o_tester_decoder_instr <= "11000011101010100101000110000011";  -- LHU
            report "LHU";

            wait_clk(1);

            o_tester_decoder_instr <= "00011001100111011000011000100011";  -- SB
            report "SB";

            wait_clk(1);

            o_tester_decoder_instr <= "01010000110001110001100000100011";  -- SH
            report "SH";

            wait_clk(1);

            o_tester_decoder_instr <= "10111000011110001010110110100011";  -- SW
            report "SW";

            wait_clk(1);

            o_tester_decoder_instr <= "00000000110010111001000110010011";  -- SLLI
            report "SLLI";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001000001110101110110010011";  -- SRLI
            report "SRLI";

            wait_clk(1);

            o_tester_decoder_instr <= "01000001100000111101011110010011";  -- SRAI
            report "SRAI";

            wait_clk(1);

            o_tester_decoder_instr <= "00000000100110010001100000110011";  -- SLL
            report "SLL";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001000111001101011100110011";  -- SRL
            report "SRL";

            wait_clk(1);

            o_tester_decoder_instr <= "01000000101010010101101100110011";  -- SRA
            report "SRA";

            wait_clk(1);

            o_tester_decoder_instr <= "00000111011100111000101010010011";  -- ADDI
            report "ADDI";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001000111100000101110110011";  -- ADD
            report "ADD";

            wait_clk(1);

            o_tester_decoder_instr <= "01000000100000001000000110110011";  -- SUB
            report "SUB";

            wait_clk(1);

            o_tester_LSU_rd_ans <= std_logic_vector(to_unsigned(51, 32));
            o_tester_decoder_instr <= "00000010010100110000011000110011";  -- MUL
            report "MUL";

            wait_clk(1);

            o_tester_decoder_instr <= "00000010101000101001101000110011";  -- MULH
            report "MULH";

            wait_clk(1);

            o_tester_decoder_instr <= "00000011010011001010010110110011";  -- MULHSU 
            report "MULHSU";

            wait_clk(1);

            o_tester_decoder_instr <= "00000010010100110011011000110011";  -- MULHU
            report "MULHU";

            wait_clk(1);

            o_tester_decoder_instr <= "10101101010111111100100100010011";  -- XORI
            report "XORI";

            wait_clk(1);

            o_tester_decoder_instr <= "10111000100110011110101010010011";  -- ORI
            report "ORI";

            wait_clk(1);

            o_tester_decoder_instr <= "10100010010001000111011110010011";  -- ANDI
            report "ANDI";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001111101010100100110110011";  -- XOR
            report "XOR";

            wait_clk(1);

            o_tester_decoder_instr <= "00000000110111101110111000110011";  -- OR
            report "OR";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001111111101111010000110011";  -- AND
            report "AND";

            wait_clk(1);

            o_tester_decoder_instr <= "00000010001100010010000100010011";  -- SLTI
            report "SLTI";

            wait_clk(1);

            o_tester_decoder_instr <= "01010101111101110011111110010011";  -- SLTIU
            report "SLTIU";

            wait_clk(1);

            o_tester_decoder_instr <= "00000001100101001010000010110011";  -- SLT
            report "SLT";

            wait_clk(1);

            o_tester_decoder_instr <= "00000000000110100011100010110011";  -- SLTU
            report "SLTU";

            wait_clk(1);

            wait;
	
    end process;

end LSU_decoder_tester_arch;