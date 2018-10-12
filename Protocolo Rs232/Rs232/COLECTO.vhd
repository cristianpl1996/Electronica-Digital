----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:47:00 04/14/2018 
-- Design Name: 
-- Module Name:    COLECTO - Behavioral 
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COLECTO is
    Port ( VIN : in  STD_LOGIC_VECTOR (11 downto 0);
			  ESPACIOS : out STD_LOGIC_VECTOR (3 downto 0));
end COLECTO;

architecture Behavioral of COLECTO is

SIGNAL ESPACIOS_S, VIN0, VIN1, VIN2 , VIN3, VIN4, VIN5, VIN6, VIN7, VIN8, VIN9, VIN10, VIN11: INTEGER := 1;

begin

VIN0 <= conv_integer(VIN(0));
VIN1 <= conv_integer(VIN(1));
VIN2 <= conv_integer(VIN(2));
VIN3 <= conv_integer(VIN(3));
VIN4 <= conv_integer(VIN(4));
VIN5 <= conv_integer(VIN(5));
VIN6 <= conv_integer(VIN(6));
VIN7 <= conv_integer(VIN(7));
VIN8 <= conv_integer(VIN(8));
VIN9 <= conv_integer(VIN(9));
VIN10 <= conv_integer(VIN(10));
VIN11 <= conv_integer(VIN(11));

ESPACIOS_S <= VIN0 + VIN1 + VIN2 + VIN3 + VIN4 + VIN5 + VIN6 + VIN7 + VIN8 + VIN9 + VIN10 + VIN11;
ESPACIOS <= conv_std_logic_vector(ESPACIOS_S, ESPACIOS'length);
--ESPACIOS <= ('0'&VIN(0)) + ('0'&VIN(1)) + ('0'&VIN(2)) + ('0'&VIN(3)) + ('0'&VIN(4)) + ('0'&VIN(5)) + ('0'&VIN(6)) + ('0'&VIN(7)) + ('0'&VIN(8)) + ('0'&VIN(9)) + ('0'&VIN(10) + ('0'&VIN(11)));

end Behavioral;