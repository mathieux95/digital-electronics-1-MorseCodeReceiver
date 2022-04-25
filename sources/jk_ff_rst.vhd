----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2022 19:42:35
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity jk_ff_rst is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           j : in STD_LOGIC;
           k : in STD_LOGIC;
           q : out STD_LOGIC;
           q_bar : out STD_LOGIC);
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is

    signal s_q_n : std_logic;

begin
    p_jk_ff_rst : process(clk)
    begin
        if rising_edge(clk) then  -- Synchronous process

            if (rst = '1') then
                q     <= '0';
                q_bar <= '1';
                s_q_n <= '0';
            else
                s_q_n   <= (j and not(s_q_n)) or (s_q_n and not(k));
                q       <= (j and not(s_q_n)) or (s_q_n and not(k));
                q_bar   <= not(s_q_n);
            end if; 
        end if;
    end process p_jk_ff_rst;

end architecture Behavioral;
