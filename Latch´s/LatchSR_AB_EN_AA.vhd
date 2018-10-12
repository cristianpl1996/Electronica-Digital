----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:44:36 02/28/2018 
-- Design Name: 
-- Module Name:    LatchSR_AB_EN_AA - Behavioral 
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

entity LatchSR_AB_EN_AA is
    Port ( Rn : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Sn : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Qn : out  STD_LOGIC);
end LatchSR_AB_EN_AA;

architecture Behavioral of LatchSR_AB_EN_AA is

signal Q_aux : STD_LOGIC := '0';
signal Qn_aux : STD_LOGIC := '0';
signal Rn_aux : STD_LOGIC := '0';
signal Sn_aux : STD_LOGIC := '0';

begin

Q <= Q_aux;
Qn <= Qn_aux;

Rn_aux <= Rn nor (not EN);
Sn_aux <= Sn nor (not EN);

Q_aux <= Rn_aux nor Qn_aux ;
Qn_aux <= Sn_aux nor Q_aux ;


end Behavioral;

