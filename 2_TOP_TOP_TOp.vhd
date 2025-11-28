library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity VendingMachine_TOP_FINAL is
    Port (
        
        --################### ENTITY ###########################
        SW_confirm : in  STD_LOGIC; 

        CLK         : in  STD_LOGIC;
        
        RST_BTN     : in  STD_LOGIC;                                    
        SW_PROD     : in  STD_LOGIC;                                    
        BTN_CONFIRM : in  STD_LOGIC;                                   
        BTN_MONEDAS : in  STD_LOGIC_VECTOR (3 downto 0);                
        
        SEG         : out STD_LOGIC_VECTOR(6 downto 0);                 
        AN          : out STD_LOGIC_VECTOR(3 downto 0);                 
        LED_OUT     : out STD_LOGIC;  
        LEDXD        : OUT std_logic;    
        

        
        led : out STD_LOGIC_VECTOR(13 downto 0)                                 
    );
end entity VendingMachine_TOP_FINAL;


--=============================================================================================================================================--

architecture Behavioral of VendingMachine_TOP_FINAL is

--################### Debouncer  ###########################
    component Debouncer is
        port ( 
        CLK : in std_logic; 
        BOTON : in std_logic; 
        BOTON_CLN : out std_logic );
    end component;
--################### Contador de Productos  ###########################
    component Contador is 
        port ( 
        CLK : in std_logic; 
        SW : in std_logic; 
        PRODUCTO : out std_logic_vector(2 downto 0) );
    end component;
--################### Contador de Monedas ###########################
    component CoinCounter_Top is 
        Port (
        CLK_DIV : IN  std_logic; 
        RESET : IN  std_logic; 
        RESETFIN     : IN  std_logic; 
        ENABLE : IN std_logic; 
        MONEDA_1 : IN  std_logic; 
        MONEDA_2 : IN  std_logic; 
        MONEDA_5 : IN  std_logic; 
        MONEDA_10 : IN  std_logic; 
        COUNT_OUT : OUT std_logic_vector(4 downto 0));
    end component;
--################### eelll sevensegment ###########################
    component Seven_Segment_Mux is 
        Port (
        CLK_100MHZ : IN  std_logic; 
        DATA_IN : IN  std_logic_vector(4 downto 0); 
        SEG : OUT std_logic_vector(6 downto 0); 
        AN : OUT std_logic_vector(3 downto 0));
    end component;
--################### Un divisor de reloj ###########################
    component Clock_Divider is
        PORT (
        CLK_100MHZ : IN  std_logic; 
        CLK_OUT : OUT std_logic;
        LEDXD        : OUT std_logic );
    end component;

--=============================================================================================================================================--
--################### señales limpias: Producto, Confirmación, Reset, Confirmación Limpio DOBLE ###########################
    signal sw_prod_cln      : std_logic;
    signal btn_confirm_cln  : std_logic;
    signal rst_btn_cln      : std_logic;
    signal s_confirm_pulse  : std_logic := '0';
    signal s_btn_confirm_prev : std_logic := '0';

--################### señales : clk lento, pulso para elegir productos, el enable para el contador de monedas, reset no físico1  ###########################
    signal s_clk_lento      : std_logic;
    signal s_prod_count_pulse : std_logic; 
    signal s_count_enable   : std_logic := '0';
    signal s_counter_reset  : std_logic := '0';
    
--################### señales : id, precio, saldo, cambio ###########################
    signal s_producto_id    : std_logic_vector(2 downto 0); 
    signal s_precio_total   : std_logic_vector(4 downto 0); 
    signal s_saldo_actual   : std_logic_vector(4 downto 0); 
    signal resta_xd   : std_logic_vector(4 downto 0); 
    
--################### señales : entrega delay , entrega delay BOOLEAN, RESET no físico 2  ###########################

    signal entrega_counter : unsigned(27 downto 0) := (others => '0');
    signal entrega_done    : std_logic := '0';
    signal s_RESETFIN  : std_logic := '0';
    
--################### señales : el 7segemetn, ###########################
    
    signal s_display_data   : std_logic_vector(4 downto 0) := (others => '0');
    
   --################### señales : PARA EL SNAKE ###########################
 
      
    signal clk_slow : STD_LOGIC := '0';
    signal counter  : unsigned(25 downto 0) := (others => '0');
    signal pos      : integer range 0 to 13 := 0;

    constant ONE : unsigned(13 downto 0) := to_unsigned(1, 14);
    constant TAIL_LENGTH : integer := 4;
    signal prender_snake    : std_logic := '0';
    
 --=============================================================================================================================================--

--################### LOS ESTADOS y presente y futuro, ###########################

    type State_Type is (S_SELECT_PROD, S_SHOW_PRICE, S_CONTAR_SALDO, S_ENTREGA);
    signal current_state, next_state : State_Type := S_SELECT_PROD;
    
--=============================================================================================================================================--
    
    
begin
   
    s_prod_count_pulse <= sw_prod_cln when current_state = S_SELECT_PROD else '0'; --Sirve para no navegar entre precios cuando se muestren , se mapea a el producto clean y se activa solo cuando sea la selección de productos 

--################### LOS DEBOUNCERS (2 son extra xd ) ###########################

    DB_SW: Debouncer port map (CLK => CLK, BOTON => SW_PROD, BOTON_CLN => sw_prod_cln);
    DB_SEL: Debouncer port map (CLK => CLK, BOTON => BTN_CONFIRM, BOTON_CLN => btn_confirm_cln);
    DB_RST: Debouncer port map (CLK => CLK, BOTON => RST_BTN, BOTON_CLN => rst_btn_cln);
 
 --################### LOS MAPEOS ###########################

    
    U0_CLK_DIV : Clock_Divider PORT MAP (CLK_100MHZ => CLK, CLK_OUT => s_clk_lento, LEDXD => LEDXD);
    
    U1_CNT_PROD: Contador port map (CLK => CLK, SW => s_prod_count_pulse, PRODUCTO => s_producto_id);

    U2_COIN_CNT : CoinCounter_Top
    PORT MAP (
        CLK_DIV   => s_clk_lento, 
        RESET     => s_counter_reset or rst_btn_cln,
        RESETFIN => s_RESETFIN ,  
        ENABLE    => s_count_enable,
        MONEDA_1  => BTN_MONEDAS(0),
        MONEDA_2  => BTN_MONEDAS(1),
        MONEDA_5  => BTN_MONEDAS(2),
        MONEDA_10 => BTN_MONEDAS(3),
        COUNT_OUT => s_saldo_actual
    );
    

    U3_SS_MUX : Seven_Segment_Mux
    PORT MAP (
        CLK_100MHZ => CLK,
        DATA_IN    => s_display_data,
        SEG        => SEG,
        AN         => AN
    );
--=============================================================================================================================================--

    
    
 --=============================================================================================================================================--

--################### LOS PROCESOS###########################

    process(CLK) -- limpiar dos veces el de confirmación 
    begin
        if rising_edge(CLK) then
            s_btn_confirm_prev <= btn_confirm_cln;
            s_confirm_pulse <= '0';
            if btn_confirm_cln = '1' and s_btn_confirm_prev = '0' then
                s_confirm_pulse <= '1';
            end if;
        end if;
    end process;
    
    
    
    process(CLK) -- RESET FISICO 
    begin
        if rising_edge(CLK) then
            if rst_btn_cln = '1' then
                current_state <= S_SELECT_PROD;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;
    
    
    process(CLK) -- delay de entrega 
    begin
        if rising_edge(CLK) then
            if current_state = S_ENTREGA then
                if entrega_counter < 200_000_000 then
                    entrega_counter <= entrega_counter + 1;
                    entrega_done <= '0';
                else
                    entrega_done <= '1';
                end if;
            else
                entrega_counter <= (others => '0');
                entrega_done <= '0';
            end if;
        end if;
    end process;

    
    
    process(CLK) -- clock de  la SNAKE 
    begin
        if rising_edge(CLK) then
            counter <= counter + 1;
            if counter = 5_000_000 then
                clk_slow <= not clk_slow;
                counter <= (others => '0');
            end if;
        end if;
    end process;

    process(s_producto_id) -- se muestra el precio total en el display 
    begin
        case s_producto_id is
            when "001" => s_precio_total <= "10011"; -- $19
            when "010" => s_precio_total <= "01010"; -- $10
            when "011" => s_precio_total <= "00111"; -- $7
            when "100" => s_precio_total <= "10101"; -- $21
            when "101" => s_precio_total <= "00110"; -- $5
            when others => s_precio_total <= "00000";
        end case;
    end process;
    
    
    process(clk_slow, prender_snake) -- EL SNAKE cara 
    begin
        if prender_snake = '0' then
            pos <= 0;

        elsif rising_edge(clk_slow) then
            if pos = 13 then
                pos <= 0;
            else
                pos <= pos + 1;
            end if;
        end if;
    end process;
    
    process(pos, prender_snake) -- EL SNAKE cola  
        variable temp : unsigned(13 downto 0);
    begin
        if prender_snake = '1' then
            temp := (others => '0');
            for i in 0 to TAIL_LENGTH loop
                if (pos - i) >= 0 then
                    temp := temp or shift_left(ONE, pos - i);
                end if;
            end loop;
            led <= std_logic_vector(temp);
        else
            led <= (others => '0'); 
        end if;
    end process;
    
    
    
    
--====================================LA MEGA ULTRA MAQUINA DE ESTADOS GOD MEGA PI SAYAYIN=========================================================================================================--

    
    process(current_state, s_confirm_pulse, s_producto_id, s_saldo_actual, SW_confirm, s_precio_total,s_RESETFIN)
    begin
        next_state <= current_state;
        s_count_enable  <= '0';
        s_counter_reset <= '0';
        s_RESETFIN <= '0'; 
        LED_OUT         <= '0';

        s_display_data  <= (others => '0');
        
        case current_state is
            
            when S_SELECT_PROD =>
                prender_snake <= '0';  -- creo se peude cambiar xd 
                s_display_data <= ("00" & s_producto_id); 
                
                s_RESETFIN <= '1'; 
                
                if s_confirm_pulse = '1' then
                    next_state <= S_SHOW_PRICE;
                end if;
                
            when S_SHOW_PRICE =>
                s_display_data <= s_precio_total; 
                
                if s_confirm_pulse = '1' then
                    s_counter_reset <= '1'; 
                    next_state <= S_CONTAR_SALDO;
                end if;
                
            when S_CONTAR_SALDO =>
                s_count_enable <= '1';
                s_RESETFIN <= '0';
                s_display_data <= s_saldo_actual; 

                if SW_confirm ='1' then 
                    next_state <= S_ENTREGA;
                end if ; 
                
            when S_ENTREGA =>
                s_count_enable <= '0'; 
                
                
                if (unsigned(s_saldo_actual) >= unsigned(s_precio_total)) then
                
                    prender_snake <= '1';
                
                    resta_xd <= std_logic_vector(unsigned(s_saldo_actual) - unsigned(s_precio_total));
                    s_display_data <= resta_xd; 
                          
                        LED_OUT <= '1'; 
                    
                    
                    if entrega_done = '1'  then
                                            
                        next_state <= S_SELECT_PROD;
                    end if;
                
                else 
                    s_display_data <= s_saldo_actual; 
                    
                    LED_OUT <= '0'; 

                    next_state <= S_CONTAR_SALDO;
                    prender_snake <= '0'; 
                                   
           
                end if;
                
                
--=============================================================================================================================================--


                                
        end case;
    end process;
    
end architecture Behavioral;


