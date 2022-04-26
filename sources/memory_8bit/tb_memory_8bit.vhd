library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_memory_8bit is
    -- Entity of testbench is always empty
end entity tb_memory_8bit;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_memory_8bit is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_rst        : std_logic;
    signal s_en         : std_logic;
    signal s_data_i     : std_logic_vector(7 downto 0);
    signal s_out0       : std_logic_vector(7 downto 0);
    signal s_out1       : std_logic_vector(7 downto 0);
    signal s_out2       : std_logic_vector(7 downto 0);
    signal s_out3       : std_logic_vector(7 downto 0);
    signal s_out4       : std_logic_vector(7 downto 0);
    signal s_out5       : std_logic_vector(7 downto 0);
    signal s_out6       : std_logic_vector(7 downto 0);
    signal s_out7       : std_logic_vector(7 downto 0);

begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
        
    uut_edge_detect : entity work.memory_8bit
        port map(
            clk     => s_clk_100MHz,
            reset     => s_rst,
            rdy_i   => s_en,
            data_i => s_data_i,
            data0_o => s_out0,
            data1_o => s_out1,
            data2_o => s_out2,
            data3_o => s_out3,
            data4_o => s_out4,
            data5_o => s_out5,
            data6_o => s_out6,
            data7_o => s_out7
             
        );
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 1000 ns loop -- 20 periods of 100MHz clock
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
        wait for 50 ns;
        s_data_i <="00000001"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000010"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000011"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000100"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000101"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000110"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000111"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00001000"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00001001"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000000"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000001"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000010"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000011"; s_en <= '1'; wait for 10 ns;
        s_en <= '0'; wait for 50 ns;
        s_data_i <="00000100"; s_en <= '1'; wait for 10 ns;
        s_en <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
