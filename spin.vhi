
-- VHDL Instantiation Created from source file spin.vhd -- 20:39:11 12/11/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT spin
	PORT(
		clk : IN std_logic;
		dec : IN std_logic;          
		zero : OUT std_logic
		);
	END COMPONENT;

	Inst_spin: spin PORT MAP(
		clk => ,
		dec => ,
		zero => 
	);


