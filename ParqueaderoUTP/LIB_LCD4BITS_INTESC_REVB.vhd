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
--							LIBRERÍA LCD (4 BITS)
--
-- Descripción: Con ésta librería podrás implementar códigos para una LCD 16x2 de 4 BITS de manera
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
--						 NOTA: Dentro de los parentesis escribir x"(número hex.)". También se pueden usar varibles de
--								 tipo STD_LOGIC_VECTOR.
--
--		Por ejemplo: CHAR_ASCII(x"40") -- Escribe en la LCD el caracter "@"
--
--											Ó
--
--						 SIGNAL VAL_ASCCI : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"55";
--						 CHAR_ASCII(VAL_ASCII) -- Escribe en la LCD el valor de VAL_ASCCI, en este caso el x"55" que es el
--														  caracter "U"
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
--							 a llamar la función. También podemos utilizar variables de tipo entero
--							 con un rango de 0 a 9.
--
--		Por ejemplo: INT_NUM(6) -- Escribe en la LCD el número 1.
--									
--										Ó
--
--						 SIGNAL VAR1 : INTEGER RANGE 0 TO 9 := 3;
--                 INT_NUM(VAR1) -- Escribe el la LCD el valor de VAR1, en este caso el 3
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
use WORK.COMANDOS_LCD4BITS_REVB.all;
use WORK.OP_DIVISION.all;

entity LIB_LCD4BITS_INTESC_REVB is
	PORT(	CLK: IN STD_LOGIC;
	-------------PUERTOS DEL PROTOCOLO RS232 (NO BORRAR)---
			RX : IN STD_LOGIC;									  
			TX : OUT STD_LOGIC;
			RX_PRINCIPAL : IN STD_LOGIC;									  
			TX_PRINCIPAL : OUT STD_LOGIC;	
	----------------PUERTOS DEL SENSOR (NO BORRAR)---------
			VIN: IN STD_LOGIC_VECTOR(5 DOWNTO 0); 
	-------------PUERTOS DE LA LCD (NO BORRAR)-------------
			RS : OUT STD_LOGIC;									   
			RW : OUT STD_LOGIC;									   
			ENA : OUT STD_LOGIC;									   
			DATA_LCD: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)      
		 --BLCD :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0);       -- 	DECLARAR LA BANDERA COMO PUERTO SI SE UTILIZA  
																		   --    LA LIBRERIA COMO COMPONENTE 
	--------------------------------------------------------
		  
	--------------------------------------------------------
	---------------AQUÍ ESCRIBE TUS PUERTOS-----------------
		
	--------------------------------------------------------
	);
end LIB_LCD4BITS_INTESC_REVB;

architecture Behavioral of LIB_LCD4BITS_INTESC_REVB is
-------------------------COMPONENTES DE LCD--------------------------
---------------------------(NO MODIFICAR)----------------------------
TYPE RAM IS ARRAY (0 TO  60) OF STD_LOGIC_VECTOR(11 DOWNTO 0);  	 
																						 
SIGNAL INSTRUCCION : RAM;													 	 
																					
COMPONENT PROCESADOR_LCD4BITS_REVB 					   		 	       																					 
	PORT(
		CLK : IN STD_LOGIC;													 
		RS : OUT STD_LOGIC;													 
		RW : OUT STD_LOGIC;													 
		ENA : OUT STD_LOGIC;													 
		VECTOR_MEM : IN STD_LOGIC_VECTOR(11 DOWNTO 0);				 
		INC_DIR : OUT INTEGER RANGE 0 TO 1024;							 
		C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);			 
		C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);			 
		BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			          
		DATA : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)			 
		);																			 																						 
END COMPONENT PROCESADOR_LCD4BITS_REVB;								 	 
																						 
COMPONENT CARACTERES_ESPECIALES_LCD4BITS_REVB 						 																					 
	PORT( 
		C1,C2,C3,C4,C5,C6,C7,C8 : OUT STD_LOGIC_VECTOR(39 DOWNTO 0); 
		CLK : IN STD_LOGIC														 
		);																				 																					 																						 --
END COMPONENT CARACTERES_ESPECIALES_LCD4BITS_REVB;

COMPONENT COLECTO
	PORT(
		VIN : IN std_logic_vector(5 downto 0);          
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

COMPONENT SUMA_COLECTORES
	PORT(
		COLECTOR_1 : IN std_logic_vector(3 downto 0);
		COLECTOR_2 : IN std_logic_vector(3 downto 0);          
		SUMA_COLECTORES : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;	
																						 
SIGNAL C1S,C2S,C3S,C4S : STD_LOGIC_VECTOR(39 DOWNTO 0);	      	 
SIGNAL C5S,C6S,C7S,C8S : STD_LOGIC_VECTOR(39 DOWNTO 0);  	   	 
SIGNAL VECTOR_MEM_S : STD_LOGIC_VECTOR(11 DOWNTO 0);					 
SIGNAL DIR : INTEGER RANGE 0 TO 1024:=0;									 
SIGNAL BLCD : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- 	DECLARAR LA BANDERA COMO SEÑAL SI SE UTILIZA 
											            -- 	LA LIBRERIA COMO TOP  
														  
--------------AGREGA TUS SEÑALES AQUÍ--------------------------
SIGNAL ESPACIOS_S : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL TX_INI_S, TX_INI_S_PRINCIPAL : std_logic;
SIGNAL DATAIN_S, DATAIN_S_PRINCIPAL : std_logic_vector(7 downto 0);          
SIGNAL TX_FIN_S, TX_FIN_S_PRINCIPAL : std_logic;
SIGNAL RX_IN_S, RX_IN_S_PRINCIPAL : std_logic;
SIGNAL DOUT_S, DOUT_S_PRINCIPAL : std_logic_vector(7 downto 0);
SIGNAL DATO, DATO_PRINCIPAL : std_logic_vector(7 downto 0);

----------------------------------------------------------------
begin

------------COMPONENTES PARA PROTOCOLO RS232 (NO BORRAR)--------
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

Inst_RS232_DTE: RS232 PORT MAP(
		CLK => CLK ,
		RX => RX_PRINCIPAL,
		TX_INI => TX_INI_S_PRINCIPAL ,
		TX_FIN => TX_FIN_S_PRINCIPAL,
		TX => TX_PRINCIPAL,
		RX_IN => RX_IN_S_PRINCIPAL,
		DATAIN => DATAIN_S_PRINCIPAL,
		DOUT => DOUT_S_PRINCIPAL
	);	
------------COMPONENTES PARA COLECTOR (NO BORRAR)---------------
Inst_COLECTO: COLECTO PORT MAP(
		VIN => VIN,
		ESPACIOS => ESPACIOS_S
	);	

------------COMPONENTES PARA LCD (NO BORRAR)--------------------
																			
Inst_PROCESADOR_LCD4BITS_REVB: PROCESADOR_LCD4BITS_REVB PORT MAP(							
		CLK => CLK,						
		RS  => RS,							
		RW  => RW,							
		ENA => ENA,						
		VECTOR_MEM => VECTOR_MEM_S,	
		INC_DIR => DIR,					
		BD_LCD => BLCD,					
		C1A =>C1S,  					   
		C2A =>C2S,							
		C3A =>C3S,							
		C4A =>C4S,							
		C5A =>C5S,							
		C6A =>C6S,							
		C7A =>C7S,							
		C8A =>C8S,							
		DATA => DATA_LCD 
	);				
																			
Inst_CARACTERES_ESPECIALES_LCD4BITS_REVB : CARACTERES_ESPECIALES_LCD4BITS_REVB PORT MAP(			
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

------------COMPONENTES PARA SUMA COLECTORES (NO BORRAR)---------------

Inst_SUMA_COLECTORES: SUMA_COLECTORES PORT MAP(
		COLECTOR_1 => ESPACIOS_S,
		COLECTOR_2 => DATO(3 DOWNTO 0),
		SUMA_COLECTORES => DATO_PRINCIPAL(3 DOWNTO 0)
	);	
																																			
VECTOR_MEM_S <= INSTRUCCION(DIR);

PROCESS(CLK)  -- CASO PARA TRANSMISION DE DATOS
	BEGIN 
		 IF RISING_EDGE(CLK) THEN
			DATAIN_S(3 DOWNTO 0) <= ESPACIOS_S;
			TX_INI_S <= '1';  					
			IF TX_FIN_S = '1' THEN
				TX_INI_S <= '0'; 
			END IF;					
		END IF;
END PROCESS;

PROCESS(CLK) -- CASO PARA RECEPCION DE DATOS
	BEGIN 
		 IF RISING_EDGE(CLK) THEN			
			IF RX_IN_S = '1' THEN 
				DATO <= DOUT_S;
			END IF;		
		END IF;
END PROCESS;

PROCESS(CLK)  -- CASO PARA TRANSMISION DE DATOS CON EL DTE
	BEGIN 
		 IF RISING_EDGE(CLK) THEN
			DATAIN_S_PRINCIPAL <= DATO_PRINCIPAL;
			TX_INI_S_PRINCIPAL <= '1';  					
			IF TX_FIN_S_PRINCIPAL = '1' THEN
				TX_INI_S_PRINCIPAL <= '0'; 
			END IF;					
		END IF;
END PROCESS;			
		 																																																								
------------------AQUÍ ESCRIBE TU CÓDIGO PARA LA LCD------------

INSTRUCCION(0) <= LCD_INI("00");
INSTRUCCION(1) <= POS(1,1);
INSTRUCCION(2) <= CHAR(ML);
INSTRUCCION(3) <= CHAR(E);		
INSTRUCCION(4) <= CHAR(F);
INSTRUCCION(5) <= CHAR(T);
INSTRUCCION(6) <= POS(1,7);
INSTRUCCION(7) <= CHAR(MR);
INSTRUCCION(8) <= CHAR(I);
INSTRUCCION(9) <= CHAR(G);
INSTRUCCION(10) <= CHAR(H);
INSTRUCCION(11) <= CHAR(T);
INSTRUCCION(12) <= BUCLE_INI(1);
INSTRUCCION(13) <= POS(2,2);
INSTRUCCION(14) <= INT_NUM(DIV(conv_integer(ESPACIOS_S),10));
INSTRUCCION(15) <= INT_NUM(MODULO(conv_integer(ESPACIOS_S),10));
INSTRUCCION(16) <= POS(2,8);
INSTRUCCION(17) <= INT_NUM(DIV(conv_integer(DATO),10));
INSTRUCCION(18) <= INT_NUM(MODULO(conv_integer(DATO),10));
INSTRUCCION(19) <= BUCLE_FIN(1);
INSTRUCCION(20) <= CODIGO_FIN(1);

end Behavioral;