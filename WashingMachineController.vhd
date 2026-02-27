library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WashingMachineController is
    port (
        userProg : in std_logic_vector(4 downto 0); -- chooses one of 5 programs 
        clk : in std_logic;  -- 50 MHz clock
        reset : in std_logic;  -- if = 1 then wash cycle is idle
        start : in std_logic; -- if = 1 start the chosen program 
        sevseg_data : out std_logic_vector(6 downto 0);
        sevseg_driver : out std_logic_vector(7 downto 0);
        state : out std_logic_vector(1 downto 0)  -- 00 wash, 01 spin, 10 rinse, 11 idle 
    );
end entity WashingMachineController;

architecture Behavioral of WashingMachineController is

    component seven_seg_decoder is 
        port (
            binary_in : in std_logic_vector(7 downto 0);
            seg_out : out std_logic_vector(6 downto 0)
        );
    end component seven_seg_decoder;

    component Clk_Divider is
        port (
            clk, reset: in std_logic;
            clock_out: out std_logic
        );
    end component Clk_Divider;

    component showword is
        port (
            start, reset, slowClk, fastClk: in std_logic; -- fastClk(50MHz) to show word, slowClk(100kHz) to change state 
            userProg: in std_logic_vector(4 downto 0);
            state: out std_logic_vector(1 downto 0);
            segdriver: out std_logic_vector(7 downto 0)
        );
    end component showword;

    signal clkin, start_sig, reset_sig, clkout: std_logic;
    signal userprogs: std_logic_vector(4 downto 0);
    signal states: std_logic_vector(1 downto 0);
    signal segdrivers: std_logic_vector(7 downto 0);
    signal segs: std_logic_vector(6 downto 0); 

begin
  
    clk_div: Clk_Divider
        port map (
            clk => clk,
            reset => reset,
            clock_out => clkout
        );
	
    show_word: showword
        port map (
            reset => reset,
            start => start,
            slowClk => clkout,
            fastClk => clk,
            userProg => userProg,
            segdriver => segdrivers,
            state => states
        );
	
    seg_decoder: seven_seg_decoder
        port map (
            binary_in => segdrivers,
            seg_out => segs
        );
  
    sevseg_driver <= segdrivers;
    sevseg_data <= segs;
    state <= states;
  
end Behavioral;
