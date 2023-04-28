/* 
Actividad de aprendizaje.
Funciones almacenadas
Temario: A

Curso: Taller II
Catedrático: Jorge Pérez.

	Nombre alumno: Jhonatan Jose Acalon Ajanel
	Carné:	2021048
	Sección: IN5BM
    Grupo: 1
	Fecha: 10/02/2022
    
*/

DROP DATABASE IF EXISTS db_funciones_jhonatan_acalon;
CREATE DATABASE db_funciones_jhonatan_acalon;

USE db_funciones_jhonatan_acalon;

CREATE TABLE resultados (
	id INT AUTO_INCREMENT NOT NULL,
    area DECIMAL(10,2),
    impares VARCHAR(45),
    menor INT,
    PRIMARY KEY pk_funciones_Id (id)
);

-- INSTRUCCIONES:

-- 1. Crear un procedimiento almacenado para insertar registros en la tabla Resultados
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_resultados_create $$
CREATE PROCEDURE sp_resultados_create(
	IN _area DECIMAL(10,2),
    IN _impares VARCHAR(45),
    IN _menor INT
)
BEGIN
	INSERT INTO resultados(
		area,
		impares,
		menor
    ) 
    VALUES
    (
		_area,
        _impares,
        _menor
    );
END$$
DELIMITER ;

-- 2. Crear una función para calcular el área de un triangulo.
DELIMITER $$
DROP FUNCTION IF EXISTS fn_area_triangulo $$
CREATE FUNCTION fn_area_triangulo(base DECIMAL(10,2), altura DECIMAL(10,2))
RETURNS DECIMAL(10,2)
READS SQL DATA DETERMINISTIC
BEGIN 
	DECLARE area DECIMAL(10,2);
	SET area=(base*altura)/2;
    RETURN area;
END$$
DELIMITER ;

-- 3. Crear una función que acumule en una variable todos los números impares del 1 al N.
DELIMITER $$
DROP FUNCTION IF EXISTS fn_num_imp $$
CREATE FUNCTION fn_num_imp(limite INT)
RETURNS VARCHAR(45)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE cadena VARCHAR(45) DEFAULT "";
    DECLARE i INT DEFAULT 0;
    bucle: REPEAT
		SET i=i+1;
        IF i%2!=0 THEN
			SET cadena=CONCAT(cadena , " │ " , i);
        END IF;
		UNTIL i=limite
    END REPEAT bucle;
    RETURN cadena;
END$$
DELIMITER ;

-- 4. Crear una función para calcular el número menor de 4 números enteros.
DELIMITER $$
DROP FUNCTION IF EXISTS fn_num_men $$
CREATE FUNCTION fn_num_men(
	a INT, 
    b INT, 
    c INT, 
    d INT)
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE menor INT DEFAULT 0;  
	IF ((a<b) AND (a<c) AND (a<d)) THEN
		SET menor=a;
	ELSEIF ((b<a) AND (b<c) AND (b<d)) THEN
		SET menor=b;
	ELSEIF ((c<a) AND (c<b) AND (c<d)) THEN
		SET menor=c;
	ELSEIF ((d<a) AND (d<b) AND (d<c)) THEN
		SET menor=d;
    END IF;
    RETURN menor;
END$$
DELIMITER ;

-- 5. Llamar al procedimiento almacenado creado anteriormente para insertar el resultado de las funciones en la tabla Resultados
CALL sp_resultados_create(fn_area_triangulo(8,4), fn_num_imp(15),fn_num_men(2,9,10,3));

-- 6. Crear un procedimiento almacenado para listar todos los registros de la tabla Resultados
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_resultados_read $$
CREATE PROCEDURE sp_resultados_read()
BEGIN
	SELECT 
		r.id,
		r.area,
		r.impares,
		r.menor	
    FROM
		resultados AS r;
END$$
DELIMITER ;
CALL sp_resultados_read();