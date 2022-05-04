
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2022 20:16:08
-- Design Name: 
-- Module Name: morse_to_8bit_shifter - Behavioral
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

entity morse_to_8bit_shifter is
    Port ( dot_i : in STD_LOGIC;
           dash_i : in STD_LOGIC;
           en1_i : in STD_LOGIC;
           char_i : in STD_LOGIC;
           word_i : in STD_LOGIC;
           en2_i : in STD_LOGIC;
           rst : in STD_logic;
           clk : in STD_logic;
           data_o : out STD_LOGIC_VECTOR (8 - 1 downto 0);
           rdy_o : out STD_LOGIC);  -- signal for activating loading into shift register to store the output, unused in the final version  
end morse_to_8bit_shifter;

architecture Behavioral of morse_to_8bit_shifter is
-- local signals
signal s_rdy : std_logic;
signal data_int : std_logic_vector (8 - 1 downto 0);

begin
    shift_register:process (clk)
        begin
            if rst = '1' then           -- asynchronous reset
                data_int <= "00000001";
                data_o <= "10000000";
                rdy_o <= '0';
            elsif rising_edge (clk) then    
                if (en1_i = '1' and en2_i = '0') then                                           -- input from decoder of dots/dashes is detected  
                    rdy_o <= '0';                                                               -- output signaling is turned off 
                    if dot_i = '1' then                                                         -- if dot comes in
                        data_int <= data_int(6 downto 0) & '0';                                 ---- put '0' into shift register
                    elsif dash_i = '1' then                                                     -- if dash comes in
                        data_int <= data_int(6 downto 0) & '1';                                 ---- put '1'
                    end if;
                elsif (en1_i = '0' and en2_i = '1' and (char_i = '1' or word_i = '1')) then     -- input from decoder of pauses is detected
                    data_o <= data_int;                                                         ---- shift register contents are sent to the output
                    rdy_o <= '1';                                                               ---- and rdy_o signals new output is present 
                    s_rdy <= '1';     
                elsif(s_rdy = '1' and en2_i = '0') then                                         -- after input from decoder of pauses stops
                     data_int <= "00000001";                                                    ---- shift register is resetted
                     s_rdy <= '0';                                                              ---- and s_rdy is set for the next output cycle 
                else
                    rdy_o <= '0';                                                               -- output signaling is turned off
                end if;
            end if;    
    end process;
end Behavioral;
