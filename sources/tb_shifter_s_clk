----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2022 20:57:07
-- Design Name: 
-- Module Name: tb_morse_to_8bit_shifter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_morse_to_8bit_shifter is
--    Port ( dot_i : in STD_LOGIC;
--           dash_i : in STD_LOGIC;
--           en1_i : in STD_LOGIC;
--           char_i : in STD_LOGIC;
--           word_i : in STD_LOGIC;
--           en2_i : in STD_LOGIC;
--           data_o : out STD_LOGIC_VECTOR (7 downto 0);
--           rdy_o : out STD_LOGIC;
--           rst : in STD_LOGIC);
end tb_morse_to_8bit_shifter;

architecture Behavioral of tb_morse_to_8bit_shifter is
signal s_rst          : std_logic;
signal s_data_int     : std_logic_vector (7 downto 0);
signal s_dot_i        : std_logic;
signal s_dash_i       : std_logic;
signal s_en1_i        : std_logic;
signal s_char_i       : std_logic;
signal s_word_i       : std_logic;
signal s_en2_i        : std_logic;
signal s_data_o       : std_logic_vector (7 downto 0);
signal s_rdy_o        : std_logic;
signal s_clk          : std_logic; 

begin

    uut: entity work.morse_to_8bit_shifter 
--    generic map(
--            data_int => s_data_int
--        )
    PORT MAP(
        dot_i => s_dot_i,
        dash_i => s_dash_i,
        en1_i => s_en1_i,
        char_i => s_char_i,
        word_i => s_word_i,
        en2_i => s_en2_i,
        data_o => s_data_o,
        rdy_o => s_rdy_o,
        rst => s_rst,
        clk => s_clk
        );
        
 --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for 10 ns / 2;
            s_clk <= '1';
            wait for 10 ns / 2;
        end loop;
        wait;
    end process p_clk_gen; 
        
        
 --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        
        s_rst <= '1'; wait for 73 ns;
        -- Reset deactivated
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        wait for 110 ns;
        s_en1_i <= '1';
        s_dot_i <= '1';
        s_dash_i <= '0';
        s_char_i <= '0';
        s_word_i <= '0';
        s_en2_i <= '0';
        
        wait for 10 ns;
        s_en1_i <= '1';
        s_dot_i <= '0';
        s_dash_i <= '1';
        s_char_i <= '0';
        s_word_i <= '0';
        s_en2_i <= '0';
        
        wait for 10 ns;
        s_en1_i <= '1';
        s_dot_i <= '0';
        s_dash_i <= '1';
        s_char_i <= '0';
        s_word_i <= '0';
        s_en2_i <= '0';
        
        wait for 10 ns;
        s_en1_i <= '0';
        s_dot_i <= '0';
        s_dash_i <= '0';
        s_char_i <= '1';
        s_word_i <= '0';
        s_en2_i <= '1';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
