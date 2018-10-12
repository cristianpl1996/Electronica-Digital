
-- VHDL Instantiation Created from source file PROCESADOR_LCD4BITS_REVB.vhd -- 16:14:21 04/09/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT PROCESADOR_LCD4BITS_REVB
	PORT(
		CLK : IN std_logic;
		VECTOR_MEM : IN std_logic_vector(11 downto 0);
		C1A : IN std_logic_vector(39 downto 0);
		C2A : IN std_logic_vector(39 downto 0);
		C3A : IN std_logic_vector(39 downto 0);
		C4A : IN std_logic_vector(39 downto 0);
		C5A : IN std_logic_vector(39 downto 0);
		C6A : IN std_logic_vector(39 downto 0);
		C7A : IN std_logic_vector(39 downto 0);
		C8A : IN std_logic_vector(39 downto 0);          
		RS : OUT std_logic;
		RW : OUT std_logic;
		ENA : OUT std_logic;
		INC_DIR : OUT std_logic_vector(0 to 10);
		BD_LCD : OUT std_logic_vector(7 downto 0);
		DATA : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_PROCESADOR_LCD4BITS_REVB: PROCESADOR_LCD4BITS_REVB PORT MAP(
		CLK => ,
		RS => ,
		RW => ,
		ENA => ,
		VECTOR_MEM => ,
		INC_DIR => ,
		C1A => ,
		C2A => ,
		C3A => ,
		C4A => ,
		C5A => ,
		C6A => ,
		C7A => ,
		C8A => ,
		BD_LCD => ,
		DATA => 
	);


