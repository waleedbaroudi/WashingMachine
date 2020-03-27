----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:49:32 12/11/2019 
-- Design Name: 
-- Module Name:    wash - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wash is
port(
clk: in std_logic;
dec: in std_logic;
rst : in std_logic; 
zero: out std_logic
);
end wash;

architecture Behavioral of wash is
signal counter: integer:=1;
signal increment: integer:=0;
begin

process
begin
if(dec = '1') then --if block to convert dec from std_logic to integer
	increment <= 1;
else
	increment <= 0;
end if;

if(rst = '1') then --rst input to reset counter and zero when the reset button is clicked.
	counter <= 1;
	zero <= '0';
elsif(rising_edge(clk)) then
	if(counter = 4) then
		zero <= '1';
		counter <= 1;
	else
		zero <= '0';
		counter <= counter + increment;
	end if;
end if;
end process;


end Behavioral;

