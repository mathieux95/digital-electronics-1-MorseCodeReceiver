----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2022 18:43:53
-- Design Name: 
-- Module Name: decoder - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder2 is
    Port ( clk        : in  std_logic;
           reset      : in  std_logic;
           seconds_h_i : in STD_LOGIC_VECTOR (3 - 1 downto 0);
           seconds_l_i : in STD_LOGIC_VECTOR (4 - 1 downto 0);
           hundredths_h_i : in STD_LOGIC_VECTOR (4 - 1 downto 0);
           hundredths_l_i : in STD_LOGIC_VECTOR (4 - 1 downto 0);
           rise_i : in std_logic;
           fall_i : in std_logic;
           char_o : out std_logic;
           word_o : out std_logic;
           en_o : out std_logic;
           rst_o : out std_logic);

end decoder2;

architecture Behavioral of decoder2 is
    
        -- Internal clock enable
    signal s_en    : std_logic;
    
begin
    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 10 ms (100 Hz).

    -- JUST FOR SHORTER/FASTER SIMULATION
   -- s_en <= '1';
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX =>  100000      -- 10 ms / (1/100 MHz) = g_MAX
--        )
--        port map(
--            ce_o => s_en,
--            clk => clk,
--            reset => reset
      
--        );
        
     p_decoder_cnt : process(clk)
    begin
        if rising_edge(clk) then

            if (reset = '1') then           -- Synchronous reset
                char_o <= '0';
                word_o <= '0';  
                en_o <= '0';                 
            elsif(rise_i = '1')then
                --checking if its end of char -- 3 - 6s
                if(hundredths_h_i >= "0010" and hundredths_h_i <= "0111") then
                    char_o <= '1';
                    en_o <= '1';
                --checking if its end of word 
                elsif(hundredths_h_i  > "0111") then
                    word_o <= '1';
                    en_o <= '1';                 
                end if;
            elsif(seconds_h_i = "001") then 
                word_o <= '1';
                en_o <= '1'; 
                rst_o <= '1';
            --set outputs back to 0      
            else
                rst_o <= '0';
                char_o <= '0';
                word_o <= '0';
                en_o <= '0';
                                                       
            end if;
        end if;
    end process p_decoder_cnt;

end Behavioral;
