library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CARACTERES_ESPECIALES_REVC is

PORT( C1,C2,C3,C4,C5,C6,C7,C8 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
		CLK : IN STD_LOGIC
		);


end CARACTERES_ESPECIALES_REVC;

architecture Behavioral of CARACTERES_ESPECIALES_REVC is

SIGNAL CHAR_1 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_2 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_3 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_4 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_5 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_6 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_7 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
SIGNAL CHAR_8 : STD_LOGIC_VECTOR(39 DOWNTO 0) := X"0000000000";
 
begin

------------------------------------------------------------------
---------------CARACTERES A DIBUJAR-------------------------------

CHAR_1 <=

 "00000"&
 "00000"&	
 "00000"&
 "00000"&
 "00000"&
 "10000"&
 "10000"&
 "11100";
 
 CHAR_2 <=
 
 "00011"&
 "00101"&	
 "00111"&
 "00111"&
 "00111"&
 "00111"&
 "01111"&
 "11111";
 
 CHAR_3 <=
 
 "11110"&
 "11111"&	
 "11111"&
 "11111"&
 "10000"&
 "11110"&
 "10000"&
 "10000";
 
 CHAR_4 <=
 
 "11101"&
 "11111"&	
 "01111"&
 "00111"&
 "00011"&
 "00000"&
 "00000"&
 "00000";
 
 CHAR_5 <=
 
 "11111"&
 "11111"&	
 "11111"&
 "11111"&
 "11011"&
 "10010"&
 "10010"&
 "11011";
 
 CHAR_6 <=
 
 "11100"&
 "10100"&	
 "10000"&
 "10000"&
 "00000"&
 "00000"&
 "00000"&
 "00000";
 
 CHAR_7 <=
 
 "11111"&
 "11111"&	
 "11111"&
 "11111"&
 "11011"&
 "10010"&
 "10011"&
 "11000";
 
 CHAR_8 <=
 
 "11111"&
 "11111"&	
 "11111"&
 "11111"&
 "11011"&
 "10010"&
 "11010"&
 "00011";
 
------------------------------------------------------------------
------------------------------------------------------------------

C1 <= CHAR_1;
C2 <= CHAR_2;
C3 <= CHAR_3;
C4 <= CHAR_4;
C5 <= CHAR_5;
C6 <= CHAR_6;
C7 <= CHAR_7;
C8 <= CHAR_8;

end Behavioral;