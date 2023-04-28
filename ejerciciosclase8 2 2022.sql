USE test_1;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_12_while $$
CREATE PROCEDURE sp_ejercicio_12_while()
BEGIN
	DECLARE i TINYINT UNSIGNED;
    SET i=0;
    WHILE i<5 DO
		SET i=i+1;
        SELECT i;
	END WHILE;
END$$
DELIMITER ;

CALL sp_ejercicio_12_while()

-- FUNCIONES
/*
Ejemplo 1:
Crear una función que permita multiplicar dos números.(SOLUCION MIA)
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_multiplicacion_1 $$
CREATE FUNCTION fn_multiplicacion(valor_1 INT,valor_2 INT)
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN 
	DECLARE i INT UNSIGNED;
    SET i=valor_1*valor_2;
    RETURN i;
END$$
DELIMITER ;

SELECT fn_multiplicacion(2,4);

/*
Ejemplo 1:
Crear una función que permita multiplicar dos números.(SOLUCION PROFE)
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_multiplicacion_p_1 $$
CREATE FUNCTION fn_multiplicacion(valor_1 INT,valor_2 INT)
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN 
    RETURN valor_1*valor_2;
END$$
DELIMITER ;

SET @result=fn_multiplicacion_p_1(2,4);
SELECT @result;

/*
Ejemplo 2:
Crear una función que calcule el área de un circulo.
Recibira los valores necesarios para calcular el area.
Devolvera un numero real. 
Mostrar el resultado por pantalla.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_area_circulo_2 $$
CREATE FUNCTION fn_area_circulo_2(radio INT)
RETURNS DOUBLE
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE area DOUBLE;
    SET area=PI()*POW(radio,2);
    RETURN area;
END$$
DELIMITER ;

SELECT fn_area_circulo_2(5) AS area_circulo;

/*
Ejemplo 3:
Crear una función que calcule el área de un triangulo.
Recibira los valores necesarios para calcular el area.
Devolvera un numero real. 
Mostrar el resultado por pantalla.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_area_triangulo_3 $$
CREATE FUNCTION fn_area_triangulo_3(base INT,altura INT)
RETURNS DECIMAL(6,2)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE area DECIMAL(6,2);
    SET area=(base*altura)/2;
    RETURN area;
END$$
DELIMITER ;

SELECT fn_area_triangulo_3(4,6) AS area_circulo;

/*
Ejemplo 4:
Crear una función que devuelva un número entero aleatorio.
donde pasamos cono párametros entre que números queremos que los genere.
Muestra este número pór pantalla
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_aleatorio_4 $$
CREATE FUNCTION fn_aleatorio_4(inicio INT, final INT)
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE resultado INT;
    SET resultado=RAND()*(final-inicio)+inicio;
    RETURN resultado;
END$$
DELIMITER ;

SELECT fn_aleatorio_4(100,500);

/*
Ejemplo 5:
Crear una función que devuelva el mayor de N números aleatorios.
*/

DELIMITER $$
DROP FUNCTION IF EXISTS fn_aleatorio_mayor_5 $$
CREATE FUNCTION fn_aleatorio_mayor_5(limite INT)
RETURNS VARCHAR(255)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE mayor, i,num INT;
    DECLARE resultado VARCHAR(255) DEFAULT " ";
    SET mayor=0;
    SET i=0;
    SET num=0;
    REPEAT
		SET i=i+1;
		SET num=RAND()*100;
		SET resultado=CONCAT(resultado, num, " | ");
        
        IF (num>mayor) THEN 
			SET mayor=num;
		END IF;
        
		UNTIL i=limite
    END REPEAT;
    SET resultado=CONCAT(resultado,"El mayor es: ",mayor);
    RETURN resultado;
END$$
DELIMITER ;

SELECT fn_aleatorio_mayor_5(2);
