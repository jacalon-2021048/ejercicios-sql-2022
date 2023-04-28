DROP DATABASE IF EXISTS db_trigger_jhonatan_acalon;
CREATE DATABASE IF NOT EXISTS db_trigger_jhonatan_acalon;

USE db_trigger_jhonatan_acalon;

/*
-- EJEMPLO UPDATE TRIGER
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users(
	user_name VARCHAR(30) NOT NULL,
	pass VARCHAR(30) NOT NULL,
    PRIMARY KEY (user_name)
);

DROP TABLE IF EXISTS previous_password;
CREATE TABLE IF NOT EXISTS previous_password(
	id INT AUTO_INCREMENT NOT NULL,
    user_name VARCHAR(30) NOT NULL,
    pass_old VARCHAR(30) NOT NULL,
    pass_new VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO users (user_name,pass) VALUES ("jhonatan","12345");

DELIMITER $$
DROP TRIGGER IF EXISTS tr_users_before_update$$
CREATE TRIGGER tr_users_before_update 
BEFORE UPDATE 
ON users 
FOR EACH ROW
BEGIN
	INSERT INTO previous_password (user_name,pass_old,pass_new) 
    VALUES (OLD.user_name,OLD.pass,NEW.pass);
END$$
DELIMITER ;

UPDATE users SET pass="admin" WHERE user_name="jhonatan";

UPDATE users SET pass="aDmin7!" WHERE user_name="jhonatan";

SELECT * FROM users;

SELECT * FROM previous_password;

UPDATE users SET pass="R00t$" WHERE user_name="jhonatan";*/

-- CREACION DE LAS TABLAS
DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros(
	id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(45),
    autor VARCHAR(45),
    editorial VARCHAR(45),
    precio DECIMAL(6,2),
    stock INT,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ventas;
CREATE TABLE IF NOT EXISTS ventas(
	id INT NOT NULL AUTO_INCREMENT,
    precio DECIMAL(6,2),
	cantidad INT,
    libros_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_ventas_libros
		FOREIGN KEY (libros_id)
			REFERENCES libros(id)
);

-- INSERCIONES TABLA LIBROS
INSERT INTO libros (titulo,autor,editorial,precio,stock)
VALUES ("Clean code","Robert C. Martin","Multimedia",194.67,5);

INSERT INTO libros (titulo,autor,editorial,precio,stock)
VALUES ("Java para novatos","Voz mediano","Save creative",130.00,10);

INSERT INTO libros (titulo,autor,editorial,precio,stock)
VALUES ("Coders at work","Peter Seibel","Apress",183.91,11);

INSERT INTO libros (titulo,autor,editorial,precio,stock)
VALUES ("Programacion en C","Luis Aguilar","MC Grall Gill",210.25,8);

-- EJEMPLO TRIGGER PARA REDUCIR EL STOCK CUANDO SE PRODUZCA UNA VENTA
DELIMITER $$
DROP TRIGGER IF EXISTS tr_ventas_before_insert$$
CREATE TRIGGER tr_ventas_before_insert
BEFORE INSERT
ON ventas
FOR EACH ROW
BEGIN
	UPDATE libros SET stock=stock-NEW.cantidad
    WHERE NEW.libros_id=libros.id;
END$$
DELIMITER ;


INSERT INTO ventas (precio,cantidad,libros_id)
VALUES (260,2,2);


SELECT * FROM libros;

-- EJEMPLO TRIGGER PARA INCREMENTAR EL STOCK CUANDO HAYA ELIMINACION DE REGISTROS EN LA TABLA VENTAS (DELETE TRIGER)
DELIMITER $$
DROP TRIGGER IF EXISTS tr_ventas_before_delete$$
CREATE TRIGGER tr_ventas_before_delete
BEFORE DELETE 
ON ventas
FOR EACH ROW
BEGIN
	UPDATE libros SET stock=stock+OLD.cantidad
    WHERE OLD.libros_id=libros.id;	
END$$
DELIMITER ;

DELETE FROM ventas WHERE id=1;

SELECT * FROM libros;
SELECT * FROM ventas;