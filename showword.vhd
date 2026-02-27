library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.numeric_std.ALL;
  
entity showword is
	port ( start , reset , slowClk , fastClk: in std_logic; -- fastClk(50mhz) to show word , slowClk(100khz) to change state 
			 userProg : in  std_logic_vector(4 downto 0);
			state : out std_logic_vector(1 downto 0 ) ;
			segdriver : out std_logic_vector(7 downto 0)
			  );
end showword;
  
architecture bhv of showword is

  signal Countidle: integer:= 3;   -- for idle word
  signal Countwash: integer:= 3;   -- for wash word
  signal Countspin: integer:= 3;   -- for spin word
  signal Countrinse: integer:= 4;  -- for rinse word
  signal Countslow: integer:= 3;   -- for slow word
  signal Countcotton: integer:= 5; -- for cotton word
  signal Countrapid: integer:= 4;  -- for rapid word
  signal Countdrain: integer:= 4;  -- for drain word
  signal Countwhite: integer:= 4;  -- for white word
  
  -- number of cycle for each programm
  -- cotton
  signal washnumcotton: integer := 4;
  signal spinnumcotton: integer  := 5;
  signal rinsenumcotton: integer := 2; 
  -- rapid
  signal washnumrapid: integer  := 2;
  signal spinnumrapid: integer  := 3;
  signal rinsenumrapid: integer := 1;
  -- slow
  signal washnumslow: integer := 1;
  signal spinnumslow: integer := 2;
  signal rinsenumslow: integer := 1;
  -- drain
  signal washnumdrain: integer  := 0;
  signal spinnumdrain: integer := 2;
  signal rinsenumdrain: integer  := 2; 
  -- white
  signal washnumwhite: integer  := 3;
  signal spinnumwhite: integer := 4;
  signal rinsenumwhite: integer  := 1;
  
  signal connect : std_logic_vector(1 downto 0):= "11";
  
begin

  
	
p2:process(reset,start,slowClk)

	
	begin
	
		if (reset = '1' or start ='0') then null;
			
			
		elsif(rising_edge(slowClk)) then 
		
			if(userProg = "10000") then  -- cotton
			
				if(washnumcotton > 0) then
					state <="00";
					connect <= 	"00";		
					washnumcotton <= washnumcotton - 1 ;
				
				elsif(spinnumcotton > 0 and washnumcotton = 0) then
					state <="01";
					connect <= 	"01";		
					spinnumcotton <= spinnumcotton - 1 ;
				elsif(rinsenumcotton > 0 and spinnumcotton = 0 and washnumcotton = 0) then
					state <="10";
					connect <= 	"10";		
					rinsenumcotton <= rinsenumcotton - 1 ;
				elsif(rinsenumcotton = 0 and spinnumcotton = 0 and washnumcotton = 0)  then 
					state <= "11" ;
					connect <= 	"11";
				end if;
				
			elsif(userProg = "01000") then  -- rapaid
				if(washnumrapid > 0) then
					state <="00";	
				connect <= 	"00";	
					washnumrapid <= washnumrapid - 1 ;
				
				elsif(spinnumrapid > 0 and washnumrapid = 0) then
					state <="01";	
				connect <= 	"01";	
					spinnumrapid <= spinnumrapid - 1 ;
				elsif(rinsenumrapid > 0 and spinnumrapid = 0 and washnumrapid = 0) then
					state <="10";	
				connect <= 	"10";	
					rinsenumrapid <= rinsenumrapid - 1 ;
				elsif(rinsenumrapid = 0 and spinnumrapid = 0 and washnumrapid = 0)  then 
					state <= "11" ;
					connect <= 	"11";
				end if;
					
				
			elsif(userProg = "00100") then -- slow
				if(washnumslow > 0) then
					state <="00";
			connect <= 	"00";		
					washnumslow <= washnumslow - 1 ;
				
				elsif(spinnumslow > 0 and washnumslow = 0) then
					state <="01";	
					connect <= 	"01";	
					spinnumslow <= spinnumslow - 1 ;
				elsif(rinsenumslow > 0 and spinnumslow = 0 and washnumslow = 0) then
					state <="10";	
					connect <= 	"10";	
					rinsenumslow <= rinsenumslow - 1 ;
				elsif(rinsenumslow = 0 and spinnumslow = 0 and washnumslow = 0)  then 
					state <= "11" ;
					connect <= 	"11";
				end if;
						
			elsif(userProg = "00010") then -- drain
				if(washnumdrain > 0) then
					state <="00";
					connect <= 	"00";		
					washnumdrain <= washnumdrain - 1 ;
				
				elsif(spinnumdrain > 0 and washnumdrain = 0) then
					state <="01";	
					connect <= 	"01";	
					spinnumdrain <= spinnumdrain - 1 ;
				elsif(rinsenumdrain > 0 and spinnumdrain = 0 and washnumdrain = 0) then
					state <="10";	
					connect <= 	"10";	
					rinsenumdrain <= rinsenumdrain - 1 ;
				elsif(rinsenumdrain = 0 and spinnumdrain = 0 and washnumdrain = 0)  then 
					state <= "11" ;
					connect <= 	"11";
				end if;
				
			elsif(userProg = "00001") then -- white
				if(washnumwhite > 0) then
					state <="00";	
					connect <= 	"00";
					washnumwhite <= washnumwhite - 1 ;
				
				elsif(spinnumwhite > 0 and washnumwhite = 0) then
					state <="01";
					connect <= 	"01";		
					spinnumwhite <= spinnumwhite - 1 ;
				elsif(rinsenumwhite > 0 and spinnumwhite = 0 and washnumwhite = 0) then
					state <="10";
					connect <= 	"10";
					rinsenumwhite <= rinsenumwhite - 1 ;
				elsif(rinsenumwhite = 0 and spinnumwhite = 0 and washnumwhite = 0)  then 
					state <= "11" ;
					connect <= 	"11";
				end if;

					
				
		-----
			
		end if ;
			
	end if ;
end process p2;


p1:process(start,reset,fastClk,userProg,connect)

	begin
	
	-- if reset =1 then we should show idle using counter 
		if (rising_edge(fastClk) and reset = '1') then 
			Countidle<= 0;		
			if(Countidle = 3) then segdriver <="00010010"; -- for i
			elsif(Countidle = 2) then segdriver <="00001101"; -- for d
			elsif(Countidle = 1) then segdriver <="00010101"; -- for l
			end if;
			Countidle <= Countidle - 1;
			if (Countidle = 0) then
				segdriver <="00001110"; -- for e
				Countidle <= 3; 	
			end if;
			
		elsif(rising_edge(fastClk) and start = '0') then 
		
			if(userProg = "10000") then  -- cotton
			
					if(Countcotton = 4 or Countidle = 1 ) then segdriver <="00011000"; -- for o
					elsif(Countcotton = 5) then segdriver <="00001100"; -- for c
					elsif(Countcotton = 2 or Countcotton = 3 ) then segdriver <="00011101"; -- for t
					end if;
					
					Countcotton <= Countcotton - 1;
					if (Countcotton = 0) then
						segdriver <="00010111"; -- for n
						Countcotton <= 5; 
					end if ;
				
			elsif(userProg = "01000") then  -- rapaid
				
					if(Countrapid = 4 or Countrapid = 2 ) then segdriver <="00001010"; -- for a
					elsif(Countrapid = 1) then segdriver <="00010010"; -- for i
					elsif( Countrapid = 3 ) then segdriver <="00011001"; -- for p
					elsif( Countrapid = 5 ) then segdriver <="00011011"; -- for r
					end if;
					
					Countrapid <= Countrapid - 1;
					if (Countrapid = 0) then
						segdriver <="00001101"; -- for d
						Countrapid <= 5; 
					end if ;
				
			elsif(userProg = "00100") then -- slow
				
					if(Countslow = 3 ) then segdriver <="00011100"; -- for s
					elsif(Countslow = 2) then segdriver <="00010101"; -- for l
					elsif( Countslow = 1 ) then segdriver <="00011000"; -- for o
					end if;
					
					Countslow <= Countslow - 1;
					if (Countslow = 0) then
						segdriver <="00100000"; -- for w
						Countslow <= 3; 
					end if ;
						
			elsif(userProg = "00010") then -- drain
			
					if(Countdrain = 4 ) then segdriver <="00001101"; -- for d
					elsif(Countdrain = 3) then segdriver <="00011011"; -- for r
					elsif( Countdrain = 2 ) then segdriver <="00001010"; -- for a
					elsif( Countdrain = 1 ) then segdriver <="00010010"; -- for i
					end if;
					
					Countdrain <= Countdrain - 1;
					if (Countdrain = 0) then
						segdriver <="00010111"; -- for n
						Countdrain <= 4; 
					end if ;		
				
			elsif(userProg = "00001") then -- white

					if(Countwhite = 4 ) then segdriver <="00100000"; -- for w
					elsif(Countwhite = 3) then segdriver <="00010001"; -- for h
					elsif( Countwhite = 2 ) then segdriver <="00010010"; -- for i
					elsif( Countwhite = 1 ) then segdriver <="00011101"; -- for t
					end if;
					
					Countwhite <= Countwhite - 1;
					if (Countwhite = 0) then
						segdriver <="00001110"; -- for e
						Countwhite <= 4; 
					end if ;
	-------------------------------------------------------------------------------			
			end if;
			elsif(rising_edge(fastClk) and start = '1') then
				if(connect = "00") then  -- wash
				Countwash<= 0;		
				if(Countwash = 3) then segdriver <="00100000"; -- for w
				elsif(Countwash = 2) then segdriver <="00001010"; -- for a
				elsif(Countwash = 1) then segdriver <="00011100"; -- for s
				end if;
			Countwash <= Countwash - 1;
			if (Countwash = 0) then
				segdriver <="00010001"; -- for h
				Countwash <= 3; 	
			end if;
				
			elsif(connect = "01") then  -- spin
			
				Countspin<= 0;		
				if(Countspin = 3) then segdriver <="00011100"; -- for s
				elsif(Countspin = 2) then segdriver <="00011001"; -- for p
				elsif(Countspin = 1) then segdriver <="00010010"; -- for i
				end if;
			Countspin <= Countspin - 1;
			if (Countspin = 0) then
				segdriver <="00010111"; -- for n
				Countspin <= 3; 	
			end if;
				
			
			elsif(connect = "10") then  -- rinse
			
			Countrinse<= 0;		
				if(Countrinse = 4) then segdriver <="00011011"; -- for r
				elsif(Countrinse = 3) then segdriver <="00010010"; -- for i
				elsif(Countrinse = 2) then segdriver <="00010111"; -- for n
				elsif(Countrinse = 1) then segdriver <="00011100"; -- for s
				end if;
			Countrinse <= Countrinse - 1;
			if (Countrinse = 0) then
				segdriver <="00001110"; -- for e
				Countrinse <= 4; 	
			end if;
			
	end if;
	end if ;

end process p1;
 
  
end bhv;