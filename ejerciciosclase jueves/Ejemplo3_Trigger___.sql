
DROP DATABASE IF EXISTS db_test_trigger;
CREATE DATABASE db_test_trigger;

USE db_test_trigger;

CREATE TABLE productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    costo FLOAT NOT NULL DEFAULT 0.0,
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY PK_id (id)
);

INSERT INTO productos (nombre, costo, precio) 
VALUES ('Producto A', 4, 8); 
INSERT INTO productos (nombre, costo, precio) 
VALUES('Producto B', 2, 4);
INSERT INTO productos (nombre, costo, precio) 
VALUES('Producto C', 40, 80);

SELECT * FROM productos;

DELIMITER $$
DROP TRIGGER IF EXISTS tr_productos_before_update$$
CREATE TRIGGER tr_productos_before_update
BEFORE UPDATE
ON productos
FOR EACH ROW
BEGIN
	SET NEW.precio=NEW.costo*2;	
END$$
DELIMITER ;

UPDATE productos SET costo=20 WHERE id=2;

SELECT * FROM productos