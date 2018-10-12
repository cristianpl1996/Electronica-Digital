--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:19:09 03/14/2018
-- Design Name:   
-- Module Name:   C:/Users/Cristian/Documents/ISE/Sensor/Sensor_TB.vhd
-- Project Name:  Sensor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sensor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Sensor_TB IS
END Sensor_TB;
 
ARCHITECTURE behavior OF Sensor_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sensor
    PORT(
         Vin : IN  std_logic;
         Vout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Vin : std_logic := '0';

 	--Outputs
   signal Vout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sensor PORT MAP (
          Vin => Vin,
          Vout => Vout
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Vin <= '0';
      wait for 100 ns;
		Vin <= '1';
      wait for 100 ns;			

     

      -- insert stimulus here 

      wait;
   end process;

END;
