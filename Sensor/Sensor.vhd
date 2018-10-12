----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:33 02/28/2018 
-- Design Name: 
-- Module Name:    Sensor - Behavioral 
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

entity Sensor is
    Port ( Vin : in  STD_LOGIC;
           Vout : out  STD_LOGIC);
end Sensor;

architecture Behavioral of Sensor is

begin
	PROCESS(Vin) 
		BEGIN
			IF (Vin = '1') THEN
				  Vout <= '0';
			ELSE
				  Vout <= '1';
			END IF;      
	END PROCESS;
end Behavioral;

