----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 19:05:24
-- Design Name: 
-- Module Name: par_register_8bit - Behavioral
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

entity par_register_8bit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0)
           );
end par_register_8bit;

architecture Behavioral of par_register_8bit is


begin
    d_ff0 : entity work.d_ff_en     -- 8 D-type flip flops forming 8-bit paralell register with enable pin
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(0),
            q => output(0)
        );
        
    d_ff1 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(1),
            q => output(1)
        );
        
     d_ff2 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(2),
            q => output(2)
        );
        
      d_ff3 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(3),
            q => output(3)
        );
       
       d_ff4 : entity work.d_ff_en    
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(4),
            q => output(4)
        );
        
       d_ff5 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(5),
            q => output(5)
        );
        
        d_ff6 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(6),
            q => output(6)
        );
        
        d_ff7 : entity work.d_ff_en     
        port map(
            clk => clk,
            rst => reset,
            en => en,
            d => input(7),
            q => output(7)
        );

end architecture Behavioral;
