----------------------------------------
----------PROCESADOR LCD----------------
----------¡NO MODIFICAR!----------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PROCESADOR_LCD_REVC is

PORT(CLK : IN STD_LOGIC;
	  VECTOR_MEM : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	  RS : OUT STD_LOGIC;
	  CORD : IN STD_LOGIC;
	  CORI : IN STD_LOGIC;
	  DELAY_COR : IN INTEGER RANGE 0 TO 1000;
	  RW : OUT STD_LOGIC;
	  ENA : OUT STD_LOGIC;
	  INC_DIR : OUT INTEGER RANGE 0 TO 1024;
	  BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         
	  C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
	  C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       	
	  DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);

end PROCESADOR_LCD_REVC;

architecture Behavioral of PROCESADOR_LCD_REVC is

TYPE MAQUINA IS (CHECAR,INI_LCD,CURSOR_LCD,CURSOR_HOME,CURSOR_HOME2,CLEAR_DISPLAY,CLEAR_DISPLAY2,ESCRIBIR_LCD,ENABLE,
POSICION,CD_SHIFT,CHAR_ASCII,BUCLE_INI,BUCLE_FIN,CORRIMIENTO_DERECHA,CORRIMIENTO_IZQUIERDA,
ENA_D,ENA_I,POS_RAM,CREAR_CHAR1,CREAR_CHAR2,CREAR_CHAR3,CREAR_CHAR4,CREAR_CHAR5,CREAR_CHAR6,CREAR_CHAR7,CREAR_CHAR8,
INT_NUM,ENA_CHAR,LIMPIAR_PANTALLA,LEER_RAM,NADA,FIN);
SIGNAL ESTADO : MAQUINA := CHECAR;

SIGNAL ESTADO_FUTURO : MAQUINA;
SIGNAL ESTADO_PRESENTE :MAQUINA;

CONSTANT DELAY_FIN : INTEGER := 49_999;
SIGNAL CONTA_DELAY : INTEGER RANGE 0 TO DELAY_FIN := 0;
SIGNAL REPITE : INTEGER RANGE 0 TO 2 := 0;
SIGNAL CONTA_DELAY_COR : INTEGER;
SIGNAL DELAY_COR2 : INTEGER;
SIGNAL I : INTEGER RANGE 0 TO 9 := 0;

SIGNAL VEC_CHAR,VEC_POS,VEC_SHIFT,VEC_ASCII,VEC_NUM: STD_LOGIC_VECTOR(8 DOWNTO 0):= "000000000";
SIGNAL DATA_A,VEC_S_CHAR,VEC_RAM,VEC_L_RAM : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL VEC_C_CHAR : STD_LOGIC_VECTOR(39 DOWNTO 0);


SIGNAL INC_DIR_S,DIR_BI,DIR_BF : INTEGER RANGE 0 TO 1024 :=0;

begin

INC_DIR <= INC_DIR_S;
-----------------------------------------------------------------------------------
PROCESS(CLK)
BEGIN
	IF RISING_EDGE(CLK) THEN
					
						IF 	VECTOR_MEM = '1'&X"7E" THEN VEC_RAM <= X"40"; VEC_C_CHAR <= C1A; 
						ELSIF VECTOR_MEM = '1'&X"7F" THEN VEC_RAM <= X"48"; VEC_C_CHAR <= C2A; 
						ELSIF VECTOR_MEM = '1'&X"80" THEN VEC_RAM <= X"50"; VEC_C_CHAR <= C3A; 
						ELSIF VECTOR_MEM = '1'&X"81" THEN VEC_RAM <= X"58"; VEC_C_CHAR <= C4A; 
						ELSIF VECTOR_MEM = '1'&X"82" THEN VEC_RAM <= X"60"; VEC_C_CHAR <= C5A; 
						ELSIF VECTOR_MEM = '1'&X"83" THEN VEC_RAM <= X"68"; VEC_C_CHAR <= C6A; 
						ELSIF VECTOR_MEM = '1'&X"84" THEN VEC_RAM <= X"70"; VEC_C_CHAR <= C7A; 
						ELSIF VECTOR_MEM = '1'&X"85" THEN VEC_RAM <= X"78"; VEC_C_CHAR <= C8A;
						ELSIF VECTOR_MEM = '1'&X"86" THEN VEC_L_RAM <= X"00";
						ELSIF VECTOR_MEM = '1'&X"87" THEN VEC_L_RAM <= X"01";
						ELSIF VECTOR_MEM = '1'&X"88" THEN VEC_L_RAM <= X"02";
						ELSIF VECTOR_MEM = '1'&X"89" THEN VEC_L_RAM <= X"03";
						ELSIF VECTOR_MEM = '1'&X"8A" THEN VEC_L_RAM <= X"04";
						ELSIF VECTOR_MEM = '1'&X"8B" THEN VEC_L_RAM <= X"05";
						ELSIF VECTOR_MEM = '1'&X"8C" THEN VEC_L_RAM <= X"06";
						ELSIF VECTOR_MEM = '1'&X"8D" THEN VEC_L_RAM <= X"07";
						END IF;
						
					IF VECTOR_MEM >= '1'&X"01" AND VECTOR_MEM <= '1'&X"04" THEN
						ESTADO <= INI_LCD;					
					ELSIF VECTOR_MEM >= '1'&X"09" AND VECTOR_MEM <= '1'&X"41" THEN
						ESTADO <= ESCRIBIR_LCD;
					ELSIF VECTOR_MEM >= '1'&x"50" AND VECTOR_MEM <= '1'&x"77" THEN
						ESTADO <= POSICION;
					ELSIF VECTOR_MEM >= '1'&x"78" AND VECTOR_MEM <= '1'&x"7B" THEN
						ESTADO <= CD_SHIFT;
					ELSIF VECTOR_MEM > '0'&x"00" AND VECTOR_MEM <= '0'&x"FF" THEN
						ESTADO <= CHAR_ASCII;
					ELSIF VECTOR_MEM = '1'&X"7C"THEN
						ESTADO <= BUCLE_INI;
					ELSIF VECTOR_MEM = '1'&X"7D"THEN
						ESTADO <= BUCLE_FIN;
					ELSIF VECTOR_MEM = '1'&X"FE"THEN
						ESTADO <= LIMPIAR_PANTALLA;	
					ELSIF VECTOR_MEM = '1'&X"FD"THEN
						ESTADO <= NADA;	
					ELSIF VECTOR_MEM >= '1'&X"7E" AND VECTOR_MEM <= '1'&X"85" THEN
						ESTADO <= POS_RAM;
					ELSIF VECTOR_MEM >= '1'&X"86" AND VECTOR_MEM <= '1'&X"8D" THEN
						ESTADO <= LEER_RAM;
					ELSIF CORD = '1' THEN
						ESTADO <= CORRIMIENTO_DERECHA;
					ELSIF CORI = '1' THEN
						ESTADO <= CORRIMIENTO_IZQUIERDA;
					ELSIF VECTOR_MEM = "UUUUUUUU" OR VECTOR_MEM ='1'& X"FF" THEN
						ESTADO <= FIN;
					END IF;

	
			CASE ESTADO IS
					
				WHEN CHECAR =>
					
						BD_LCD <= X"00";
						IF 	VECTOR_MEM = '1'&X"7E" THEN VEC_RAM <= X"40"; VEC_C_CHAR <= C1A;
						ELSIF VECTOR_MEM = '1'&X"7F" THEN VEC_RAM <= X"48"; VEC_C_CHAR <= C2A;
						ELSIF VECTOR_MEM = '1'&X"80" THEN VEC_RAM <= X"50"; VEC_C_CHAR <= C3A;
						ELSIF VECTOR_MEM = '1'&X"81" THEN VEC_RAM <= X"58"; VEC_C_CHAR <= C4A;
						ELSIF VECTOR_MEM = '1'&X"82" THEN VEC_RAM <= X"60"; VEC_C_CHAR <= C5A;
						ELSIF VECTOR_MEM = '1'&X"83" THEN VEC_RAM <= X"68"; VEC_C_CHAR <= C6A;
						ELSIF VECTOR_MEM = '1'&X"84" THEN VEC_RAM <= X"70"; VEC_C_CHAR <= C7A;
						ELSIF VECTOR_MEM = '1'&X"85" THEN VEC_RAM <= X"78"; VEC_C_CHAR <= C8A;
						ELSIF VECTOR_MEM = '1'&X"86" THEN VEC_L_RAM <= X"00";
						ELSIF VECTOR_MEM = '1'&X"87" THEN VEC_L_RAM <= X"01";
						ELSIF VECTOR_MEM = '1'&X"88" THEN VEC_L_RAM <= X"02";
						ELSIF VECTOR_MEM = '1'&X"89" THEN VEC_L_RAM <= X"03";
						ELSIF VECTOR_MEM = '1'&X"8A" THEN VEC_L_RAM <= X"04";
						ELSIF VECTOR_MEM = '1'&X"8B" THEN VEC_L_RAM <= X"05";
						ELSIF VECTOR_MEM = '1'&X"8C" THEN VEC_L_RAM <= X"06";
						ELSIF VECTOR_MEM = '1'&X"8D" THEN VEC_L_RAM <= X"07";
						END IF;
					
					IF VECTOR_MEM >= '1'&X"01" AND VECTOR_MEM <= '1'&X"04" THEN
						ESTADO <= INI_LCD;
					ELSIF VECTOR_MEM >= '1'&X"09" AND VECTOR_MEM <= '1'&X"41" THEN
						ESTADO <= ESCRIBIR_LCD;						
					ELSIF VECTOR_MEM >= '1'&x"50" AND VECTOR_MEM <= '1'&x"77" THEN
						ESTADO <= POSICION;
					ELSIF VECTOR_MEM >= '1'&x"78" AND VECTOR_MEM <= '1'&x"7B" THEN
						ESTADO <= CD_SHIFT;						
					ELSIF VECTOR_MEM > '0'&x"00" AND VECTOR_MEM <= '0'&x"FF" THEN
						ESTADO <= CHAR_ASCII;						
					ELSIF VECTOR_MEM = '1'&X"7C"THEN
						ESTADO <= BUCLE_INI;												
					ELSIF VECTOR_MEM = '1'&X"7D"THEN
						ESTADO <= BUCLE_FIN;						
					ELSIF VECTOR_MEM = '1'&X"FE"THEN
						ESTADO <= LIMPIAR_PANTALLA;						
					ELSIF VECTOR_MEM = '1'&X"FD"THEN
						ESTADO <= NADA;							
					ELSIF VECTOR_MEM >= '1'&X"7E" AND VECTOR_MEM <= '1'&X"85" THEN
						ESTADO <= POS_RAM;
					ELSIF VECTOR_MEM >= '1'&X"86" AND VECTOR_MEM <= '1'&X"8D" THEN
						ESTADO <= LEER_RAM;					
					ELSIF CORD = '1' THEN
						ESTADO <= CORRIMIENTO_DERECHA;
					ELSIF CORI = '1' THEN
						ESTADO <= CORRIMIENTO_IZQUIERDA;
					ELSIF VECTOR_MEM = "UUUUUUUU" OR VECTOR_MEM ='1'& X"FF" THEN
						ESTADO <= FIN;					
					END IF;
					
				WHEN INI_LCD =>
					
					RS <= '0';
					RW <= '0';	
					
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CLEAR_DISPLAY;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= INI_LCD;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					
				WHEN CLEAR_DISPLAY =>
				
						RS <= '0';
						RW <= '0';
						
					   IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CURSOR_HOME;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CLEAR_DISPLAY;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CURSOR_HOME =>
										
						RS <= '0';
						RW <= '0';
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CURSOR_LCD;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CURSOR_HOME;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CURSOR_LCD => 
						
						RS <= '0';
						RW <= '0';
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"01";							
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CURSOR_LCD;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					
				
				WHEN ESCRIBIR_LCD =>
						
						RS <= '1';
						RW <= '0';
													
						IF VECTOR_MEM >= '1'&X"09" AND VECTOR_MEM <= '1'&X"22" THEN
							VEC_CHAR <= VECTOR_MEM - ('0'&X"A8");
						ELSIF VECTOR_MEM >= '1'&X"23" AND VECTOR_MEM <= '1'&X"3C" THEN
							VEC_CHAR <= VECTOR_MEM - ('0'&X"E2");
						ELSE
							VEC_CHAR <= VECTOR_MEM - ('1'&X"0D");
						END IF;
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							BD_LCD <= X"02";
							ESTADO <= CHECAR;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= ESCRIBIR_LCD;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN POSICION =>
				  
				   RS <= '0';
					RW <= '0';
					
						IF VECTOR_MEM >= '1'&X"50" AND VECTOR_MEM <= '1'&X"63" THEN
							VEC_POS <= VECTOR_MEM - ('0'&X"D0");
						ELSIF VECTOR_MEM >= X"164" AND VECTOR_MEM <= '1'&X"77" THEN
							VEC_POS <= VECTOR_MEM - ('0'&X"A4");
						END IF;	
					
					IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"03";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= POSICION;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CD_SHIFT =>
					
					RS <= '0';
					RW <= '0';
					
						IF    VECTOR_MEM = '1'&X"78" THEN VEC_SHIFT <= '0'&X"10";
						ELSIF VECTOR_MEM = '1'&X"79" THEN VEC_SHIFT <= '0'&X"14";
						ELSIF VECTOR_MEM = '1'&X"7A" THEN VEC_SHIFT <= '0'&X"18";
						ELSIF VECTOR_MEM = '1'&X"7B" THEN VEC_SHIFT <= '0'&X"1C";
						END IF;
							
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"04";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CD_SHIFT;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CHAR_ASCII =>
						
					RS <= '1';
					RW <= '0';	
					VEC_ASCII <= VECTOR_MEM;
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"05";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CHAR_ASCII;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
						
------------------------------------------------------------------------
				WHEN POS_RAM =>
					
					RS <= '0';
					RW <= '0';
					
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR1;
							VEC_S_CHAR <= "000"&VEC_C_CHAR(39 DOWNTO 35);
							
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= POS_RAM;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CREAR_CHAR1 =>
				
						BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
					
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR2;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR1;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				WHEN CREAR_CHAR2 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR3;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR2;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					
				WHEN CREAR_CHAR3 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR4;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR3;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					
					WHEN CREAR_CHAR4 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR5;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR4;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					WHEN CREAR_CHAR5 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR6;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR5;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					WHEN CREAR_CHAR6 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR7;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR6;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					WHEN CREAR_CHAR7 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR8;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR7;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
					
					WHEN CREAR_CHAR8 =>
				     
					   BD_LCD <= X"00";
						RS <= '1';
						RW <= '0';
	
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CURSOR_HOME2;--------------------------------------INI_LCD;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CREAR_CHAR8;
						END IF;
						
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
						
						
				WHEN CURSOR_HOME2 =>
										
						RS <= '0';
						RW <= '0';
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"09";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= CURSOR_HOME2;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				
				
				WHEN ENA_CHAR =>		
						
					BD_LCD <= X"00";
					IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CREAR_CHAR1;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= ENA_CHAR;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;

------------------------------------------------------------------------
				WHEN LEER_RAM =>
						
						RS <= '1';
						RW <= '0';
							
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"0A";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= LEER_RAM;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
			
						
				WHEN BUCLE_INI	=>
				
						DIR_BI <= INC_DIR_S;
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"06";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= BUCLE_INI;
						END IF;
						
				WHEN BUCLE_FIN =>
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= DIR_BI;
							ESTADO <= BUCLE_INI;
							BD_LCD <= X"07";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= BUCLE_FIN;
						END IF;
				
				WHEN LIMPIAR_PANTALLA =>
				
						RS <= '0';
						RW <= '0';
						
					   IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"08";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= LIMPIAR_PANTALLA;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
				

				
				WHEN CORRIMIENTO_DERECHA =>
						
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';	
					DELAY_COR2 <= DELAY_COR*50_000;
						
						IF CONTA_DELAY_COR = DELAY_COR2 THEN				
							CONTA_DELAY_COR <= 0;
							ESTADO <= ENA_D;					
						ELSE
							CONTA_DELAY_COR <= CONTA_DELAY_COR +1;
							ESTADO <= CORRIMIENTO_DERECHA;
						END IF;
				
				
				WHEN CORRIMIENTO_IZQUIERDA =>
					
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';	
					DELAY_COR2 <= DELAY_COR*50_000;					
						
						IF CONTA_DELAY_COR = DELAY_COR2 THEN				
							CONTA_DELAY_COR <= 0;
							ESTADO <= ENA_I;					
						ELSE
							CONTA_DELAY_COR <= CONTA_DELAY_COR +1;
							ESTADO <= CORRIMIENTO_IZQUIERDA;
						END IF;
						
				WHEN ENA_D =>
				
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CHECAR;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= ENA_D;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;

				WHEN ENA_I =>
				
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							ESTADO <= CHECAR;
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= ENA_I;
						END IF;
				
						IF CONTA_DELAY <= DELAY_FIN/3 THEN
							ENA <= '0';
						ELSIF CONTA_DELAY > DELAY_FIN/3 AND CONTA_DELAY < (2*DELAY_FIN)/3 THEN
							ENA <= '1';
						ELSE
							ENA <= '0';
						END IF;
						
				WHEN NADA =>
						
						IF CONTA_DELAY = DELAY_FIN THEN				
							CONTA_DELAY <= 0;
							INC_DIR_S <= INC_DIR_S +1;
							ESTADO <= CHECAR;
							BD_LCD <= X"08";
						ELSE
							CONTA_DELAY <= CONTA_DELAY +1;
							ESTADO <= NADA;
						END IF;
				
						
				
				WHEN FIN => NULL;
				
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';
				
				
				WHEN OTHERS => NULL;
				
					BD_LCD <= X"00";
					RS <= '0';
					RW <= '0';
				
			END CASE;
	END IF;
END PROCESS;
---------------------------------------------------------------------------------------------------------

PROCESS(ESTADO)
BEGIN
	IF ESTADO = CURSOR_LCD THEN
		IF VECTOR_MEM = '1'&X"01" THEN
			DATA <= "00001100";
		ELSIF VECTOR_MEM = '1'&X"02" THEN
			DATA <= "00001101"; 
		ELSIF VECTOR_MEM = '1'&X"03" THEN
			DATA <= "00001110";
		ELSE
			DATA <= "00001111";
		END IF;
	ELSIF ESTADO = INI_LCD  THEN
		DATA <= "00111000";
		DATA_A <= "00111000";
	ELSIF ESTADO = CLEAR_DISPLAY OR ESTADO = LIMPIAR_PANTALLA THEN
		DATA <= "00000001";
		DATA_A <= "00000001";
	ELSIF ESTADO = CURSOR_HOME  OR ESTADO = CURSOR_HOME2 THEN
		DATA <= "00000010";
		DATA_A <= "00000010";
	ELSIF ESTADO = ESCRIBIR_LCD THEN
		DATA <= VEC_CHAR(7 DOWNTO 0);
		DATA_A <= VEC_CHAR(7 DOWNTO 0);
	ELSIF ESTADO = POSICION THEN
		DATA <= VEC_POS(7 DOWNTO 0);
		DATA_A <= VEC_POS(7 DOWNTO 0);
	ELSIF ESTADO = CD_SHIFT THEN
		DATA <= VEC_SHIFT(7 DOWNTO 0);
		DATA_A <= VEC_SHIFT(7 DOWNTO 0);
	ELSIF ESTADO = CHAR_ASCII THEN
		DATA <= VEC_ASCII(7 DOWNTO 0);
		DATA_A <= VEC_ASCII(7 DOWNTO 0);
	ELSIF ESTADO = ENA_D THEN
		DATA <= "00011100";
		DATA_A <= "00011100";
	ELSIF ESTADO = ENA_I THEN
		DATA <= "00011000";
		DATA_A <= "00011000";		
	ELSIF ESTADO = POS_RAM THEN
		DATA <= VEC_RAM;
		DATA_A <= VEC_RAM;
------	
	ELSIF ESTADO = CREAR_CHAR1 THEN
		DATA <= "000"&VEC_C_CHAR(39 DOWNTO 35);
		DATA_A <= "000"&VEC_C_CHAR(39 DOWNTO 35);
	
	ELSIF ESTADO = CREAR_CHAR2 THEN
		DATA <= "000"&VEC_C_CHAR(34 DOWNTO 30);
		DATA_A <= "000"&VEC_C_CHAR(34 DOWNTO 30);
	
	ELSIF ESTADO = CREAR_CHAR3 THEN
		DATA <= "000"&VEC_C_CHAR(29 DOWNTO 25);
		DATA_A <= "000"&VEC_C_CHAR(29 DOWNTO 25);

	ELSIF ESTADO = CREAR_CHAR4 THEN
		DATA <= "000"&VEC_C_CHAR(24 DOWNTO 20);
		DATA_A <= "000"&VEC_C_CHAR(24 DOWNTO 20);

	ELSIF ESTADO = CREAR_CHAR5 THEN
		DATA <= "000"&VEC_C_CHAR(19 DOWNTO 15);
		DATA_A <= "000"&VEC_C_CHAR(19 DOWNTO 15);

	ELSIF ESTADO = CREAR_CHAR6 THEN
		DATA <= "000"&VEC_C_CHAR(14 DOWNTO 10);
		DATA_A <= "000"&VEC_C_CHAR(14 DOWNTO 10);

	ELSIF ESTADO = CREAR_CHAR7 THEN
		DATA <= "000"&VEC_C_CHAR(9 DOWNTO 5);
		DATA_A <= "000"&VEC_C_CHAR(9 DOWNTO 5);

	ELSIF ESTADO = CREAR_CHAR8 THEN
		DATA <= "000"&VEC_C_CHAR(4 DOWNTO 0);
		DATA_A <= "000"&VEC_C_CHAR(4 DOWNTO 0);
------		
	ELSIF ESTADO = LEER_RAM THEN
		DATA <= VEC_L_RAM;
		DATA_A <= VEC_L_RAM;
		
	ELSIF ESTADO = CHECAR OR ESTADO = ENABLE OR ESTADO = ENA_CHAR THEN
		DATA <= DATA_A;
	ELSE
		DATA <= "00000000";
	END IF;
END PROCESS;

end Behavioral;

