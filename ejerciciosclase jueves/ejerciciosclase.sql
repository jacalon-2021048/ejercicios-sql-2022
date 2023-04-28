
-- Jhonatan Jose Acalon Ajanel
-- 2021048
-- IN5BM1

DROP DATABASE IF EXISTS test_1;
CREATE DATABASE test_1;
USE test_1;

-- Crear un procedimiento almacenado que reciba dos numeros (dos parametros) y decir si son iguales o no

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_1 $$
CREATE PROCEDURE sp_ejercicio_1(IN a INT,IN b INT)
BEGIN
	IF a=b THEN
        SELECT CONCAT("El numero " ,a, " es igual que el numero ", b) AS resultado;
    ELSE
		SELECT CONCAT("El numero " ,a, " no es igual que el numero ", b) AS resultado;
    END IF;
END$$
DELIMITER ;


CALL sp_ejercicio_1(1,12);

-- Crear un procedimiento almacenado que reciba dos numeros (dos parametros) y decir cual es el mayor
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_2 $$
CREATE PROCEDURE sp_ejercicio_2(IN a INT,IN b INT)
BEGIN
	IF a>b THEN
        SELECT CONCAT("El numero ",a," es mayor que el numero ", b) AS resultado;
	ELSEIF a<b THEN
        SELECT CONCAT("El numero ",a," es menor que el numero ", b) AS resultado;
    ELSEIF a=b THEN
		SELECT CONCAT("El numero " ,a, " es igual que el numero ", b) AS resultado;
    END IF;
END$$
DELIMITER ;

CALL sp_ejercicio_2(6,1);

-- USO VARIABLE TIPO ENUM
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_3 $$
CREATE PROCEDURE sp_ejercicio_3(IN _forma_pago VARCHAR(45))
BEGIN
	DECLARE forma_pago ENUM ("efectivo","tarjeta","transferencia");
    -- SET forma_pago="tarjeta";
    SET forma_pago=_forma_pago;
    CASE forma_pago
		WHEN "efectivo" THEN
			SELECT "La forma de pago es: efectivo";
		WHEN "tarjeta" THEN
			SELECT "La forma de pago es: tarjeta";
		ELSE
			SELECT "La forma de pago es: transferencia";
		END CASE;
END$$
DELIMITER ;

CALL sp_ejercicio_3("transferencia");

-- USO VARIABLE TIPO ENUM 2 (Crear un procedimiento almacenado que reciba un numero de 1 a 3 y muestre los valores "efectivo",
-- "tarjeta", "transferencia" segun corresponda utilizando ENUM y la estructura CASE)
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_4 $$
CREATE PROCEDURE sp_ejercicio_4(IN _forma_pago INT)
BEGIN
	DECLARE forma_pago ENUM ("efectivo","tarjeta","transferencia");
    -- SET forma_pago="tarjeta";
    SET forma_pago=_forma_pago;
    CASE forma_pago
		WHEN "efectivo" THEN
			SELECT "La forma de pago es: efectivo";
		WHEN "tarjeta" THEN
			SELECT "La forma de pago es: tarjeta";
		ELSE
			SELECT "La forma de pago es: transferencia";
		END CASE;
END$$
DELIMITER ;

CALL sp_ejercicio_4(3);

-- Pedir una nota numerica entre 0 y 10, y mostrar dicha nota de la forma: cero, uno, dos, tres....

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_5 $$
CREATE PROCEDURE sp_ejercicio_5(IN nota INT)
BEGIN
    CASE nota
		WHEN 0 THEN
			SELECT "La nota obtenida es: cero" AS nota;
		WHEN 1 THEN
			SELECT "La nota obtenida es: uno" AS nota;
		WHEN 2 THEN
			SELECT "La nota obtenida es: dos" AS nota;
		WHEN 3 THEN
			SELECT "La nota obtenida es: tres" AS nota;
		WHEN 4 THEN
			SELECT "La nota obtenida es: cuatro" AS nota;
		WHEN 5 THEN
			SELECT "La nota obtenida es: cinco" AS nota;
		WHEN 6 THEN
			SELECT "La nota obtenida es: seis" AS nota;
		WHEN 7 THEN
			SELECT "La nota obtenida es: siete" AS nota;
		WHEN 8 THEN
			SELECT "La nota obtenida es: ocho" AS nota;
		WHEN 9 THEN
			SELECT "La nota obtenida es: nueve" AS nota;
		WHEN 10 THEN
			SELECT "La nota obtenida es: diez" AS nota;
		ELSE
			SELECT "La nota ingresada no es valida" AS nota;
		END CASE;
END$$
DELIMITER ;

CALL sp_ejercicio_5(75);

-- Ejercicio Loop

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_6$$
CREATE PROCEDURE sp_ejercicio_6()
BEGIN 
	DECLARE i TINYINT UNSIGNED;
    SET i=0;
    Ejerciciobucle1: LOOP
		-- Instrucciones a repetir
		SET i=i+1;
        SELECT "El valor de i es: " , i AS i;
        IF i=5 THEN 
			LEAVE Ejerciciobucle1;
		END IF;
    END LOOP Ejerciciobucle1;
END $$
DELIMITER ;

CALL sp_ejercicio_6();

-- 
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_7 $$
CREATE PROCEDURE sp_ejercicio_7()
BEGIN 
	DECLARE i TINYINT UNSIGNED;
    SET i=0;
    Ejerciciobucle2: LOOP
		SET i=i+1;
        
        IF i=4 THEN 
			ITERATE Ejerciciobucle2;-- funcion continue en java
		END IF;
        
        SELECT "El valor de i es: " , i AS i;
        
        IF i=5 THEN 
			LEAVE Ejerciciobucle2;
		END IF;
	END LOOP Ejerciciobucle2;
END $$
DELIMITER ;

CALL sp_ejercicio_7();

-- Crear un procedimiento almacenado que reciba dos parametros correspondiente al valor inicial y final de una serie de nuemeros
-- que debe nostrar en pantalla a excepcion de los numeros pares. 1-valor incial 2-valor final
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_8 $$
CREATE PROCEDURE sp_ejercicio_8(IN inicio INT,IN final INT)
BEGIN
	DECLARE i INT UNSIGNED;
    SET i=inicio;
    bucle3: LOOP
        SET i=i+1;
        
        IF i%2!=0 THEN 
			ITERATE bucle3;
		END IF;
        
        SELECT "El valor de i es: " , i AS i;
        
        IF i>=final-1 THEN 
			LEAVE bucle3;
		END IF;
	END LOOP bucle3;
END$$
DELIMITER ;

CALL sp_ejercicio_8(2,8);

-- Ejemplo repeat until
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_9 $$
CREATE PROCEDURE sp_ejercicio_9()
BEGIN
	DECLARE i TINYINT UNSIGNED;
    SET i=0;
	bucle4: REPEAT
		SET i=i+1;
        SELECT i AS contador;
        UNTIL i=4
    END REPEAT bucle4;
END$$
DELIMITER ;

CALL sp_ejercicio_9();

-- Crear un procedimiento almacenado que reciba dos parametros correspondiente al valor inicial y final de una serie de nuemeros
-- que debe nostrar en pantalla a excepcion de los numeros impares. 1-valor incial 2-valor final con ciclo REPEAT (solucion mia)
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_10 $$
CREATE PROCEDURE sp_ejercicio_10(IN inicio INT,IN final INT)
BEGIN
	DECLARE i INT UNSIGNED;
    SET i=inicio;
	bucle5: REPEAT
		SET i=i+1;
		IF i%2!=0 THEN 
			ITERATE bucle5;
		END IF;
    
		SELECT "El valor de i es: " , i AS i;

		UNTIL i>=final-1
    END REPEAT bucle5;
END$$
DELIMITER ;

CALL sp_ejercicio_10(8,20);

-- Crear un procedimiento almacenado que reciba dos parametros correspondiente al valor inicial y final de una serie de nuemeros
-- que debe nostrar en pantalla a excepcion de los numeros impares. 1-valor incial 2-valor final con ciclo REPEAT (solucion clase)
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejercicio_11 $$
CREATE PROCEDURE sp_ejercicio_11(IN inicio INT,IN final INT)
BEGIN
	DECLARE i TINYINT UNSIGNED;
    SET i=inicio;
	bucle6: REPEAT        
		IF i%2=0 THEN 
			SELECT "El valor de i es: " , i AS i;
		END IF;
    
		SET i=i+1;

		UNTIL i=final+1
    END REPEAT bucle6;
END$$
DELIMITER ;

CALL sp_ejercicio_11(8,20);