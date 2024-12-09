library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

-- Пакет, который содержит тип и функции для работы с ним
package my_vector_pkg is

    -- Определим тип my_vector как массив из std_logic_vector
    type my_vector is array (0 to 31) of std_logic_vector(31 downto 0);

    -- Функции для работы с типом

    -- Функция для создания нового вектора
    function create_vector(init_value: std_logic_vector) return my_vector;

end my_vector_pkg;

