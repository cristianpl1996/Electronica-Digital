--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:59:36 02/28/2018
-- Design Name:   
-- Module Name:   C:/Users/Cristian/Documents/ISE/LatchSR_ActivoBajo/LatchSR_AB_TB.vhd
-- Project Name:  LatchSR_ActivoBajo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LatchSR_AB
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
 
ENTITY LatchSR_AB_TB IS
END LatchSR_AB_TB;
 
ARCHITECTURE behavior OF LatchSR_AB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LatchSR_AB
    PORT(
         Sn : IN  std_logic;
         Rn : IN  std_logic;
         Q : OUT  std_logic;
         Qn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Sn : std_logic := '0';
   signal Rn : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal Qn : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LatchSR_AB PORT MAP (
          Sn => Sn,
          Rn => Rn,
          Q => Q,
          Qn => Qn
        );


 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Sn <='0';
		Rn <='0';
		wait for 100 ns;
		Sn <='0' ;
		Rn <='1' ;
		wait for 100 ns;
		Sn <= '1';
		Rn <='0';
		wait for 100 ns;
		Sn <='1';
		Rn <='1';
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
