----------------------------------------------------------------------------------
-- COPYRIGHT 2015 Jesús Eduardo Méndez Rosales
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--
--							LIBRERÍA LCD
--
-- Descripción: Con ésta librería podrás implementar códigos para una LCD 16x2 de manera
-- fácil y rápida, con todas las ventajas de utilizar una FPGA.
--
-- Características:
-- 
--	Los comandos que puedes utilizar son los siguientes:
--
-- LCD_INI() -> Inicializa la lcd.
--		 			 NOTA: Dentro de los paréntesis poner un vector de 2 bits para encender o apagar
--					 		 el cursor y activar o desactivar el parpadeo.
--
--		"1x" -- Cursor ON
--		"0x" -- Cursor OFF
--		"x1" -- Parpadeo ON
--		"x0" -- Parpadeo OFF
--
--   Por ejemplo: LCD_INI("10") -- Inicializar LCD con cursor encendido y sin parpadeo 
--	
--			
-- CHAR() -> Manda una letra mayúscula o minúscula
--
--				 IMPORTANTE: 1) Debido a que VHDL no es sensible a mayúsculas y minúsculas, si se quiere
--								    escribir una letra mayúscula se debe escribir una "M" antes de la letra.
--								 2) Si se quiere escribir la letra "S" mayúscula, se declara "MAS"
--											
-- 	Por ejemplo: CHAR(A)  -- Escribe en la LCD la letra "a"
--						 CHAR(MA) -- Escribe en la LCD la letra "A"	
--						 CHAR(S)	 -- Escribe en la LCD la letra "s"
--						 CHAR(MAS)	 -- Escribe en la LCD la letra "S"	
--	
--
-- POS() -> Escribir en la posición que se indique.
--				NOTA: Dentro de los paréntesis se dene poner la posición de la LCD a la que se quiere ir, empezando
--						por el renglón seguido de la posición vertical, ambos números separados por una coma.
--		
--		Por ejemplo: POS(1,2) -- Manda cursor al renglón 1, poscición 2
--						 POS(2,4) -- Manda cursor al renglón 2, poscición 4		
--
--
-- CHAR_ASCII() -> Escribe un caracter a partir de su código en ASCII
--						 NOTA: Dentro de los parentesis escribir x"(número hex.)"
--
--		Por ejemplo: CHAR_ASCII(x"40") -- Escribe en la LCD el caracter "@"
--
--
-- CODIGO_FIN() -> Finaliza el código. 
--						 NOTA: Dentro de los paréntesis poner cualquier número: 1,2,3,4...,8,9.
--
--
-- BUCLE_INI() -> Indica el inicio de un bucle. 
--						NOTA: Dentro de los paréntesis poner cualquier número: 1,2,3,4...,8,9.
--
--
-- BUCLE_FIN() -> Indica el final del bucle.
--						NOTA: Dentro de los paréntesis poner cualquier número: 1,2,3,4...,8,9.
--
--
-- INT_NUM() -> Escribe en la LCD un número entero.
--					 NOTA: Dentro de los paréntesis poner sólo un número que vaya del 0 al 9,
--						    si se quiere escribir otro número entero se tiene que volver
--							 a llamar la función
--
--
-- CREAR_CHAR() -> Función que crea el caracter diseñado previamente en "CARACTERES_ESPECIALES.vhd"
--                 NOTA: Dentro de los paréntesis poner el nombre del caracter dibujado (CHAR1,CHAR2,CHAR3,..,CHAR8)
--								 
--
-- CHAR_CREADO() -> Escribe en la LCD el caracter creado por medio de la función "CREAR_CHAR()"
--						  NOTA: Dentro de los paréntesis poner el nombre del caracter creado.
--
--     Por ejemplo: 
--
--				Dentro de CARACTERES_ESPECIALES.vhd se dibujan los caracteres personalizados utilizando los vectores 
--				"CHAR_1", "CHAR_2","CHAR_3",...,"CHAR_7","CHAR_8"
--
--								 1 => [#] - Se activa el pixel de la matríz.
--                       0 => [ ] - Se desactiva el pixel de la matriz.
--
-- 			Si se quiere crear el				Entonces CHAR_1 queda de la siguiente
--				siguiente caracter:					manera:
--												
--				  1  2  3  4  5						CHAR_1 <=
--  		  1 [ ][ ][ ][ ][ ]							"00000"&			
-- 		  2 [ ][ ][ ][ ][ ]							"00000"&			  
-- 		  3 [ ][#][ ][#][ ]							"01010"&   		  
-- 		  4 [ ][ ][ ][ ][ ]		=====>			"00000"&			   
-- 		  5 [#][ ][ ][ ][#]							"10001"&          
-- 		  6 [ ][#][#][#][ ]							"01110"&			  
-- 		  7 [ ][ ][ ][ ][ ]							"00000"&			  
-- 		  8 [ ][ ][ ][ ][ ]							"00000";			
--
--		
--			Como el caracter se creó en el vector "CHAR_1",entonces se escribe en las funciónes como "CHAR1"
--			
--			CREAR_CHAR(CHAR1)  -- Crea el caracter personalizado (CHAR1)
--			CHAR_CREADO(CHAR1) -- Muestra en la LCD el caracter creado (CHAR1)		
--
-- 
--
-- LIMPIAR_PANTALLA() -> Manda a limpiar la LCD.
--								 NOTA: Ésta función se activa poniendo dentro de los paréntesis
--										 un '1' y se desactiva con un '0'. 
--
--		Por ejemplo: LIMPIAR_PANTALLA('1') -- Limpiar pantalla está activado.
--						 LIMPIAR_PANTALLA('0') -- Limpiar pantalla está desactivado.
--
--
--	Con los puertos de entrada "CORD" y "CORI" se hacen corrimientos a la derecha y a la
--	izquierda respectivamente. NOTA: La velocidad del corrimiento se puede cambiar 
-- modificando la variable "DELAY_COR".
--
-- Algunas funciónes generan un vector ("BLCD") cuando se terminó de ejecutar dicha función y
--	que puede ser utilizado como una bandera, el vector solo dura un ciclo de instruccion.
--	   
--		LCD_INI() ---------- BLCD <= x"01"
--		CHAR() ------------- BLCD <= x"02"
--		POS() -------------- BLCD <= x"03"
--	   CHAR_ASCII() ------- BLCD <= x"05"
-- 	INT_NUM() ---------- BLCD <= x"05"
--	   BUCLE_INI() -------- BLCD <= x"06"
--		BUCLE_FIN() -------- BLCD <= x"07"
--		LIMPIAR_PANTALLA() - BLCD <= x"08"
--	   CREAR_CHAR() ------- BLCD <= x"09"
--	 	CHAR_CREADO() ------ BLCD <= x"0A"
--
--
--		¡IMPORTANTE!
--
--		Cada función se acompaña con " INSTRUCCION(NUM) <= (FUNCIÓN) " como lo muestra el siguiente código
-- 	demostrativo.
--
--
--                CÓDIGO DEMOSTRATIVO
--
-- INSTRUCCION(0) <= LCD_INI("11"); --INICIALIZAMOS LCD, CURSOR A HOME, CURSOR ON, PARPADEO ON.
-- INSTRUCCION(1) <= POS(1,1);--------EMPEZAMOS A ESCRIBIR EN LA LINEA 1, POSICIÓN 1
-- INSTRUCCION(2) <= CHAR(MH);--------ESCRIBIMOS EN LA LCD LA LETRA "h" MAYUSCULA
-- INSTRUCCION(3) <= CHAR(O);			
-- INSTRUCCION(4) <= CHAR(L);
-- INSTRUCCION(5) <= CHAR(A);
-- INSTRUCCION(6) <= CHAR_ASCII(x"21");--ESCRIBIMOS EL CARACTER "!"
-- INSTRUCCION(7) <= CODIGO_FIN(1);-----------FINALIZAMOS EL CODIGO
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
USE WORK.COMANDOS_LCD_REVC.ALL;
USE WORK.OP_DIVISION.ALL;

entity LIB_LCD_INTESC_REVC is
	PORT( CLK: IN STD_LOGIC;
	-------------PUERTOS DEL PROTOCOLO RS232 (NO BORRAR)------------
			RX : IN STD_LOGIC;									  
			TX : OUT STD_LOGIC;	
	-------------PUERTOS DEL SENSOR (NO BORRAR)------------
			VIN: IN STD_LOGIC_VECTOR(11 DOWNTO 0);     
	-------------PUERTOS DE LA LCD (NO BORRAR)-------------
			RS : OUT STD_LOGIC;									  
			RW : OUT STD_LOGIC;									  
			ENA : OUT STD_LOGIC;									  
			CORD : IN STD_LOGIC;									  
			CORI : IN STD_LOGIC;									  
			DATA_LCD: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);     
			BLCD :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0)    
	-------------------------------------------------------
		  
	-------------------------------------------------------
	--------------ABAJO ESCRIBE TUS PUERTOS----------------
		
	-------------------------------------------------------
		  );
end LIB_LCD_INTESC_REVC;

architecture Behavioral of LIB_LCD_INTESC_REVC is

-----------------------------------------------------------------
---------------SEÑALES DE LA LCD (NO BORRAR)---------------------
TYPE RAM IS ARRAY (0 TO  60) OF STD_LOGIC_VECTOR(8 DOWNTO 0);  
																					
SIGNAL INSTRUCCION : RAM;													
																					
COMPONENT PROCESADOR_LCD_REVC 																														
	PORT(
			CLK : IN STD_LOGIC;													
			VECTOR_MEM : IN STD_LOGIC_VECTOR(8 DOWNTO 0);					
			INC_DIR : OUT INTEGER RANGE 0 TO 1024;							
			CORD : IN STD_LOGIC;													
			CORI : IN STD_LOGIC;													
			RS : OUT STD_LOGIC;													
			RW : OUT STD_LOGIC;													
			DELAY_COR : IN INTEGER RANGE 0 TO 1000;							
			BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         
			ENA  : OUT STD_LOGIC;													
			C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       
			C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       
			DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)							
			);																																							
	END COMPONENT PROCESADOR_LCD_REVC;										
																					
COMPONENT CARACTERES_ESPECIALES_REVC 																														
	PORT( 
		C1,C2,C3,C4:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				
		C5,C6,C7,C8:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				
		CLK : IN STD_LOGIC													
		);																																								
	END COMPONENT CARACTERES_ESPECIALES_REVC;

COMPONENT COLECTO
	PORT(
		VIN : IN std_logic_vector(11 downto 0);          
		ESPACIOS : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

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
																					
CONSTANT CHAR1 : INTEGER := 1;											
CONSTANT CHAR2 : INTEGER := 2;											
CONSTANT CHAR3 : INTEGER := 3;											
CONSTANT CHAR4 : INTEGER := 4;											
CONSTANT CHAR5 : INTEGER := 5;											
CONSTANT CHAR6 : INTEGER := 6;											
CONSTANT CHAR7 : INTEGER := 7;											
CONSTANT CHAR8 : INTEGER := 8;											
																																										
SIGNAL DIR : INTEGER RANGE 0 TO 1024 := 0;							
SIGNAL VECTOR_MEM_S : STD_LOGIC_VECTOR(8 DOWNTO 0);				
SIGNAL RS_S, RW_S, E_S : STD_LOGIC;										
SIGNAL DATA_S : STD_LOGIC_VECTOR(7 DOWNTO 0);						
SIGNAL DIR_S : INTEGER RANGE 0 TO 1024;								
SIGNAL DELAY_COR : INTEGER RANGE 0 TO 1000;							
SIGNAL C1S,C2S,C3S,C4S : STD_LOGIC_VECTOR(39 DOWNTO 0);	      
SIGNAL C5S,C6S,C7S,C8S : STD_LOGIC_VECTOR(39 DOWNTO 0);  	   

---------------------------------------------------------
--------------AGREGA TUS SEÑALES AQUÍ--------------------

SIGNAL ESPACIOS_S : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL TX_INI_S : std_logic;
SIGNAL DATAIN_S : std_logic_vector(7 downto 0);          
SIGNAL TX_FIN_S : std_logic;
SIGNAL RX_IN_S : std_logic;
SIGNAL DOUT_S : std_logic_vector(7 downto 0);

---------------------------------------------------------

begin

-----------------------------------------------------------
------------COMPONENTES PARA PROTOCOLO RS232 (NO BORRAR)---------------
Inst_RS232: RS232 PORT MAP(
		CLK => CLK ,
		RX => RX,
		TX_INI => TX_INI_S ,
		TX_FIN => TX_FIN_S,
		TX => TX,
		RX_IN => RX_IN_S,
		DATAIN => DATAIN_S,
		DOUT => DOUT_S
	);
------------COMPONENTES PARA COLECTOR (NO BORRAR)---------------
Inst_COLECTO: COLECTO PORT MAP(
		VIN => VIN,
		ESPACIOS => ESPACIOS_S
	);	
-----------------------------------------------------------
------------COMPONENTES PARA LCD (NO BORRAR)---------------
Inst_PROCESADOR_LCD_REVC : PROCESADOR_LCD_REVC PORT MAP(	
		CLK  => CLK,				
		VECTOR_MEM => VECTOR_MEM_S,	
		RS  => RS_S,						
		RW  => RW_S,						
		ENA => E_S,						
		INC_DIR => DIR_S,				
		DELAY_COR => DELAY_COR,		
		BD_LCD => BLCD,					
		CORD => CORD,						
		CORI => CORI,						
		C1A =>C1S,  					   
		C2A =>C2S,							
		C3A =>C3S,							
		C4A =>C4S,							
		C5A =>C5S,							
		C6A =>C6S,							
		C7A =>C7S,							
		C8A =>C8S,							
		DATA  => DATA_S 
	);				
																			
Inst_CARACTERES_ESPECIALES_REVC : CARACTERES_ESPECIALES_REVC PORT MAP(	
		C1 =>C1S,				
		C2 =>C2S,							
		C3 =>C3S,							
		C4 =>C4S,							
		C5 =>C5S,							
		C6 =>C6S,							
		C7 =>C7S,						   
		C8 =>C8S,							
		CLK => CLK
	);										
																			
DIR <= DIR_S;															
VECTOR_MEM_S <= INSTRUCCION(DIR);																											
RS <= RS_S;																
RW <= RW_S;																
ENA <= E_S;																
DATA_LCD <= DATA_S;													
DELAY_COR <= 500; --Modificar esta variable para la velocidad del corrimiento.
-------------------------------------------------------------------
-----------------ABAJO ESCRIBE TU CÓDIGO EN VHDL-------------------

-----------------------------------------------------------------------------------------
-------------------------ABAJO ESCRIBE TU CÓDIGO PARA LA LCD-----------------------------

INSTRUCCION(0) <= LCD_INI("00"); --INICIALIZAMOS LCD, CURSOR A HOME, CURSOR ON, PARPADEO ON.
INSTRUCCION(1) <= POS(1,1);--------EMPEZAMOS A ESCRIBIR EN LA LINEA 1, POSICIÓN 1
INSTRUCCION(2) <= CHAR(ME);--------ESCRIBIMOS EN LA LCD LA LETRA "e" MAYUSCULA
INSTRUCCION(3) <= CHAR(S);--------ESCRIBIMOS EN LA LCD LA LETRA "s" MINUSCULA			
INSTRUCCION(4) <= CHAR(P);
INSTRUCCION(5) <= CHAR(A);
INSTRUCCION(6) <= CHAR(C);
INSTRUCCION(7) <= CHAR(I);
INSTRUCCION(8) <= CHAR(O);
INSTRUCCION(9) <= CHAR(S);
INSTRUCCION(10) <= CHAR_ASCII(x"3A");--ESCRIBIMOS EL CARACTER ":"
INSTRUCCION(11) <= BUCLE_INI(1);
INSTRUCCION(12) <= POS(2,2);
INSTRUCCION(13) <= INT_NUM(DIV(conv_integer(ESPACIOS_S),10));
INSTRUCCION(14) <= INT_NUM(MODULO(conv_integer(ESPACIOS_S),10));
INSTRUCCION(15) <= BUCLE_FIN(1);
INSTRUCCION(16) <= CODIGO_FIN(1);-----------FINALIZAMOS EL CODIGO
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
end Behavioral;

