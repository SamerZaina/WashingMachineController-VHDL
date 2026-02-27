library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.ALL;
  
entity Clk_Divider is
	port ( clk,reset: in std_logic;
			clock_out: out std_logic);
end Clk_Divider;
  
architecture bhv of Clk_Divider is
  
signal count: integer:= 250;
signal tmp : std_logic := '0';
  
begin
  
process(clk,reset)
	begin
		if(reset='1') then --default
		count<= 250;
		tmp<='0';
		
		elsif(clk'event and clk='1') then
			count <= count-1;
			if (count = 0) then
				tmp <= NOT tmp;
				count <= 250;
			end if;
		end if;
		clock_out <= tmp;
end process;
  
end bhv;