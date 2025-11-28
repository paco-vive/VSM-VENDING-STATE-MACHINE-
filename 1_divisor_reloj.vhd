LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Clock_Divider IS
    PORT (
        CLK_100MHZ : IN  std_logic; 
        CLK_OUT    : OUT std_logic;
        LEDXD        : OUT std_logic   
    );
END ENTITY;

ARCHITECTURE Behavioral OF Clock_Divider IS
    CONSTANT C_DIV_VALUE : INTEGER := 50000000; 
    SIGNAL clk_count     : INTEGER RANGE 0 TO C_DIV_VALUE := 0;
    SIGNAL clk_internal  : std_logic := '0';

BEGIN

    PROCESS (CLK_100MHZ)
    BEGIN
        IF rising_edge(CLK_100MHZ) THEN
            IF clk_count = C_DIV_VALUE - 1 THEN
                clk_count <= 0;
                clk_internal <= NOT clk_internal; -- aterna el reloj
            ELSE
                clk_count <= clk_count + 1;
            END IF;
        END IF;
    END PROCESS;

    CLK_OUT <= clk_internal;
    LEDXD <= clk_internal;

END ARCHITECTURE;