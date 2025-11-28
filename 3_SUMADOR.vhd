LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 

ENTITY CoinCounter_Top IS
    PORT (
        CLK_DIV      : IN  std_logic; 
        RESET        : IN  std_logic; 
        RESETFIN     : IN  std_logic; 
        ENABLE       : IN  std_logic; 
        
        MONEDA_1     : IN  std_logic; 
        MONEDA_2     : IN  std_logic;
        MONEDA_5     : IN  std_logic;
        MONEDA_10    : IN  std_logic;
        
        COUNT_OUT    : OUT std_logic_vector(4 downto 0)  -- 0 a 31
    );
END ENTITY;

ARCHITECTURE Behavioral OF CoinCounter_Top IS

    -- contador único de 5 bits (0..31)
    SIGNAL Total_Counter : unsigned(4 downto 0) := (others => '0');

BEGIN

    PROCESS(CLK_DIV)
        -- variables (persisten entre llamadas al proceso)
        VARIABLE prev_M1  : std_logic := '0';
        VARIABLE prev_M2  : std_logic := '0';
        VARIABLE prev_M5  : std_logic := '0';
        VARIABLE prev_M10 : std_logic := '0';

        VARIABLE Valor_Moneda   : integer := 0;
        VARIABLE Sum_extended  : unsigned(5 downto 0); -- ancho extra para sumar sin recorte
    BEGIN
        IF rising_edge(CLK_DIV) THEN

            -- reset síncrono
            IF RESET = '1' THEN
                Total_Counter <= (others => '0');
                
            ELSIF RESETFIN = '1' THEN
                Total_Counter <= (others => '0');
               

            ELSIF ENABLE = '1' THEN

                -- detectar flanco ascendente usando variables prev (estado del ciclo anterior)
                Valor_Moneda := 0;
                IF (MONEDA_1 = '1' AND prev_M1 = '0') THEN
                    Valor_Moneda := 1;
                ELSIF (MONEDA_2 = '1' AND prev_M2 = '0') THEN
                    Valor_Moneda := 2;
                ELSIF (MONEDA_5 = '1' AND prev_M5 = '0') THEN
                    Valor_Moneda := 5;
                ELSIF (MONEDA_10 = '1' AND prev_M10 = '0') THEN
                    Valor_Moneda := 10;
                END IF;

                -- si detectamos moneda, sumar con ancho extra y comprobar overflow
                IF Valor_Moneda > 0 THEN
                    -- ampliar Total_Counter a 6 bits y sumar
                    Sum_extended := ("0" & Total_Counter) + to_unsigned(Valor_Moneda, 6);

                    -- si el resultado es mayor a 31 -> reiniciar a 0
                    IF Sum_extended > to_unsigned(31, 6) THEN
                        Total_Counter <= (others => '0');
                    ELSE
                        Total_Counter <= Sum_extended(4 downto 0); -- bajar a 5 bits
                    END IF;
                END IF;

            END IF;

            -- actualizar prev para la siguiente iteración (al final del flanco)
            prev_M1  := MONEDA_1;
            prev_M2  := MONEDA_2;
            prev_M5  := MONEDA_5;
            prev_M10 := MONEDA_10;

        END IF;
    END PROCESS;

    -- salida binaria 0..31
    COUNT_OUT <= std_logic_vector(Total_Counter);

END ARCHITECTURE;
