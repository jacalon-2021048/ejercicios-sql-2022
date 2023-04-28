DROP DATABASE IF EXISTS persona_conexion;
CREATE DATABASE persona_conexion;
USE persona_conexion;

CREATE TABLE IF NOT EXISTS usuarios(
    nombre_usu VARCHAR(45) NOT NULL,
    clave_usu VARCHAR(45) NOT NULL,
    PRIMARY KEY(nombre_usu)
);

CREATE TABLE IF NOT EXISTS personas(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    edad INT NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    PRIMARY KEY(id)
);

-- Usuarios------------------------------------------------------------------------------------
INSERT INTO usuarios(nombre_usu,clave_usu) VALUES("jhon","1234");
INSERT INTO usuarios(nombre_usu,clave_usu) VALUES("admin","2345");
INSERT INTO usuarios(nombre_usu,clave_usu) VALUES("pedro","4567");