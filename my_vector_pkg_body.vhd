library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package body my_vector_pkg is

    -- Реализация функции для создания нового вектора
    function create_vector(init_value: std_logic_vector) return my_vector is
    
        variable new_vector : my_vector;
    
    begin

        -- Инициализация каждого элемента вектора одинаковым значением
        for i in 0 to 31 loop
        
            new_vector(i) := init_value;
        
        end loop;
        
        return new_vector;
    
    end function;

end package body my_vector_pkg;

