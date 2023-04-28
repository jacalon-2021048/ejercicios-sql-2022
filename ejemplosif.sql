DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ejemplo1 $$
CREATE PROCEDURE sp_ejemplo1()
BEGIN 
	SELECT "Hola mundo";
END $$
DELIMITER ;

CALL sp_ejemplo1();


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_variables_usuario $$
CREATE PROCEDURE sp_variables_usuario()
BEGIN
	SET @var1=@var1*2;
END $$
DELIMITER ;

SET @var1=20;
CALL sp_variables_usuario();
SELECT @var1;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_variables_usuario_text $$
CREATE PROCEDURE sp_variables_usuario_text()
BEGIN
	SET @var2=CONCAT(@var2," y Andrea");
END $$
DELIMITER ;

SET @var2="Juan";
CALL sp_variables_usuario_text();
SELECT @var2;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_variables_usuario1 $$
CREATE PROCEDURE sp_variables_usuario1(INOUT numero INT)
BEGIN
	SET numero=numero*2;
END $$
DELIMITER ;

SET @var1=20;
CALL sp_variables_usuario(@var1);
SELECT @var1;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_condicional $$
CREATE PROCEDURE sp_condicional(IN edad INT)
BEGIN
	IF edad<=30 THEN 
		SELECT  "Joven" AS resultado;
	ELSE
		SELECT "Adulto" AS resultado;
	END IF;
END $$
DELIMITER ;

CALL sp_condicional(13);


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_condicional1 $$
CREATE PROCEDURE sp_condicional1(IN edad INT)
BEGIN
	IF edad<=12 THEN 
		SELECT  "Niño" AS resultado;
	ELSEIF edad<=30 THEN
		SELECT "Joven" AS resultado;
	ELSE
		SELECT "Adulto" AS resultado;
	END IF;
END $$
DELIMITER ;

CALL sp_condicional1(159);