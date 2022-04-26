----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2022 21:18:42
-- Design Name: 
-- Module Name: 8bit_memory - Behavioral
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

entity memory_8bit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           rdy_i : in STD_LOGIC;
           data_i : in STD_LOGIC_VECTOR (7 downto 0);
           data0_o : out STD_LOGIC_VECTOR (7 downto 0);
           data1_o : out STD_LOGIC_VECTOR (7 downto 0);
           data2_o : out STD_LOGIC_VECTOR (7 downto 0);
           data3_o : out STD_LOGIC_VECTOR (7 downto 0);
           data4_o : out STD_LOGIC_VECTOR (7 downto 0);
           data5_o : out STD_LOGIC_VECTOR (7 downto 0);
           data6_o : out STD_LOGIC_VECTOR (7 downto 0);
           data7_o : out STD_LOGIC_VECTOR (7 downto 0));
end memory_8bit;

architecture Behavioral of memory_8bit is

    signal s_o0 : std_logic_vector(7 downto 0);
    signal s_o1 : std_logic_vector(7 downto 0);
    signal s_o2 : std_logic_vector(7 downto 0);
    signal s_o3 : std_logic_vector(7 downto 0);
    signal s_o4 : std_logic_vector(7 downto 0);
    signal s_o5 : std_logic_vector(7 downto 0);
    signal s_o6 : std_logic_vector(7 downto 0);
    signal s_o7 : std_logic_vector(7 downto 0);

begin

    reg0 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => data_i,
            output => s_o0
        );
        
    reg1 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o0,
            output => s_o1
        );
     
    reg2 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o1,
            output => s_o2
        );
     
    reg3 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o2,
            output => s_o3
        );
     
    reg4 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o3,
            output => s_o4
        );
     
    reg5 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o4,
            output => s_o5
        );
     
    reg6 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o5,
            output => s_o6
        );
     
     reg7 : entity work.par_register_8bit
        port map(
            clk => clk,
            reset => reset,
            en => rdy_i,
            input => s_o6,
            output => s_o7
        );
     
    data0_o <= s_o0;
    data1_o <= s_o1;
    data2_o <= s_o2;
    data3_o <= s_o3;
    data4_o <= s_o4;
    data5_o <= s_o5;
    data6_o <= s_o6;
    data7_o <= s_o7; 
    
end architecture Behavioral;
