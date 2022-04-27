library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity top is
  port(  CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC);
end entity top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture behavior of top is
    --Local signals
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
    signal s_data0_o : std_logic_vector(8 - 1 downto 0);
    signal s_data1_o : std_logic_vector(8 - 1 downto 0);
    signal s_data2_o : std_logic_vector(8 - 1 downto 0);
    signal s_data3_o : std_logic_vector(8 - 1 downto 0);
    signal s_data4_o : std_logic_vector(8 - 1 downto 0);
    signal s_data5_o : std_logic_vector(8 - 1 downto 0);
    signal s_data6_o : std_logic_vector(8 - 1 downto 0);
    signal s_data7_o : std_logic_vector(8 - 1 downto 0);
    signal s_dot   : std_logic;
    signal s_dash        : std_logic;
    signal s_char        : std_logic;
    signal s_word        : std_logic;
    signal s_en        : std_logic;
    signal s_en2        : std_logic;
    signal s_num : std_logic;
    signal s_dec_reset : std_logic;
    signal s_rdy : std_logic;
    signal s_rdy1 : std_logic;
    signal s_data_to_memory : std_logic_vector(8 - 1 downto 0);    
    signal s_seg_o : std_logic_vector(7 - 1 downto 0);
    signal s_dig_o : std_logic_vector(8 - 1 downto 0);
    
begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    
    
        
    edge_detect : entity work.edge_detect
        port map(
            clk     => CLK100MHZ,
            reset     => BTNC,
            smp_i   => BTNU,
            rise_o => s_rise,
            fall_o => s_fall
             
        );
        
     stopwatch_seconds : entity work.stopwatch_seconds
        port map(
            clk            => CLK100MHZ,
            reset          => BTNC,
            start_i        => s_rise,
            pause_i        => s_fall,
            seconds_h_o    => s_seconds_h,
            seconds_l_o    => s_seconds_l,
            hundredths_h_o => s_hundredths_h,
            hundredths_l_o => s_hundredths_l
        );
        
      stopwatch_seconds2 : entity work.stopwatch_seconds2
        port map(
            clk            => CLK100MHZ,
            reset          => BTNC,
            start_i        => s_fall,
            pause_i        => s_rise,
            seconds_h_o    => s_seconds_h2,
            seconds_l_o    => s_seconds_l2,
            hundredths_h_o => s_hundredths_h2,
            hundredths_l_o => s_hundredths_l2,
            dec_reset => s_dec_reset
        ); 
       decoder : entity work.decoder
        port map(
            clk            => CLK100MHZ,
            reset          => BTNC,
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
      decoder2 : entity work.decoder2
        port map(
            clk            => CLK100MHZ,
            reset          => BTNC,
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
     morse_to_8bit_shifter : entity work.morse_to_8bit_shifter
        port map(
            clk            => CLK100MHZ,
            rst       => BTNC,
            rdy_o       => s_rdy,
            dot_i  => s_dot,
            dash_i => s_dash,
            en1_i   => s_en,
            char_i => s_char,
            word_i => s_word,
            en2_i   => s_en2,
            data_o  => s_data_to_memory
        );
        memory_8bit : entity work.memory_8bit
        port map(
            clk            => CLK100MHZ,
            reset       => BTNC,
            rdy_i       => s_rdy1,
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
        
        edge_detect1 : entity work.edge_detect
        port map(
            clk     =>  CLK100MHZ,
            reset   => BTNC,
            smp_i   => s_rdy,
            rise_o  => s_rdy1
        );  

      driver_7seg_8digits : entity work.driver_7seg_8digits 
      port map(
          clk        => CLK100MHZ,
          reset      => BTNC,
          data0_i => s_data0_o,
          data1_i => s_data1_o,
          data2_i => s_data2_o,
          data3_i => s_data3_o,
          data4_i => s_data4_o,
          data5_i => s_data5_o,
          data6_i => s_data6_o,
          data7_i => s_data7_o,
          
          
                    -- MAP DECIMAL POINT AND DISPLAY SEGMENTS
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG,
          dig_o(8 - 1 downto 0) => AN(8 - 1 downto 0)
      );    
end architecture behavior;