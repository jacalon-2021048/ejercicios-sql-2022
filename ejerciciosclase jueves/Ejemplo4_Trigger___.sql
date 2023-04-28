DROP DATABASE IF EXISTS db_test_trigger;
CREATE DATABASE db_test_trigger;

USE db_test_trigger;

CREATE TABLE estudiantes (
    carne INT NOT NULL,
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    domicilio VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY pk_carne (carne)
);

CREATE TABLE control (
    id INT AUTO_INCREMENT NOT NULL,
    usuario VARCHAR(150),
    fecha_modificacion DATETIME,
    PRIMARY KEY pk_id (id)
);


-- 1. Realizar un procedimiento para agregar estudiantes

DELIMITER $$
CREATE PROCEDURE sp_estudiantes_create(
	IN _carne INT, 
	IN _nombres VARCHAR(150), 
	IN _apellidos VARCHAR(150), 
	IN _domicilio VARCHAR(150), 
	IN _fecha_nacimiento DATE
)
BEGIN
	INSERT INTO estudiantes (carne, nombres, apellidos, domicilio, fecha_nacimiento) 
    VALUES (_carne, _nombres, _apellidos, _domicilio, _fecha_nacimiento);
END$$
DELIMITER ;


-- 2. Crear un trigger que se desencadenará después de agregar un estudiante y almacenará en la tabla control el usuario de la bd y la fecha en que se realizó la inserción.
DELIMITER $$
DROP TRIGGER IF EXISTS tr_estudiantes_after_insert$$
CREATE TRIGGER tr_estudiantes_after_insert
AFTER INSERT
ON estudiantes
FOR EACH ROW
BEGIN
	INSERT INTO control(usuario,fecha_modificacion)
    VALUES (CURRENT_USER(),NOW());
END$$
DELIMITER ;

CALL sp_estudiantes_create("2021048","Jhonatan","Acalon","Villa nueva",'2005-05-15');

SELECT * FROM estudiantes;

SELECT * FROM control;