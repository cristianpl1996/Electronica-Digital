--
--	Package File Template
--
-- Incluir este paquete en las librerías "USE.WORK.OP_DIVISION.ALL" cuando se requiera de una división sin utilizar el operador "/".
--
-- Utiliza la funcion DIV(A,B) para obtener el resultado de tipo INTEGER de la división A/B, A y B son de tipo INTEGER.
--
-- Por ejemplo:
--
-- A := 10; 
-- B := 2;
-- C <= DIV(A,B); --C guardará el resultado con el valor de 5
--
-- Utiliza la función MODULO(A,B) para obtener el residuo de la división A/B de tipo INTEGER.
--
-- Por ejemplo:
--
-- A := 6;
-- B := 4;
-- C <= MODULO(A,B); --C guardará el residuo con el valor de 2
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

package OP_DIVISION is

FUNCTION DIV(A,B:INTEGER) RETURN INTEGER;
FUNCTION MODULO(A,B:INTEGER) RETURN INTEGER;

CONSTANT N : INTEGER := 31;

end OP_DIVISION;

package body OP_DIVISION is


-----FUNCIÓN DIV()-----
FUNCTION DIV(A,B:INTEGER) RETURN INTEGER IS
	
VARIABLE AS, BS,ITERACIONES,RESIDUO_S,RESULTADO,RESIDUO: STD_LOGIC_VECTOR(N DOWNTO 0);
	
BEGIN
	  
	 AS := CONV_STD_LOGIC_VECTOR(A,N+1);
	 BS := CONV_STD_LOGIC_VECTOR(B,N+1);

	IF BS = "00000000000000000000000000000000" THEN
		RESULTADO := (OTHERS => '0');
		RESIDUO := (OTHERS => '0');
	ELSE
		ITERACIONES := (OTHERS => '0');
		RESIDUO_S := (OTHERS => '0');
		FOR I IN N DOWNTO 0 LOOP
			RESIDUO_S := RESIDUO_S(N-1 DOWNTO 0)&'0';
			RESIDUO_S(0) := AS(I);
			IF RESIDUO_S >= BS THEN
				RESIDUO_S := RESIDUO_S - BS;
				ITERACIONES(I) := '1';
			END IF;
		END LOOP;
		RESULTADO := STD_LOGIC_VECTOR(ITERACIONES);
		RESIDUO := STD_LOGIC_VECTOR(RESIDUO_S);
	END IF;
RETURN CONV_INTEGER(RESULTADO);
END DIV;
-----------------------

-----FUNCIÓN MODULO()-----
FUNCTION MODULO(A,B:INTEGER) RETURN INTEGER IS

VARIABLE AS, BS,ITERACIONES,RESIDUO_S,RESULTADO,RESIDUO: STD_LOGIC_VECTOR(N DOWNTO 0);
	
BEGIN
	  
	 AS := CONV_STD_LOGIC_VECTOR(A,N+1);
	 BS := CONV_STD_LOGIC_VECTOR(B,N+1);

	IF BS = "00000000000000000000000000000000" THEN
		RESULTADO := (OTHERS => '0');
		RESIDUO := (OTHERS => '0');
	ELSE
		ITERACIONES := (OTHERS => '0');
		RESIDUO_S := (OTHERS => '0');
		FOR I IN N DOWNTO 0 LOOP
			RESIDUO_S := RESIDUO_S(N-1 DOWNTO 0)&'0';
			RESIDUO_S(0) := AS(I);
			IF RESIDUO_S >= BS THEN
				RESIDUO_S := RESIDUO_S - BS;
				ITERACIONES(I) := '1';
			END IF;
		END LOOP;
		RESULTADO := STD_LOGIC_VECTOR(ITERACIONES);
		RESIDUO := STD_LOGIC_VECTOR(RESIDUO_S);
	END IF;
RETURN CONV_INTEGER(RESIDUO);
END MODULO;
-----------------------
 
end OP_DIVISION;
