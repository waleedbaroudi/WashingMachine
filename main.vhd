----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:50 12/11/2019 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
port(
clk: in std_logic;
start: in std_logic;
reset: in std_logic;
zero_led: out std_logic;
dec_led: out std_logic;
state_indicator: out std_logic_vector(3 downto 0);
selected: out std_logic_vector(1 downto 0)
);
end main;

architecture Behavioral of main is

	COMPONENT clk_divider
	PORT(
		mclk : IN std_logic;          
		sclk : OUT std_logic
		);
	END COMPONENT;
	
		COMPONENT wash
	PORT(
		clk : IN std_logic;
		dec : IN std_logic; 
		rst : IN std_logic; 
		zero : OUT std_logic
		);
	END COMPONENT;

	COMPONENT spin
	PORT(
		clk : IN std_logic;
		dec : IN std_logic;
		rst : IN std_logic; 
		zero : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT rinse
	PORT(
		clk : IN std_logic;
		dec : IN std_logic;           
		rst : IN std_logic;           
		zero : OUT std_logic
		);
	END COMPONENT;


	
-------- SIGNALS ---------
signal slow_clock: std_logic;

signal mode_select: std_logic_vector(1 downto 0):="11";

signal wash_dec: std_logic;
signal wash_zero: std_logic:='0';

signal spin_dec: std_logic;
signal spin_zero: std_logic:='0';

signal rinse_dec: std_logic;
signal rinse_zero: std_logic:='0';

signal finished: std_logic:='0';

signal rst_counter: std_logic;

begin

process
begin
if(reset='1') then
	mode_select <= "11";
	finished <='0';
	rst_counter <= '1';
elsif(start='1') then
	rst_counter <= '0';
	mode_select <= "00";
else
	if(mode_select = "00") then
		wash_dec <= '1';
		spin_dec <= '0';
		rinse_dec <= '0';
		dec_led <= wash_dec;
		zero_led <= wash_zero;
		state_indicator <= "0001";
	end if;
	if(mode_select = "01") then
		wash_dec <= '0';
		spin_dec <= '1';
		rinse_dec <= '0';
		dec_led <= spin_dec;
		zero_led <= spin_zero;
		state_indicator <= "0010";
	end if;
	if(mode_select = "10") then
		wash_dec <= '0';
		spin_dec <= '0';
		rinse_dec <= '1';
		dec_led <= '1';
		zero_led <= rinse_zero;
		state_indicator <= "0100";
	end if;

	if(mode_select = "11") then
		wash_dec <= '0';
		spin_dec <= '0';
		rinse_dec <= '0';
		dec_led <= '0';
		zero_led <= finished;
		state_indicator <= "1000";
	end if;

	if(wash_zero = '1') then
		mode_select <= "01";
	end if;

	if(spin_zero = '1') then
		mode_select <= "10";
	end if;

	if(rinse_zero = '1') then
		finished <='1';
		mode_select <= "11";
	end if;
end if;
end process;

selected <= mode_select;

---------------------------------------------INSTANCES------------------------------------------------
Inst_clk_divider: clk_divider PORT MAP(
		mclk => clk,
		sclk => slow_clock
	);

Inst_wash: wash PORT MAP(
		clk => slow_clock,
		dec => wash_dec,
		rst => rst_counter,
		zero => wash_zero
	);

Inst_spin: spin PORT MAP(
		clk => slow_clock,
		dec => spin_dec,
		rst => rst_counter,
		zero => spin_zero
	);
	
Inst_rinse: rinse PORT MAP(
		clk => slow_clock,
		dec => rinse_dec,
		rst => rst_counter,
		zero => rinse_zero
	);



end Behavioral;

