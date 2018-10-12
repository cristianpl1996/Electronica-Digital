
-- VHDL Instantiation Created from source file RS232.vhd -- 08:25:17 04/28/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RS232
	PORT(
		CLK : IN std_logic;
		RX : IN std_logic;
		TX_INI : IN std_logic;
		DATAIN : IN std_logic_vector(7 downto 0);          
		TX_FIN : OUT std_logic;
		TX : OUT std_logic;
		RX_IN : OUT std_logic;
		DOUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_RS232: RS232 PORT MAP(
		CLK => ,
		RX => ,
		TX_INI => ,
		TX_FIN => ,
		TX => ,
		RX_IN => ,
		DATAIN => ,
		DOUT => 
	);


