library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use work.csr_array_pkg.all;

entity LSU is
	Port (
        
        i_clk, i_rst, i_write_enable_decoder : in std_logic;
        i_opcode_decoder, i_opcode_write_decoder : in std_logic_vector (16 downto 0);
        i_rs1_decoder, i_rs2_decoder, i_rd_decoder : in std_logic_vector (4 downto 0);
        i_rd_ans : in std_logic_vector (31 downto 0);
        i_addr_memory_decoder : in std_logic_vector (15 downto 0);
        i_imm_decoder : in std_logic_vector (11 downto 0);
        i_rs_csr : in csr_array;

        o_opcode_alu : out std_logic_vector (16 downto 0);
        o_rs_csr : out csr_array;
        o_rs1_alu, o_rs2_alu : out std_logic_vector (31 downto 0);
        o_write_enable_memory, o_write_enable_csr : out std_logic;
        o_addr_memory: out std_logic_vector (15 downto 0);
        o_write_data_memory: out std_logic_vector (31 downto 0);
        o_rd_csr : out std_logic_vector (4 downto 0));

end entity;

architecture LSU_arch of LSU is

signal register_to_save, register_to_load, register_to_prepare_imm : std_logic_vector (31 downto 0);

begin

        process(i_clk, i_rst) is
	begin

                if (i_rst = '1') then

                        o_opcode_alu <= std_logic_vector(to_unsigned(0, 17));

                elsif (rising_edge(i_clk)) then
                        
                        --передача кода операции в ALU
                        o_opcode_alu <= i_opcode_decoder;

                        --передача imm в ALU
                        if(i_opcode_decoder = "00000000010010011" or i_opcode_decoder = "00000001010010010" or i_opcode_decoder = "01000001010010011" or i_opcode_decoder = "00000000000010011" or i_opcode_decoder = "00000001000010011" or i_opcode_decoder = "00000001100010011" or i_opcode_decoder = "00000001110010011" or i_opcode_decoder = "00000000100010011" or i_opcode_decoder = "00000000110010011") then

                                register_to_prepare_imm <= std_logic_vector(to_unsigned(0, 32));

                                for n in 0 to 11 loop

                                        register_to_prepare_imm(n) <= i_imm_decoder(n);

                                end loop;

                                o_rs2_alu <= register_to_prepare_imm;
                        
                        end if;

                        --связь с LSUMEM
                        if (i_opcode_decoder = "00000000000100011") then -- Store SB
                                
                                o_write_enable_memory <= '1';
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000000010100011") then -- Store SH
                                
                                o_write_enable_memory <= '1';
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000000100100011") then -- Store SW
                                
                                o_write_enable_memory <= '1';
                                o_addr_memory <= i_addr_memory_decoder;

                        elsif (i_opcode_decoder = "00000000000000011") then --Load LB
                                
                                o_write_enable_memory <= '0';
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000000010000011") then --Load LH
                                        
                                o_write_enable_memory <= '0';
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000000100000011") then --Load LW  
                                        
                                o_write_enable_memory <= '0';
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000001000000011") then --Load LBU 
                                        
                                o_write_enable_memory <= '0';  
                                o_addr_memory <= i_addr_memory_decoder;
                                        
                        elsif (i_opcode_decoder = "00000001010000011") then --Load LHU 
                                        
                                o_write_enable_memory <= '0';
                                o_addr_memory <= i_addr_memory_decoder;

                        else          

                                o_write_enable_memory <= '0';
                                o_addr_memory <= std_logic_vector(to_unsigned(0, 16));

                        end if;

                        --реализация 32 регистров
                        for i in 0 to 31 loop


                                if (i_write_enable_decoder = '1' and i_opcode_decoder = "00000000000000011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Load LB
                                                
                                        --7 младших битов, все остальное знаковым битом (32)
                                        for n in 0 to 7 loop

                                                register_to_save(n) <= i_rd_ans(n);

                                        end loop;

                                        for n in 8 to 31 loop

                                                register_to_save(n) <= i_rd_ans(31);

                                        end loop;

                                        o_rs_csr(i) <= register_to_save;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                elsif (i_write_enable_decoder = '1' and i_opcode_decoder = "00000000010000011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Load LH
                                                
                                        --15 младших битов, все остальное знаковым битом (32)
                                        for n in 0 to 14 loop

                                                register_to_save(n) <= i_rd_ans(n);

                                        end loop;

                                        for n in 15 to 31 loop

                                                register_to_save(n) <= i_rd_ans(31);

                                        end loop;

                                        o_rs_csr(i) <= register_to_save;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                elsif (i_write_enable_decoder = '1' and i_opcode_decoder = "00000000100000011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Load LW  
                                        
                                        o_rs_csr(i) <= i_rd_ans;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                elsif (i_write_enable_decoder = '1' and i_opcode_decoder = "00000001000000011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Load LBU 
                                        
                                        o_rs_csr(i) <= i_rd_ans;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                elsif (i_write_enable_decoder = '1' and i_opcode_decoder = "00000001010000011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Load LHU 
                                                
                                        o_rs_csr(i) <= i_rd_ans;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                elsif (i_write_enable_decoder = '1' and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then --Save answer
                                                
                                        o_rs_csr(i) <= i_rd_ans;
                                        o_write_enable_csr <= '1';
                                        o_rd_csr <= i_rd_decoder;
                                        
                                else 
                                        
                                        o_write_enable_csr <= '0';
                                        o_rd_csr <= std_logic_vector(to_unsigned(0, 5));
                                        
                                end if;






                                --связь с LSUMEM Store
                                if (i_opcode_decoder = "00000000000100011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then -- Store SB
                                                
                                        --7 младших битов, все остальное знаковым битом (32)
                                        for n in 0 to 7 loop

                                                register_to_load(n) <= i_rs_csr(i)(n);

                                        end loop;

                                        for n in 8 to 31 loop

                                                register_to_load(n) <= i_rs_csr(i)(31);

                                        end loop;
                                                
                                        o_write_data_memory <= register_to_load;
                                        
                                elsif (i_opcode_decoder = "00000000010100011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then -- Store SH
                                                
                                        --15 младших битов, все остальное знаковым битом (32)
                                        for n in 0 to 14 loop

                                                register_to_load(n) <= i_rs_csr(i)(n);

                                        end loop;

                                        for n in 15 to 31 loop

                                                register_to_load(n) <= i_rs_csr(i)(31);

                                        end loop;
                                                
                                        o_write_data_memory <= register_to_load;
                                        
                                elsif (i_opcode_decoder = "00000000100100011" and i_rd_decoder = std_logic_vector(to_unsigned(i, 5))) then -- Store SW
                                                
                                        o_write_data_memory <= i_rs_csr(i);

                                else
                                        
                                        o_write_data_memory <= std_logic_vector(to_unsigned(0, 32));

                                end if;









                                if (i_rs1_decoder = std_logic_vector(to_unsigned(i, 5))) then
                                        
                                        o_rs1_alu <= i_rs_csr(i);
                                        
                                elsif ((i_rs2_decoder = std_logic_vector(to_unsigned(i, 5)) and (i_opcode_decoder = "00000000010110011" or i_opcode_decoder = "00000001010110011" or i_opcode_decoder = "01000001010110011" or i_opcode_decoder = "00000000000110011" or i_opcode_decoder = "01000000000110011" or i_opcode_decoder = "00000001000110011" or i_opcode_decoder = "00000001100110011" or i_opcode_decoder = "00000001110110011" or i_opcode_decoder = "00000000100110011" or i_opcode_decoder = "00000000110110011"))) then
                                        
                                        o_rs2_alu <= i_rs_csr(i);
                                        
                                end if;

                        end loop;

                end if;

        end process;

end architecture;