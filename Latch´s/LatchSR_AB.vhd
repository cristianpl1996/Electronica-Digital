----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:29 02/28/2018 
-- Design Name: 
-- Module Name:    LatchSR_AB - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LatchSR_AB is
    Port ( Sn : in  STD_LOGIC;
           Rn : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Qn : out  STD_LOGIC);
end LatchSR_AB;

architecture Behavioral of LatchSR_AB is

signal Q_aux : STD_LOGIC := '0';
signal Qn_aux : STD_LOGIC := '0';


begin

Q <= Q_aux;
Qn <= Qn_aux;

Q_aux <= Sn nand Qn_aux;
Qn_aux <= Rn nand Q_aux;

end Behavioral;

