DROP DATABASE IF EXISTS control_academico_in5bm;
CREATE DATABASE IF NOT EXISTS control_academico_in5bm
DEFAULT CHARACTER SET utf8 
DEFAULT COLLATE utf8_general_ci;

USE control_academico_in5bm;

DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS instructores;
DROP TABLE IF EXISTS salones;
DROP TABLE IF EXISTS carreras_tecnicas;
DROP TABLE IF EXISTS horarios;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS asignaciones_alumnos;

CREATE TABLE IF NOT EXISTS alumnos(
	carne VARCHAR(16) NOT NULL,
    nombre1 VARCHAR(15) NOT NULL,
    nombre2 VARCHAR(15) NULL,
    nombre3 VARCHAR(15) NULL,
    apellido1 VARCHAR(15) NOT NULL,
	apellido2 VARCHAR(15) NULL,
    PRIMARY KEY(carne)
);

CREATE TABLE IF NOT EXISTS instructores(
	id INT NOT NULL AUTO_INCREMENT,
    nombre1 VARCHAR(15) NOT NULL,
    nombre2 VARCHAR(15) NULL,
    nombre3 VARCHAR(15) NULL,
    apellido1 VARCHAR(15) NOT NULL,
	apellido2 VARCHAR(15) NULL,
    direccion VARCHAR(45) NULL,
    email VARCHAR(45) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    fecha_nacimiento DATE NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS salones(
	codigo_salon VARCHAR(5) NOT NULL,
    descripcion VARCHAR(45) NULL,
    capacidad_maxima INT NOT NULL,
    edificio VARCHAR(15) NULL,
    nivel INT NULL,
    PRIMARY KEY (codigo_salon)
);

CREATE TABLE IF NOT EXISTS carreras_tecnicas(
	codigo_tecnico VARCHAR(6) NOT NULL,
    carrera VARCHAR(45) NOT NULL,
    grado VARCHAR(10) NOT NULL,
    seccion CHAR(1) NOT NULL,
    jornada VARCHAR(10) NOT NULL,
    PRIMARY KEY (codigo_tecnico)
);

CREATE TABLE IF NOT EXISTS horarios(
	id INT NOT NULL AUTO_INCREMENT,
    horario_inicio TIME NOT NULL,
    horario_final TIME NOT NULL,
    lunes TINYINT(1) NULL,
    martes TINYINT(1) NULL,
    miercoles TINYINT(1) NULL,
    jueves TINYINT(1) NULL,
    viernes TINYINT(1) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cursos(
	id INT NOT NULL AUTO_INCREMENT,
    nombre_curso VARCHAR(255) NOT NULL,
    ciclo YEAR NULL,
    cupo_maximo INT NULL,
    cupo_minimo INT NULL,
	carrera_tecnica_id 	VARCHAR(128) NOT NULL,
    horario_id INT NOT NULL,
    instructor_id INT NOT NULL,
    salon_id VARCHAR(5) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_cursos_carreras_tecnicas
		FOREIGN KEY (carrera_tecnica_id)
		REFERENCES carreras_tecnicas (codigo_tecnico)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_cursos_horarios
		FOREIGN KEY (horario_id)
        REFERENCES horarios (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_cursos_instructores
		FOREIGN KEY (instructor_id)
		REFERENCES instructores (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_cursos_salones
		FOREIGN KEY (salon_id)
        REFERENCES salones (codigo_salon)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS asignaciones_alumnos(
	id VARCHAR(45) NOT NULL,
    alumno_id VARCHAR(16) NOT NULL,
    curso_id INT NOT NULL,
    fecha_asignacion DATETIME NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_asignaciones_alumnos_alumno
		FOREIGN KEY (alumno_id)
        REFERENCES alumnos (carne)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_asignaciones_alumnos_curso
		FOREIGN KEY (curso_id)
        REFERENCES cursos (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- CRUD entidad alumnos----------------------------------------------------------------------------------------------------------------
-- CREATE alumnos
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_alumnos_create $$
CREATE PROCEDURE sp_alumnos_create(
	IN _carne VARCHAR(16),
    IN _nombre1 VARCHAR(15),
    IN _nombre2 VARCHAR(15),
    IN _nombre3 VARCHAR(15),
    IN _apellido1 VARCHAR(15),
    IN _apellido2 VARCHAR(15)
)
BEGIN
	INSERT INTO alumnos(
		carne,
        nombre1,
        nombre2,
        nombre3,
        apellido1,
        apellido2
    )
	VALUES
	(
		_carne,
		_nombre1,
		_nombre2,
		_nombre3,
		_apellido1,
		_apellido2
    );
END $$
DELIMITER ;

-- READ alumnos
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_alumnos_read $$
CREATE PROCEDURE sp_alumnos_read()
BEGIN
	SELECT
		alumnos.carne,
        alumnos.nombre1,
        alumnos.nombre2,
        alumnos.nombre3,
        alumnos.apellido1,
        alumnos.apellido2
	FROM
		alumnos;
END $$
DELIMITER ;

-- UPDATE alumnos
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_alumnos_update $$
CREATE PROCEDURE sp_alumnos_update(
	IN _carne VARCHAR(16),
    IN _nombre1 VARCHAR(15),
    IN _nombre2 VARCHAR(15),
    IN _nombre3 VARCHAR(15),
    IN _apellido1 VARCHAR(15),
    IN _apellido2 VARCHAR(15)
)
BEGIN
	UPDATE 
		alumnos
    SET 
		alumnos.nombre1=_nombre1,
        alumnos.nombre2=_nombre2,
        alumnos.nombre3=_nombre3,
        alumnos.apellido1=_apellido1,
        alumnos.apellido2=_apellido2
	WHERE
		alumnos.carne=_carne;
END$$
DELIMITER ;

-- DELETE alumnos
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_alumnos_delete $$
CREATE PROCEDURE sp_alumnos_delete(
	IN _carne VARCHAR(16)
)
BEGIN
	DELETE FROM
		alumnos
	WHERE
		alumnos.carne=_carne;
END$$
DELIMITER ;

-- CRUD entidad instructores----------------------------------------------------------------------------------------------------------------
-- CREATE instructores
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_instructores_create $$
CREATE PROCEDURE sp_instructores_create(
	IN _nombre1 VARCHAR(15),
    IN _nombre2 VARCHAR(15),
    IN _nombre3 VARCHAR(15),
    IN _apellido1 VARCHAR(15),
	IN _apellido2 VARCHAR(15),
    IN _direccion VARCHAR(45),
    IN _email VARCHAR(45),
    IN _telefono VARCHAR(8),
    IN _fecha_nacimiento DATE
)
BEGIN
	INSERT INTO instructores(
		nombre1,
        nombre2,
        nombre3,
        apellido1,
        apellido2,
        direccion,
        email,
        telefono,
        fecha_nacimiento
    )
    VALUES
    (
		_nombre1,
        _nombre2,
        _nombre3,
        _apellido1,
        _apellido2,
        _direccion,
        _email,
        _telefono,
        _fecha_nacimiento
    );
END$$
DELIMITER ;

-- READ instructores
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_instructores_read $$
CREATE PROCEDURE sp_instructores_read()
BEGIN
	SELECT
		instructores.id,
        instructores.nombre1,
        instructores.nombre2,
        instructores.nombre3,
        instructores.apellido1,
        instructores.apellido2,
        instructores.direccion,
        instructores.email,
        instructores.telefono,
        instructores.fecha_nacimiento
	FROM
		instructores;
END$$
DELIMITER ;

-- UPDATE instructores
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_instructores_update $$
CREATE PROCEDURE sp_instructores_update(
	IN _id INT,
	IN _nombre1 VARCHAR(15),
    IN _nombre2 VARCHAR(15),
    IN _nombre3 VARCHAR(15),
    IN _apellido1 VARCHAR(15),
	IN _apellido2 VARCHAR(15),
    IN _direccion VARCHAR(45),
    IN _email VARCHAR(45),
    IN _telefono VARCHAR(8),
    IN _fecha_nacimiento DATE	
)
BEGIN
	UPDATE
		instructores
	SET
		instructores.nombre1=_nombre1,
        instructores.nombre2=_nombre2,
        instructores.nombre3=_nombre3,
        instructores.apellido1=_apellido1,
        instructores.apellido2=_apellido2,
        instructores.direccion=_direccion,
        instructores.email=_email,
        instructores.telefono=_telefono,
        instructores.fecha_nacimiento=_fecha_nacimiento
	WHERE
		instructores.id=_id;
END$$
DELIMITER ;

-- DELETE instructores
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_instructores_delete $$
CREATE PROCEDURE sp_instructores_delete(
	IN _id INT
)
BEGIN
	DELETE FROM
		instructores
	WHERE
		instructores.id=_id;
END$$
DELIMITER ;

-- CRUD entidad salones----------------------------------------------------------------------------------------------------------------
-- CREATE salones
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_salones_create $$
CREATE PROCEDURE sp_salones_create(
	IN _codigo_salon VARCHAR(5),
    IN _descripcion VARCHAR(45),
    IN _capacidad_maxima INT,
    IN _edificio VARCHAR(15),
    IN _nivel INT
)
BEGIN
	INSERT INTO salones(
		codigo_salon,
        descripcion,
        capacidad_maxima,
        edificio,
        nivel
    )
    VALUES
    (
		_codigo_salon,
        _descripcion,
        _capacidad_maxima,
        _edificio,
        _nivel
    );
END $$
DELIMITER ;

-- READ salones
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_salones_read $$
CREATE PROCEDURE sp_salones_read()
BEGIN
	SELECT
		salones.codigo_salon,
        salones.descripcion,
		salones.capacidad_maxima,
        salones.edificio,
        salones.nivel
	FROM
		salones;
END$$
DELIMITER ;

-- UPDATE salones
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_salones_update $$
CREATE PROCEDURE sp_salones_update(
	IN _codigo_salon VARCHAR(5),
    IN _descripcion VARCHAR(45),
    IN _capacidad_maxima INT,
    IN _edificio VARCHAR(15),
    IN _nivel INT
)
BEGIN
	UPDATE
		salones
	SET
        salones.descripcion=_descripcion,
        salones.capacidad_maxima=_capacidad_maxima,
        salones.edificio=_edificio,
        salones.nivel=_nivel
	WHERE
		salones.codigo_salon=_codigo_salon;
END$$
DELIMITER ;

-- DELETE salones
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_salones_delete $$
CREATE PROCEDURE sp_salones_delete(
	IN _codigo_salon VARCHAR(5)
)
BEGIN
	DELETE FROM
		salones
	WHERE
		salones.codigo_salon=_codigo_salon;
END$$
DELIMITER ;

-- CRUD entidad carreras_tecnicas----------------------------------------------------------------------------------------------------------------
-- CREATE carreras_tecnicas
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_carreras_tecnicas_create $$
CREATE PROCEDURE sp_carreras_tecnicas_create(
	IN _codigo_tecnico VARCHAR(6),
    IN _carrera VARCHAR(45),
    IN _grado VARCHAR(10),
    IN _seccion CHAR(1),
    IN _jornada VARCHAR(10)
)
BEGIN
	INSERT INTO carreras_tecnicas(
		codigo_tecnico,
		carrera,
        grado,
        seccion,
        jornada
    )
	VALUES
    (
		_codigo_tecnico,
		_carrera,
        _grado,
        _seccion,
        _jornada		
    );
END$$
DELIMITER ;

-- READ carreras_tecnicas
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_carreras_tecnicas_read $$
CREATE PROCEDURE sp_carreras_tecnicas_read()
BEGIN
	SELECT
		carreras_tecnicas.codigo_tecnico,
        carreras_tecnicas.carrera,
        carreras_tecnicas.grado,
        carreras_tecnicas.seccion,
        carreras_tecnicas.jornada
	FROM
		carreras_tecnicas;	
END$$
DELIMITER ;

-- UPDATE carreras_tecnicas
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_carreras_tecnicas_update $$
CREATE PROCEDURE sp_carreras_tecnicas_update(
	IN _codigo_tecnico VARCHAR(6),
    IN _carrera VARCHAR(45),
    IN _grado VARCHAR(10),
    IN _seccion CHAR(1),
    IN _jornada VARCHAR(10)
)
BEGIN
	UPDATE
		carreras_tecnicas
	SET
		carreras_tecnicas.carrera=_carrera,
        carreras_tecnicas.grado=_grado,
        carreras_tecnicas.seccion=_seccion,
        carreras_tecnicas.jornada=_jornada
	WHERE
		carreras_tecnicas.codigo_tecnico=_codigo_tecnico;
END$$
DELIMITER ;

-- DELETE carreras_tecnicas
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_carreras_tecnicas_delete $$
CREATE PROCEDURE sp_carreras_tecnicas_delete(
	IN _codigo_tecnico VARCHAR(6)
)
BEGIN
	DELETE FROM
		carreras_tecnicas
	WHERE
		carreras_tecnicas.codigo_tecnico=_codigo_tecnico;	
END$$
DELIMITER ;

-- CRUD entidad horarios----------------------------------------------------------------------------------------------------------------
-- CREATE horarios