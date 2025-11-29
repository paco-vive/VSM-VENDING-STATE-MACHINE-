library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL; 

entity TB_TOP is end entity; 

architecture tb of TB_TOP is component VendingMachine_TOP_FINAL is 
    Port ( 
        SW_confirm      : in  STD_LOGIC; 
        CLK             : in  STD_LOGIC; 
        RST_BTN         : in  STD_LOGIC;                                                  SW_PROD         : in  STD_LOGIC;                                                  BTN_CONFIRM     : in  STD_LOGIC;                                                  BTN_MONEDAS     : in  STD_LOGIC_VECTOR (3 downto 0); 
        SEG             : out STD_LOGIC_VECTOR(6 downto 0);   
        AN              : out STD_LOGIC_VECTOR(3 downto 0); 
        LED_OUT         : out STD_LOGIC; 
        LEDXD           : out std_logic 
    ); 
end component; 
 
--señales internas de la tarjeta 
signal CLK_tb         : std_logic := '0'; 
signal RST_tb         : std_logic := '0'; 
signal SW_PROD_tb     : std_logic := '0'; 
signal BTN_CONFIRM_tb : std_logic := '0'; 
signal BTN_MONEDAS_tb : std_logic_vector(3 downto 0) := (others => '0'); 
signal SW_confirm_tb  : std_logic := '0'; 
 
signal SEG_tb         : std_logic_vector(6 downto 0); 
signal AN_tb          : std_logic_vector(3 downto 0); 
signal LED_OUT_tb     : std_logic; 
signal LEDXD_tb       : std_logic; 
 
 
-- filtra todo lo menor a 10ms. 
 
procedure pulse_button(signal S : out std_logic) is 
begin 
    S <= '1'; 
    wait for 40 ms;  
    S <= '0'; 
    wait for 40 ms;  
end procedure; 
  

begin 

--  UUT 
UUT: VendingMachine_TOP_FINAL 
port map( 
    SW_confirm  => SW_confirm_tb, 
    CLK         => CLK_tb, 
    RST_BTN     => RST_tb, 
    SW_PROD     => SW_PROD_tb, 
    BTN_CONFIRM => BTN_CONFIRM_tb, 
    BTN_MONEDAS => BTN_MONEDAS_tb, 
    SEG         => SEG_tb, 
    AN          => AN_tb, 
    LED_OUT     => LED_OUT_tb, 
    LEDXD       => LEDXD_tb 
); 
 
-- Reloj de 100 MHz (Periodo 10ns) 
clk_process : process 
begin 
    CLK_tb <= '0'; 
    wait for 5 ns; 
    CLK_tb <= '1'; 
    wait for 5 ns; 
end process; 
 
 
stim_proc : process 
begin 
     
     
    RST_tb <= '0'; 
    SW_confirm_tb <= '0'; 
    BTN_MONEDAS_tb <= (others => '0'); 
     
    wait for 100 ns;  
 
    -- reset 
     
    RST_tb <= '1'; 
    wait for 500 ns;  
    RST_tb <= '0'; 
    wait for 500 ns; 
 
    
    -- Producto 1, Moneda de 10 + 10 
    
                           
    -- Selecciona producto  
    pulse_button(SW_PROD_tb);  
     
    -- Confirma producto 
    pulse_button(BTN_CONFIRM_tb); 
     
     
    -- Inserta $10 (Bit 3) 
    pulse_button(BTN_MONEDAS_tb(3)); 
     
    -- Inserta $10  = Total $20 
    pulse_button(BTN_MONEDAS_tb(3)); 
 
    --  ver el saldo en el display 
    wait for 500 ns;  
 
     
    -- Activar Switch de compra 
    SW_confirm_tb <= '1'; 
    wait for 100 ms;  
    SW_confirm_tb <= '0'; 
 
    wait for 10 ms;  
 
    
end process; 
  

end architecture; 
