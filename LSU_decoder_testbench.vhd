library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.register_file_pkg.all;


entity LSU_decoder_testbench is
end LSU_decoder_testbench;

architecture LSU_decoder_testbench_arch of LSU_decoder_testbench is

    component command_decoder_v1 is
        port(
             i_clk : in std_logic;
             i_rst : in std_logic;
             i_instr : in std_logic_vector(31 downto 0);

             o_rs1 : out std_logic_vector(4 downto 0);
             o_rs2 : out std_logic_vector(4 downto 0);
             o_imm : out std_logic_vector(11 downto 0);
             o_rd : out std_logic_vector(4 downto 0);
             o_write_to_LSU : out std_logic;
             o_LSU_code : out std_logic_vector(16 downto 0);
             o_LSU_code_post : out std_logic_vector(16 downto 0);
             o_LSU_reg_or_memory_flag : out std_logic;
             o_wb_result_src : out  STD_LOGIC_VECTOR(1 downto 0)
        );
   end component;

	component LSU is
	Port (
        i_clk, i_rst, i_write_enable_decoder : in std_logic;
        i_opcode_decoder, i_opcode_write_decoder : in std_logic_vector (16 downto 0);
        i_rs1_decoder, i_rs2_decoder, i_rd_decoder : in std_logic_vector (4 downto 0);
        i_rd_ans : in std_logic_vector (31 downto 0);
        i_imm_decoder : in std_logic_vector (11 downto 0);
        i_rs_csr : in registers_array;
        i_spec_reg_or_memory_decoder : in std_logic;
        i_program_counter_csr : in std_logic_vector (15 downto 0);

        o_opcode_alu : out std_logic_vector (16 downto 0);
        o_rs_csr : out registers_array;
        o_rs1_alu, o_rs2_alu : out std_logic_vector (31 downto 0);
        o_write_enable_memory, o_write_enable_csr : out std_logic;
        o_addr_memory: out std_logic_vector (15 downto 0);
        o_write_data_memory: out std_logic_vector (31 downto 0);
        o_rd_csr : out std_logic_vector (4 downto 0);
        o_addr_spec_reg_csr : out std_logic_vector (11 downto 0);
		o_program_counter : out std_logic_vector(15 downto 0);
		o_program_counter_write_enable : out std_logic
	);
	end component;

	component LSUMEM is
		Port (
        		i_clk, i_rst, i_write_enable_LSU : in std_logic;
        		i_addr_LSU : in std_logic_vector (15 downto 0);
        		i_write_data_LSU : in std_logic_vector (31 downto 0);

        		o_write_enable_memory: out std_logic;
        		o_addr_memory: out std_logic_vector (15 downto 0);
        		o_write_data_memory: out std_logic_vector (31 downto 0)
		);
	end component;


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

    signal entry_rs_csr : registers_array;
    signal given_rs_csr : registers_array;

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

    constant clk_period : time := 10 ns;

begin         
	
	clk_s <= not clk_s after clk_period / 2;

    decoder_t: command_decoder_v1
    port map (
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

	LSU_t: LSU
	port map (
		i_clk => clk_s,
		i_rst => rst_s,
		i_rs_csr => entry_rs_csr,
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
        o_rs_csr => given_rs_csr,
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

	LSUMEM_t: LSUMEM
	port map (
		i_clk => clk_s,
		i_rst => rst_s,
		i_write_enable_LSU => LSU_LSUMEM_write_enable_memory,
        i_addr_LSU => LSU_LSUMEM_addr_memory,
        i_write_data_LSU => LSU_LSUMEM_write_data_memory

        --o_write_enable_memory => ,
        --o_addr_memory => ,
        --o_write_data_memory => 
	);

	process
	begin
		
        wait for clk_period / 2;
	 
        rst_s <= '1';

        wait for clk_period;

        rst_s <= '0';

        tester_LSU_rd_ans <= std_logic_vector(to_unsigned(11, 32));
        tester_LSU_rd_ans(31 downto 20) <= (others => '1');  

        for i in 0 to 31 loop

            entry_rs_csr(i) <= std_logic_vector(to_unsigned(i, 32));
            entry_rs_csr(i)(25) <= '1';

        end loop;

        tester_decoder_instr <= "11000000111001111000010000000011";  -- LB
        report "LB";

        wait for clk_period;

        tester_decoder_instr <= "00001010001101000001001000000011";  -- LH
        report "LH";

        wait for clk_period;

        tester_decoder_instr <= "10101000010110001010100000000011";  -- LW MEMORY
        report "LW MEMORY";

        wait for clk_period;

        tester_decoder_instr <= "00000000000000001010100000000011";  -- LW CSR
        report "LW CSR";

        wait for clk_period;

        tester_decoder_instr <= "11100100000110010100000000000011";  -- LBU
        report "LBU";

        wait for clk_period;

        tester_decoder_instr <= "11000011101010100101000110000011";  -- LHU
        report "LHU";

        wait for clk_period;

        tester_decoder_instr <= "00011001100111011000011000100011";  -- SB
        report "SB";

        wait for clk_period;

        tester_decoder_instr <= "01010000110001110001100000100011";  -- SH
        report "SH";

        wait for clk_period;

        tester_decoder_instr <= "10111000011110001010110110100011";  -- SW
        report "SW";

        wait for clk_period;

        tester_decoder_instr <= "00000000110010111001000110010011";  -- SLLI
        report "SLLI";

        wait for clk_period;

        tester_decoder_instr <= "00000001000001110101110110010011";  -- SRLI
        report "SRLI";

        wait for clk_period;

        tester_decoder_instr <= "01000001100000111101011110010011";  -- SRAI
        report "SRAI";

        wait for clk_period;

        tester_decoder_instr <= "00000000100110010001100000110011";  -- SLL
        report "SLL";

        wait for clk_period;

        tester_decoder_instr <= "00000001000111001101011100110011";  -- SRL
        report "SRL";

        wait for clk_period;

        tester_decoder_instr <= "01000000101010010101101100110011";  -- SRA
        report "SRA";

        wait for clk_period;

        tester_decoder_instr <= "00000111011100111000101010010011";  -- ADDI
        report "ADDI";

        wait for clk_period;

        tester_decoder_instr <= "00000001000111100000101110110011";  -- ADD
        report "ADD";

        wait for clk_period;

        tester_decoder_instr <= "01000000100000001000000110110011";  -- SUB
        report "SUB";

        wait for clk_period;

        tester_decoder_instr <= "00000010010100110000011000110011";  -- MUL
        report "MUL";

        wait for clk_period;

        tester_decoder_instr <= "00000010101000101001101000110011";  -- MULH
        report "MULH";

        wait for clk_period;

        tester_decoder_instr <= "00000011010011001010010110110011";  -- MULHSU 
        report "MULHSU";

        wait for clk_period;

        tester_decoder_instr <= "00000010010100110011011000110011";  -- MULHU
        report "MULHU";

        wait for clk_period;

        tester_decoder_instr <= "10101101010111111100100100010011";  -- XORI
        report "XORI";

        wait for clk_period;

        tester_decoder_instr <= "10111000100110011110101010010011";  -- ORI
        report "ORI";

        wait for clk_period;

        tester_decoder_instr <= "10100010010001000111011110010011";  -- ANDI
        report "ANDI";

        wait for clk_period;

        tester_decoder_instr <= "00000001111101010100100110110011";  -- XOR
        report "XOR";

        wait for clk_period;

        tester_decoder_instr <= "00000000110111101110111000110011";  -- OR
        report "OR";

        wait for clk_period;

        tester_decoder_instr <= "00000001111111101111010000110011";  -- AND
        report "AND";

        wait for clk_period;

        tester_decoder_instr <= "00000010001100010010000100010011";  -- SLTI
        report "SLTI";

        wait for clk_period;

        tester_decoder_instr <= "01010101111101110011111110010011";  -- SLTIU
        report "SLTIU";

        wait for clk_period;

        tester_decoder_instr <= "00000001100101001010000010110011";  -- SLT
        report "SLT";

        wait for clk_period;

        tester_decoder_instr <= "00000000000110100011100010110011";  -- SLTU
        report "SLTU";

        wait for clk_period;

		wait;
	end process;
end LSU_decoder_testbench_arch;

