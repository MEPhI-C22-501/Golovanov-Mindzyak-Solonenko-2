library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity load_store_unit is
	Port ( 
        i_clk, i_error, i_regWrite, o_r_type, o_i_type, o_s_type, o_u_type : in STD_LOGIC;
        i_opcode_decoder : in std_logic_vector (16 downto 0);
        i_rs1_decoder, i_rs2_decoder, i_rd_decoder, i_imm_decoder : in std_logic_vector (31 downto 0);
        i_rs1_csr, i_rs2_csr, i_rd_csr : in std_logic_vector (31 downto 0);

        o_opcode_csr, o_opcode_alu : out std_logic_vector (16 downto 0); 
        o_rs1_csr, o_rs2_csr, o_rd_csr, o_imm_csr : out std_logic_vector (31 downto 0);
        o_rs1_alu, o_rs2_alu, o_rd_alu, o_imm_alu : out std_logic_vector (31 downto 0));
end entity;

architecture load_store_unit_arch of load_store_unit is

signal cnt_clk : std_logic_vector (2 downto 0) := "000";
signal cnt_expected_clk : std_logic_vector (2 downto 0) := "000";

begin

        process(i_clk) is
	begin

                if (rising_edge(i_clk)) then

                        cnt_clk <= cnt_clk + 1;

                        --Надо перепроверить коды, я мог где-то что-то пропустить
                        if (i_opcode_decoder = "00000000000000011") then --Load LB

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then

                                end if;


                        elsif (i_opcode_decoder = "00000000010000011") then --Load LH

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then
                                        --Не понимаю что нужно делать дальше
                                end if;

                        elsif (i_opcode_decoder = "00000000100000011") then --Load LW

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then
                                        --Не понимаю что нужно делать дальше
                                end if;

                        elsif (i_opcode_decoder = "00000001000000011") then --Load LBU

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then
                                        --Не понимаю что нужно делать дальше
                                end if;

                        elsif (i_opcode_decoder = "00000001010000011") then --Load LHU

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then
                                        --Не понимаю что нужно делать дальше
                                end if;

                        elsif (i_opcode_decoder = "00000000000100011") then --Store SB

                                --Надо узнать как записывать в регистр

                        elsif (i_opcode_decoder = "00000000010100011") then --Store SH

                                --Надо узнать как записывать в регистр

                        elsif (i_opcode_decoder = "00000000100100011") then --Store SW

                                --Надо узнать как записывать в регистр

                        elsif (i_opcode_decoder = "00000000010010011") then --Shift SLLI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then

                                       o_opcode_alu <= i_opcode_decoder;
                                       o_rs1_alu <= i_rs1_csr;
                                       o_imm_alu <= i_imm_decoder;
                                       o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000001010010010") then --Shift SRLI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then

                                       o_opcode_alu <= i_opcode_decoder;
                                       o_rs1_alu <= i_rs1_csr;
                                       o_imm_alu <= i_imm_decoder;
                                       o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "01000001010010011") then --Shift SRAI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;
                                
                                if (cnt_expected_clk = cnt_clk) then

                                       o_opcode_alu <= i_opcode_decoder;
                                       o_rs1_alu <= i_rs1_csr;
                                       o_imm_alu <= i_imm_decoder;
                                       o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000000010110011") then --Shift SLL

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000001010110011") then --Shift SRL

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "01000001010110011") then --Shift SRA

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000000000010011") then --Arithmetic ADDI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000000000110011") then --Arithmetic ADD

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "01000000000110011") then --Arithmetic SUB

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000001000010011") then --Logical XORI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000001100010011") then --Logical ORI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000001110010011") then --Logical ANDI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000001000110011") then --Logical XOR

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000001100110011") then --Logical OR

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000001110110011") then --Logical AND

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000000100010011") then --Compare SLTI

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000000110010011") then --Compare SLTIU

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_imm_alu <= i_imm_decoder;
                                        o_rd_alu <= i_rd_csr;

                                end if; 

                        elsif (i_opcode_decoder = "00000000100110011") then --Compare SLT

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        elsif (i_opcode_decoder = "00000000110110011") then --Compare SLTU

                                o_opcode_csr <= i_opcode_decoder;
                                o_rs1_csr <= i_rs1_decoder;
                                o_rs2_csr <= i_rs2_decoder;
                                o_rd_csr <= i_rd_decoder;
                                cnt_expected_clk <= cnt_clk + 1;

                                if (cnt_expected_clk = cnt_clk) then

                                        o_opcode_alu <= i_opcode_decoder;
                                        o_rs1_alu <= i_rs1_csr;
                                        o_rs2_alu <= i_rs2_csr;
                                        o_rd_alu <= i_rd_csr;

                                end if;

                        end if;

                end if;

	end process; 

end architecture;