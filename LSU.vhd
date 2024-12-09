library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use work.my_vector_pkg.all;

entity LSU is
	Port (
        
        --i_r_type, i_i_type, i_s_type, i_u_type, i_error под вопросом, по идее можно выбросить        
        
        i_clk, i_regWrite_decoder, i_regWrite_ans : in std_logic;
        i_opcode_decoder : in std_logic_vector (16 downto 0);
        i_rs1_decoder, i_rs2_decoder, i_rd_decoder : in std_logic_vector (5 downto 0);
        i_imm_decoder, i_rd_ans : in std_logic_vector (31 downto 0);
        i_rs_csr : in my_vector;

        o_regWrite_alu  : out std_logic;
        o_opcode_alu : out std_logic_vector (16 downto 0);
        o_rs_csr : out my_vector;
        o_rs1_alu, o_rs2_alu, o_rd_alu, o_imm_alu : out std_logic_vector (31 downto 0));

end entity;

architecture LSU_arch of LSU is
begin

        process(i_clk) is
	begin

                if (rising_edge(i_clk)) then
                        
                        o_opcode_alu <= i_opcode_decoder;
                        o_regWrite_alu <= i_regWrite_decoder;
                        o_imm_alu <= i_imm_decoder;

                end if;

        end process;

        -- Генерация процесса для всех 32 регистров
        gen_registers : for i in 0 to 31 generate
                
                process(i_clk)
                begin
                
                        if rising_edge(i_clk) then
                                
                                if (i_regWrite_ans = '1' and i_rd_decoder = std_logic_vector(to_unsigned(i, 6))) then
                                        
                                        o_rs_csr(i) <= i_rd_ans;
                                
                                end if;

                                if (i_opcode_decoder = "00000000000100011") then -- Store SB
                                
                                        o_rs_csr(i) <= i_imm_decoder;
                                
                                elsif (i_opcode_decoder = "00000000010100011") then -- Store SH
                                
                                        o_rs_csr(i) <= i_imm_decoder;
                                
                                elsif (i_opcode_decoder = "00000000100100011") then -- Store SW
                                
                                        o_rs_csr(i) <= i_imm_decoder;
                                
                                end if;

                                --Здесь должны быть команды загрузки 

                                if (i_rs1_decoder = std_logic_vector(to_unsigned(i, 6))) then
                                
                                        o_rs1_alu <= i_rs_csr(i);
                                
                                elsif (i_rs2_decoder = std_logic_vector(to_unsigned(i, 6))) then
                                
                                        o_rs2_alu <= i_rs_csr(i);
                                
                                end if;

                        end if;
                
                end process;

        end generate gen_registers;

end architecture;