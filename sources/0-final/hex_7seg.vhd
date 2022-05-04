----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2022 03:15:11 PM
-- Design Name: 
-- Module Name: hex_7seg - Behavioral
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

entity hex_7seg is
    Port ( hex_i : in STD_LOGIC_VECTOR (8 - 1 downto 0);
           seg_o : out STD_LOGIC_VECTOR (7 - 1 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is
begin

    --------------------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common Anode)
    -- decoder. Any time "hex_i" is changed, the process is "executed".
    -- Output pin seg_o(6) controls segment A, seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        +-+|  |   ...   segment G
    --          ||+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------------------
    p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "00011111" =>
                seg_o <= "0000001";     -- 0

            when "00101111" =>
                seg_o <= "1001111";     -- 1

            when "00100111" =>
                seg_o <= "0010010";     -- 2

            when "00100011" =>
                seg_o <= "0000110";     -- 3

            when "00100001" =>
                seg_o <= "1001100";     -- 4

            when "00100000" =>
                seg_o <= "0100100";     -- 5

            when "00110000" =>
                seg_o <= "0100000";     -- 6

            when "00111000" =>
                seg_o <= "0001111";     -- 7

            when "00111100" =>
                seg_o <= "0000000";     -- 8

            when "00111110" =>
                seg_o <= "0000100";     -- 9

            when "00000101" =>
                seg_o <= "0000010";     -- A

            when "00011000" =>
                seg_o <= "1100000";     -- B

            when "00011010" =>
                seg_o <= "1110010";     -- C 

            when "00001100" =>
                seg_o <= "1000010";     -- D 

            when "00000010" =>
                seg_o <= "0110000";     -- E

	    when "00010010" =>
                seg_o <= "0111000";     -- F

            when "00001110" =>
                seg_o <= "0100001";     -- G

            when "00010000" =>
                seg_o <= "1101000";     -- H

            when "00000100" =>
                seg_o <= "0111011";     -- I 

            when "00010111" =>
                seg_o <= "0100111";     -- J

            when "00001101" =>
                seg_o <= "0101000";     -- K

	    when "00010100" =>
                seg_o <= "1110001";     -- L

	    when "00000111" =>
                seg_o <= "0101010";     -- M

            when "00000110" =>
                seg_o <= "1101010";     -- N

            when "00001111" =>
                seg_o <= "1100010";     -- O 

            when "00010110" =>
                seg_o <= "0011000";     -- P

            when "00011101" =>
                seg_o <= "0001100";     -- Q

	    when "00001010" =>
                seg_o <= "1111010";     -- R

	    when "00001000" =>
                seg_o <= "0100101";     -- S

            when "00000011" =>
                seg_o <= "1110000";     -- T

	    when "00001001" =>
                seg_o <= "1100011";     -- U

	    when "00010001" =>
                seg_o <= "1010101";     -- V

	    when "00001011" =>
                seg_o <= "1010100";     -- W

            when "00011001" =>
                seg_o <= "1101011";     -- X

	    when "00011011" =>
                seg_o <= "1000100";     -- Y
	   
 	    when "00011100" =>
                seg_o <= "0010011";     -- Z

            when others =>
                seg_o <= "1111111";     --  segments don't light up with undefined input 

        end case;
    end process p_7seg_decoder;

end architecture Behavioral;
