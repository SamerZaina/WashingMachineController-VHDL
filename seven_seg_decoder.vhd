library ieee;
use ieee.std_logic_1164.all;

entity seven_seg_decoder is
    port (
        binary_in : in std_logic_vector(7 downto 0);
        seg_out : out std_logic_vector(6 downto 0)
    );
end entity seven_seg_decoder;

architecture behavior of seven_seg_decoder is
begin
    process (binary_in)
    begin
        case binary_in is
            -- digits
            when "00000000" => seg_out <= "1111110"; -- 0
            when "00000001" => seg_out <= "0110000"; -- 1
            when "00000010" => seg_out <= "1101101"; -- 2
            when "00000011" => seg_out <= "1111001"; -- 3
            when "00000100" => seg_out <= "0110011"; -- 4
            when "00000101" => seg_out <= "1011011"; -- 5
            when "00000110" => seg_out <= "1011111"; -- 6
            when "00000111" => seg_out <= "1110000"; -- 7
            when "00001000" => seg_out <= "1111111"; -- 8
            when "00001001" => seg_out <= "1111011"; -- 9
            -- letters
            when "00001010" => seg_out <= "1110111"; -- A
            when "00001011" => seg_out <= "0011111"; -- B
            when "00001100" => seg_out <= "1001110"; -- C
            when "00001101" => seg_out <= "0111101"; -- D
            when "00001110" => seg_out <= "1001111"; -- E
            when "00001111" => seg_out <= "1000111"; -- F
            when "00010000" => seg_out <= "1011110"; -- G
            when "00010001" => seg_out <= "0110111"; -- H
            when "00010010" => seg_out <= "0000110"; -- I
            when "00010011" => seg_out <= "0111000"; -- J
            when "00010100" => seg_out <= "1010111"; -- K
            when "00010101" => seg_out <= "0001110"; -- L
            when "00010110" => seg_out <= "1110110"; -- M
            when "00010111" => seg_out <= "1010101"; -- N
            when "00011000" => seg_out <= "0011101"; -- O
            when "00011001" => seg_out <= "1100111"; -- P
            when "00011010" => seg_out <= "1110011"; -- Q
            when "00011011" => seg_out <= "0000101"; -- R
            when "00011100" => seg_out <= "1011011"; -- S
            when "00011101" => seg_out <= "0001111"; -- T
            when "00011110" => seg_out <= "0111110"; -- U
            when "00011111" => seg_out <= "0111010"; -- V
            when "00100000" => seg_out <= "0101010"; -- W
            when "00100001" => seg_out <= "1001001"; -- X
            when "00100011" => seg_out <= "0111011"; -- Y
            when "00100100" => seg_out <= "1101101"; -- Z
            when others => seg_out <= "-------"; -- Invalid input
        end case;
    end process;
end architecture behavior;