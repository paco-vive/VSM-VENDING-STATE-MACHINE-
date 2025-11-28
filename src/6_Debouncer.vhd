library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debouncer is
    port (
        CLK         : in  std_logic;
        BOTON       : in  std_logic;
        BOTON_CLN   : out std_logic  
    );
end entity Debouncer;

architecture Behavioral of Debouncer is
    constant COUNTER_LIMIT : natural := 1000000;
    
    signal counter         : integer range 0 to COUNTER_LIMIT := 0;
    signal btn_estado_reg  : std_logic := '0';  

begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if BOTON /= btn_estado_reg then
                if counter < COUNTER_LIMIT then
                    counter <= counter + 1;
                else
                    btn_estado_reg <= BOTON;
                    counter <= 0; 
                end if;
            else
                counter <= 0;
            end if;
        end if;
    end process;
    BOTON_CLN <= btn_estado_reg;

end architecture Behavioral;