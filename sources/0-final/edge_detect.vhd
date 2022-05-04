----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 15:42:28
-- Design Name: 
-- Module Name: edge_detect - Behavioral
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

entity edge_detect is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           smp_i : in STD_LOGIC; --tlacitko
           switch_i : in std_logic;
           smp2_i : in std_logic; --arduino
           rise_o : out STD_LOGIC;
           fall_o : out STD_LOGIC
          );
end edge_detect;

architecture Behavioral of edge_detect is

    signal s_smp_o : std_logic_vector(1 downto 0);
    signal s_smp_i : std_logic;


begin
     p_edge_detect : process(clk)
    begin
        if rising_edge(clk) then
            if (switch_i = '1')then
                s_smp_i <= smp_i;
            else
                s_smp_i <=smp2_i;    
            end if;  
        
        end if;
    end process p_edge_detect;
    
   d_ff0 : entity work.d_ff_rst     -- 2 D-type flip flops forming 2-bit shift register
        port map(
            clk => clk,
            rst => reset,
            d => s_smp_i,
            q => s_smp_o(1)
        );
        
    d_ff1 : entity work.d_ff_rst
        port map(
            clk => clk,
            rst => reset,
            d => s_smp_o(1),
            q => s_smp_o(0)
        );
        
   rise_o <= s_smp_o(1) and not(s_smp_o(0));    -- is 1 when sequence '0','1' is detected, otherwise 0
   fall_o <= not(s_smp_o(1)) and s_smp_o(0);   -- is 1 when sequence '1','0' is detected, otherwise 0
   
   
   --__________________________________________
   --|s_smp_o(1) |s_smp_o(0) || rise_o | fall_o|
   --|     0     |     0     ||    0   |   0   |
   --|     0     |     1     ||    0   |   1   |
   --|     1     |     0     ||    1   |   0   |
   --|     1     |     1     ||    0   |   0   |
   --------------------------------------------
    

end architecture Behavioral;