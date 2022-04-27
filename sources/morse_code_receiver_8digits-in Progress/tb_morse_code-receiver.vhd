library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_top is
    -- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_top is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_rst        : std_logic;
    signal s_sample     : std_logic;
    signal s_rise       : std_logic;
    signal s_fall       : std_logic;
    signal s_seconds_h    : std_logic_vector(3 - 1 downto 0);
    signal s_seconds_l    : std_logic_vector(4 - 1 downto 0);
    signal s_hundredths_h : std_logic_vector(4 - 1 downto 0);
    signal s_hundredths_l : std_logic_vector(4 - 1 downto 0);
    signal s_seconds_h2    : std_logic_vector(3 - 1 downto 0);
    signal s_seconds_l2    : std_logic_vector(4 - 1 downto 0);
    signal s_hundredths_h2 : std_logic_vector(4 - 1 downto 0);
    signal s_hundredths_l2 : std_logic_vector(4 - 1 downto 0);
    signal s_dot   : std_logic;
    signal s_dash        : std_logic;
    signal s_char        : std_logic;
    signal s_word        : std_logic;
    signal s_en        : std_logic;
    signal s_en2        : std_logic;
    signal s_num : std_logic;
    signal s_dec_reset : std_logic;
    signal s_rdy : std_logic;
    signal s_data_to_memory : std_logic_vector(8 - 1 downto 0);
    signal s_data0_o : std_logic_vector(8 - 1 downto 0);
    signal s_data1_o : std_logic_vector(8 - 1 downto 0);
    signal s_data2_o : std_logic_vector(8 - 1 downto 0);
    signal s_data3_o : std_logic_vector(8 - 1 downto 0);
    signal s_data4_o : std_logic_vector(8 - 1 downto 0);
    signal s_data5_o : std_logic_vector(8 - 1 downto 0);
    signal s_data6_o : std_logic_vector(8 - 1 downto 0);
    signal s_data7_o : std_logic_vector(8 - 1 downto 0);
    
    signal s_seg_o : std_logic_vector(7 - 1 downto 0);
    signal s_dig_o : std_logic_vector(8 - 1 downto 0);
  
    
begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    
    
        
    uut_edge_detect : entity work.edge_detect
        port map(
            clk     => s_clk_100MHz,
            reset     => s_rst,
            smp_i   => s_sample,
            rise_o => s_rise,
            fall_o => s_fall
             
        );
        
     uut_stopwatch_seconds : entity work.stopwatch_seconds
        port map(
            clk            => s_clk_100MHz,
            reset          => s_rst,
            start_i        => s_rise,
            pause_i        => s_fall,
            seconds_h_o    => s_seconds_h,
            seconds_l_o    => s_seconds_l,
            hundredths_h_o => s_hundredths_h,
            hundredths_l_o => s_hundredths_l
        );
        
      uut_stopwatch_seconds2 : entity work.stopwatch_seconds2
        port map(
            clk            => s_clk_100MHz,
            reset          => s_rst,
            start_i        => s_fall,
            pause_i        => s_rise,
            seconds_h_o    => s_seconds_h2,
            seconds_l_o    => s_seconds_l2,
            hundredths_h_o => s_hundredths_h2,
            hundredths_l_o => s_hundredths_l2,
            dec_reset => s_dec_reset
        ); 
       uut_decoder : entity work.decoder
        port map(
            clk            => s_clk_100MHz,
            reset          => s_rst,
            seconds_h_i    => s_seconds_h,
            seconds_l_i    => s_seconds_l,
            hundredths_h_i => s_hundredths_h,
            hundredths_l_i => s_hundredths_l,
            rise_i => s_rise,
            fall_i => s_fall,
            dot_o  => s_dot,
            dash_o => s_dash,
            en_o   => s_en
        ); 
      uut_decoder2 : entity work.decoder2
        port map(
            clk            => s_clk_100MHz,
            reset          => s_rst,
            seconds_h_i    => s_seconds_h2,
            seconds_l_i    => s_seconds_l2,
            hundredths_h_i => s_hundredths_h2,
            hundredths_l_i => s_hundredths_l2,
            rise_i => s_rise,
            fall_i => s_fall,
            char_o => s_char,
            word_o => s_word,
            en_o   => s_en2,
            rst_o => s_dec_reset
        ); 
     uut_morse_to_8bit_shifter : entity work.morse_to_8bit_shifter
        port map(
            clk            => s_clk_100MHz,
            rst       => s_rst,
            rdy_o       => s_rdy,
            dot_i  => s_dot,
            dash_i => s_dash,
            en1_i   => s_en,
            char_i => s_char,
            word_i => s_word,
            en2_i   => s_en2,
            data_o  => s_data_to_memory
        ); 
   uut_memory_8bit : entity work.memory_8bit
        port map(
            clk            => s_clk_100MHz,
            reset       => s_rst,
            rdy_i       => s_rdy,
            data_i      => s_data_to_memory,
            data0_o     => s_data0_o,
            data1_o     => s_data1_o,
            data2_o     => s_data2_o,
            data3_o     => s_data3_o,
            data4_o     => s_data4_o,
            data5_o     => s_data5_o,
            data6_o     => s_data6_o,
            data7_o     => s_data7_o
        ); 
     uut_driver_7seg_8digits : entity work.driver_7seg_8digits
        port map(
            clk            => s_clk_100MHz,
            reset       => s_rst,
            data0_i     => s_data0_o,
            data1_i     => s_data1_o,
            data2_i     => s_data2_o,
            data3_i     => s_data3_o,
            data4_i     => s_data4_o,
            data5_i     => s_data5_o,
            data6_i     => s_data6_o,
            data7_i     => s_data7_o,
            dig_o       => s_dig_o,
            seg_o       => s_seg_o
            
        );                
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 1000000 ns loop -- 20 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst <= '1'; wait for 18 ns;
        s_rst <= '0';

        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_sample <='0'; wait for 17 ns;
        s_sample <='1'; wait for 1200 ns;
        s_sample <='0'; wait for 2000 ns;
        s_sample <='1'; wait for 3000 ns;
        s_sample <='0'; wait for 5000 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
        s_sample <='1';wait for 200 ns;

                s_sample <='0'; wait for 17 ns;
        s_sample <='1'; wait for 1200 ns;
        s_sample <='0'; wait for 2000 ns;
        s_sample <='1'; wait for 3000 ns;
        s_sample <='0'; wait for 5000 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
                s_sample <='1'; wait for 89 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 220 ns;
        s_sample <='0'; wait for 200 ns;
        s_sample <='1'; wait for 200 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;