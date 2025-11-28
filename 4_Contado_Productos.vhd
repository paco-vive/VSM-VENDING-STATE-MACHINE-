library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Contador IS
    PORT (
        CLK         : in  std_logic;
        SW          : in  std_logic; 
        PRODUCTO    : out std_logic_vector(2 downto 0)
    );
END ENTITY;

ARCHITECTURE Behavioral OF Contador IS
    signal s_product_reg : std_logic_vector(2 downto 0) := "001";     
    signal s_sw_prev     : std_logic := '0';
BEGIN
    PRODUCTO <= s_product_reg;
    PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            -- estado anterior
            s_sw_prev <= SW;

            IF SW = '1' AND s_sw_prev = '0' THEN 
                
                IF unsigned(s_product_reg) < 5 THEN
                    s_product_reg <= std_logic_vector(unsigned(s_product_reg) + 1);
                ELSE
                    s_product_reg <= "001"; 
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;