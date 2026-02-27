library ieee;
	use ieee.std_logic_1164.all;
	
entity seven_seg_decoder_tb is
end seven_seg_decoder_tb;

architecture behavior of seven_seg_decoder_tb is
	component seven_seg_decoder is
    port (
        binary_in : in std_logic_vector(7 downto 0);
        seg_out : out std_logic_vector(6 downto 0)
    );
end component seven_seg_decoder;


signal in_tb: std_logic_vector(7 downto 0);
signal out_tb: std_logic_vector(6 downto 0);

begin

uut: seven_seg_decodertb port map(binary_in => in_tb, seg_out => out_tb);

tb : process
constant period: time := 20 ns;
begin 
	in_tb <= "00000001"; 
	wait for period;
	assert (out_tb = "0110000")
	report "test failed for input combination 1" severity error;
	
	in_tb <= "00000010"; 
	wait for period;
	assert (out_tb = "1101101")
	report "test failed for input combination 2" severity error;

	in_tb <= "00001010"; 
	wait for period;
	assert (out_tb = "1110111")
	report "test failed for input combination a" severity error;

	
	in_tb <= "00100100"; 
	wait for period;
	assert (out_tb = "1101101")
	report "test failed for input combination z" severity error;

	
	wait; 
end process;
end architecture;