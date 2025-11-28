LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Seven_Segment_Mux IS
    PORT (
        -- entradas
        CLK_100MHZ  : IN  std_logic;              
        DATA_IN     : IN  std_logic_vector(4 downto 0); -- CONTEO_FINAL 
        
        -- Salidas 
        SEG         : OUT std_logic_vector(6 downto 0); -- 7 Segmentos 
        AN          : OUT std_logic_vector(3 downto 0)  -- 4 Anodos 
    );
END ENTITY;

ARCHITECTURE Behavioral OF Seven_Segment_Mux IS
    
    -- frecuencia de multiplexación 
    CONSTANT MUX_DIV_VALUE : INTEGER := 100000;
    SIGNAL mux_count     : INTEGER RANGE 0 TO MUX_DIV_VALUE := 0;
    SIGNAL mux_clk       : std_logic := '0';
    
    SIGNAL digit_select  : std_logic := '0'; 

    SIGNAL bcd_unit      : std_logic_vector(3 downto 0); 
    SIGNAL bcd_ten       : std_logic_vector(3 downto 0); 


    FUNCTION Dec_to_Seg(bcd_in : std_logic_vector(3 downto 0)) 
        RETURN std_logic_vector IS
    BEGIN
        -- Los bits son: a b c d e f g
        CASE bcd_in IS
            WHEN "0000" => RETURN "0000001"; -- 0
            WHEN "0001" => RETURN "1001111"; -- 1 
            WHEN "0010" => RETURN "0010010"; -- 2
            WHEN "0011" => RETURN "0000110"; -- 3
            WHEN "0100" => RETURN "1001100"; -- 4 
            WHEN "0101" => RETURN "0100100"; -- 5
            WHEN "0110" => RETURN "0100000"; -- 6
            WHEN "0111" => RETURN "0001111"; -- 7
            WHEN "1000" => RETURN "0000000"; -- 8
            WHEN "1001" => RETURN "0001100"; -- 9
            WHEN OTHERS => RETURN "1111111"; -- apagao
        END CASE;
    END FUNCTION;

BEGIN
    
    -- separar decenas y unidades 
    bcd_unit <= std_logic_vector(to_unsigned(to_integer(unsigned(DATA_IN)) MOD 10, 4));
    bcd_ten  <= std_logic_vector(to_unsigned(to_integer(unsigned(DATA_IN)) / 10, 4));

    PROCESS (CLK_100MHZ)
    BEGIN
        IF rising_edge(CLK_100MHZ) THEN
            IF mux_count = MUX_DIV_VALUE - 1 THEN
                mux_count <= 0;
                mux_clk <= NOT mux_clk;
                digit_select <= NOT digit_select;
            ELSE
                mux_count <= mux_count + 1;
            END IF;
        END IF;
    END PROCESS;
    
    --  digito y decodificacion
    PROCESS (digit_select, bcd_unit, bcd_ten)
    BEGIN
        CASE digit_select IS 
            WHEN '0' => 
                AN <= "1110"; 
                SEG <= Dec_to_Seg(bcd_unit);
            --decenas
            WHEN '1' => 
                AN <= "1101"; 
                
                IF to_integer(unsigned(bcd_ten)) = 0 THEN
                     SEG <= "1111111"; 
                ELSE
                     SEG <= Dec_to_Seg(bcd_ten);
                END IF;
            
            WHEN OTHERS =>
                AN <= "1111";
                SEG <= "1111111"; 
        END CASE;
    END PROCESS;

END ARCHITECTURE;