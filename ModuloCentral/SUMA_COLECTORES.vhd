----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:05:36 05/24/2018 
-- Design Name: 
-- Module Name:    SUMA_COLECTORES - Behavioral 
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

entity SUMA_COLECTORES is
    Port ( COLECTOR_1 : in  STD_LOGIC_VECTOR (3 downto 0);
           COLECTOR_2 : in  STD_LOGIC_VECTOR (3 downto 0);
           SUMA_COLECTORES : out  STD_LOGIC_VECTOR (3 downto 0));
end SUMA_COLECTORES;

architecture Behavioral of SUMA_COLECTORES is

SIGNAL SUMA_COLECTORES_S, COLECTOR_1_S, COLECTOR_2_S: INTEGER;

begin

COLECTOR_1_S <= conv_integer(COLECTOR_1);
COLECTOR_2_S <= conv_integer(COLECTOR_2);
SUMA_COLECTORES_S <= COLECTOR_1_S + COLECTOR_2_S;
SUMA_COLECTORES <= conv_std_logic_vector(SUMA_COLECTORES_S, SUMA_COLECTORES'length);


end Behavioral;

