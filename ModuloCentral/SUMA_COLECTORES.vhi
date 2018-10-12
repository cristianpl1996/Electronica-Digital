
-- VHDL Instantiation Created from source file SUMA_COLECTORES.vhd -- 00:05:49 05/24/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SUMA_COLECTORES
	PORT(
		COLECTOR_1 : IN std_logic_vector(3 downto 0);
		COLECTOR_2 : IN std_logic_vector(3 downto 0);          
		SUMA_COLECTORES : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_SUMA_COLECTORES: SUMA_COLECTORES PORT MAP(
		COLECTOR_1 => ,
		COLECTOR_2 => ,
		SUMA_COLECTORES => 
	);


