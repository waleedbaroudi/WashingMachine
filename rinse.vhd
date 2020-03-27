----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:49:57 12/11/2019 
-- Design Name: 
-- Module Name:    rinse - Behavioral 
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

entity rinse is
port(
clk: in std_logic;
dec: in std_logic;
rst : in std_logic; 
zero: out std_logic
);
end rinse;

architecture Behavioral of rinse is

signal counter: integer:=1;
signal decrement: integer:=0;

begin
process
begin
if(dec = '1') then
	decrement <= 1;
else
	decrement <= 0;
end if;
if(rst = '1') then
	counter <= 1;
	zero <= '0';
elsif(rising_edge(clk)) then
	if(counter = 2) then
		zero <= '1';
		counter <= 1;
	else
		zero <= '0';
		counter <= counter + decrement;
	end if;
end if;
end process;


end Behavioral;

