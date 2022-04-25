library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_jk_ff_rst is
    -- Entity of testbench is always empty
end entity tb_jk_ff_rst;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_jk_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_rst        : std_logic;
    signal s_sample         : std_logic;
    signal s_q       : std_logic;

begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    
    -----------------------------------------------------------
    -- For testing the functionality of 1bit data cell made from 
    -- 1 jk flip-flop with the inputs connected together. 
    -- State of the cell doesn't change until a positive impulse comes which
    -- inverts the stored value. 
    -----------------------------------------------------------
        
    uut_jk_ff_rst : entity work.jk_ff_rst
        port map(
            clk     => s_clk_100MHz,
            rst     => s_rst,
            j   => s_sample,
            k => s_sample,
            q => s_q
             
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
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 10 ns;
        s_sample <='0'; wait for 100 ns;
        s_sample <='1'; wait for 10 ns;
        s_sample <='0'; wait for 45 ns;
        s_sample <='1'; wait for 10 ns;
        s_sample <='0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
