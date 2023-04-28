
-- Jhonatan José Acalón Ajanel
-- Código ténico: IN5BM
-- Grupo: 1

DROP DATABASE IF EXISTS empresa;
CREATE DATABASE IF NOT EXISTS empresa
DEFAULT CHARACTER SET utf8 
DEFAULT COLLATE utf8_general_ci;

USE empresa;


-- DDL-------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS regiones;
DROP TABLE IF EXISTS departamentos_guate;
DROP TABLE IF EXISTS oficinas;
DROP TABLE IF EXISTS telefonos;
DROP TABLE IF EXISTS departamentos_empresas;
DROP TABLE IF EXISTS depto_emp_oficinas;
DROP TABLE IF EXISTS tipos_empleados;
DROP TABLE IF EXISTS empleados;

CREATE TABLE IF NOT EXISTS regiones(
	id INT NOT NULL,
    nombre_region VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS departamentos_guate(
	id INT NOT NULL,
    nombre_depto_guate VARCHAR(45) NOT NULL,
    region_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (region_id) REFERENCES regiones (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS oficinas(
	id INT NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    departamentos_guate_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (departamentos_guate_id) REFERENCES departamentos_guate (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS telefonos(
	id INT NOT NULL,
    numero_telefono VARCHAR(8) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS departamentos_empresas(
	id INT NOT NULL,
    nombre_depto_emp VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS depto_emp_oficinas(
	id INT NOT NULL,
    departamento_empresa_id INT NOT NULL,
    oficina_id INT NOT NULL,
    telefono_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (departamento_empresa_id) REFERENCES departamentos_empresas (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (oficina_id) REFERENCES oficinas (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (telefono_id) REFERENCES telefonos (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS tipos_empleados(
	id INT NOT NULL,
    nombre_tipo_empleado VARCHAR(45) NOT NULL,
    sueldo_base DECIMAL(10.2) NOT NULL,
    bonificacion_ley DECIMAL(10.2) NOT NULL,
    bonificacion_empresa DECIMAL(10.2),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS empleados(
	id INT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_contratacion DATE NOT NULL,
    telefono VARCHAR(8),
    tipo_empleado_id INT NOT NULL,
    depto_emp_oficina_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipo_empleado_id) REFERENCES tipos_empleados (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (depto_emp_oficina_id) REFERENCES depto_emp_oficinas (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- DML (INSERT's)-------------------------------------------------------------------------------------------------------------------------------------------
-- Insertando en la tabla regiones
INSERT INTO regiones (id,nombre_region) VALUES (1,"Metropolitana");
INSERT INTO regiones (id,nombre_region) VALUES (2,"Verapaz");
INSERT INTO regiones (id,nombre_region) VALUES (3,"Nororiente");
INSERT INTO regiones (id,nombre_region) VALUES (4,"Suroriente");
INSERT INTO regiones (id,nombre_region) VALUES (5,"Central");
INSERT INTO regiones (id,nombre_region) VALUES (6,"Suroccidente");
INSERT INTO regiones (id,nombre_region) VALUES (7,"Noroccidente");
INSERT INTO regiones (id,nombre_region) VALUES (8,"Petén");

-- Insertando en la tabla departamentos guate
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (1,"Guatemala",1);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (2,"Alta Verapaz",2);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (3,"Baja Verapaz",2);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (4,"Chiquimula",3);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (5,"El Progreso",3);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (6,"Izabal",3);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (7,"Zacapa",3);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (8,"Jutiapa",4);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (9,"Jalapa",4);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (10,"Santa Rosa",4);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (11,"Chimaltenango",5);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (12,"Sacatepéquez",5);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (13,"Escuintla",5);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (14,"Quetzaltenango",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (15,"Retalhuleu",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (16,"San Marcos",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (17,"Suchitepéquez",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (18,"Sololá",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (19,"Totonicapán",6);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (20,"Huehuetenango",7);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (21,"Quiché",7);
INSERT INTO departamentos_guate (id,nombre_depto_guate,region_id) VALUES (22,"Petén",8);

-- Insertando en la tabla oficinas
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (1,"3ra Avenida C 9-30",8);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (2,"4ta Calle D 5-10 Zona 3",20);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (3,"5ta Avenida 8-39 Zona 6",12);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (4,"9na Calle 3ra Avenida 5-30 Zona 8",17);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (5,"7ma Avenida 4-62 Zona 23",7);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (6,"2da Calle B 2-38 Zona 9",10);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (7,"3ra Calle G 8-60 Zona 9",13);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (8,"8va Avenida 2da Calle 9-60 Zona 8",11);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (9,"2da Avenida 7ma Calle 1-30 Zona 4",18);
INSERT INTO oficinas (id,direccion,departamentos_guate_id) VALUES (10,"9na Calle F 8-36 Zona 8",15);

-- Insertando en la tabla telefonos
INSERT INTO telefonos (id,numero_telefono) VALUES (1,"55806855");
INSERT INTO telefonos (id,numero_telefono) VALUES (2,"98305310");
INSERT INTO telefonos (id,numero_telefono) VALUES (3,"41545213");
INSERT INTO telefonos (id,numero_telefono) VALUES (4,"41106591");
INSERT INTO telefonos (id,numero_telefono) VALUES (5,"46556105");
INSERT INTO telefonos (id,numero_telefono) VALUES (6,"54516516");
INSERT INTO telefonos (id,numero_telefono) VALUES (7,"51656546");
INSERT INTO telefonos (id,numero_telefono) VALUES (8,"68465213");
INSERT INTO telefonos (id,numero_telefono) VALUES (9,"63496842");
INSERT INTO telefonos (id,numero_telefono) VALUES (10,"54198465");

-- Insertando en la tabla departamentos empresas
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (1,"Atención al Cliente");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (2,"Servicio al Cliente");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (3,"Contabilidad");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (4,"Administracion");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (5,"Recepcion");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (6,"Area Tecnica");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (7,"Bodega");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (8,"Reparaciones");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (9,"Sala de ventas");
INSERT INTO departamentos_empresas (id,nombre_depto_emp) VALUES (10,"Proyectos");

-- Insertando en la tabla departamentos empresas oficinas
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (1,6,6,8);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (2,8,10,9);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (3,1,7,2);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (4,4,3,10);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (5,2,1,1);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (6,3,5,6);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (7,10,8,5);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (8,7,4,3);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (9,5,9,4);
INSERT INTO depto_emp_oficinas (id,departamento_empresa_id,oficina_id,telefono_id) VALUES (10,9,2,7);

-- Insertando en la tabla tipos empleados
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (1,"Programador",36000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (2,"Contador",38000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (3,"Vendedor",28500,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (4,"Recepcionista",28800,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (5,"Tecnico",30000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (6,"Bodeguero",24000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (7,"Servicio de llamadas",29000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (8,"Jefe de departamento",45000,250,1000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (9,"Arquitecto",38500,250,5000);
INSERT INTO tipos_empleados (id,nombre_tipo_empleado,sueldo_base,bonificacion_ley,bonificacion_empresa) VALUES (10,"Director de departamento",35500,250,1000);

-- Insertando en la tabla empleados
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (1,"Jhonatan","Acalón",'1990-04-15','2030-01-01',"50906678",1,6);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (2,"Pedro","Alvarado",'1980-04-06','2022-07-25',"54545610",5,8);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (3,"Andrea","Gomez",'1970-08-19','2010-12-08',"48613902",4,1);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (4,"Jose","Rosales",'1990-08-25','2010-01-30',"55608799",9,10);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (5,"Jose","Gimenez",'1983-08-30','2030-01-01',"53064920",2,3);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (6,"Nancy","Gonzales",'1985-08-10','2030-01-01',"54632961",6,7);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (7,"Katherine","Fernandez",'1983-05-19','2030-01-01',"65203510",3,9);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (8,"Natalia","Hurtado",'1999-12-30','2022-06-20',"24349165",10,4);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (9,"Carlos","Dominguez",'1993-06-12','2022-07-20',"55406955",7,2);
INSERT INTO empleados (id,nombre,apellido,fecha_nacimiento,fecha_contratacion,telefono,tipo_empleado_id,depto_emp_oficina_id) 
	VALUES (10,"Josefina","Pascal",'1976-08-16','2010-06-25',"52068232",8,4);
    
-- DML (SELECT's)-------------------------------------------------------------------------------------------------------------------------------------------
-- 1) Nombre y edad de los empleados.-------------------------------------------------------------------------------------------------
SELECT e.nombre,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad FROM empleados AS e;

-- 2) Fecha de contratación de cada empleado.-----------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,e.fecha_contratacion AS fecha_de_contratación FROM empleados AS e;

-- 3) Edades de los empleados.--------------------------------------------------------------------------------------------------------
SELECT e.id,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad FROM empleados AS e;

-- 4) Número de empleados que hay para cada una de las edades.------------------------------------------------------------------------
SELECT TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad, COUNT(TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE())) AS cant_personas_p_edad
FROM empleados AS e GROUP BY YEAR(e.fecha_nacimiento);

-- 5) Edad media de los empleados por departamento de empresa.-------------------------------------------------------------------------
SELECT AVG(TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE())) AS edad_media, de.nombre_depto_emp AS departamento_empresa
FROM empleados AS e 
INNER JOIN depto_emp_oficinas AS d
INNER JOIN departamentos_empresas AS de
ON e.depto_emp_oficina_id=d.departamento_empresa_id AND d.departamento_empresa_id=de.id
GROUP BY e.depto_emp_oficina_id
ORDER BY depto_emp_oficina_id;

-- 6) Tipos de Empleados que superan las 35.000 de salario.----------------------------------------------------------------------------
SELECT t.nombre_tipo_empleado,t.sueldo_base AS sueldo FROM tipos_empleados AS t WHERE t.sueldo_base>35000;

-- 7) Datos del empleado número X.-----------------------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,e.fecha_nacimiento,e.fecha_contratacion,e.telefono FROM empleados AS e WHERE e.id=5;

-- 8) Empleados del departamento de empresa X.------------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,e.fecha_nacimiento,e.fecha_contratacion,e.telefono,de.nombre_depto_emp AS departamento_empresa FROM empleados AS e, 
depto_emp_oficinas AS d,departamentos_empresas AS de
WHERE e.depto_emp_oficina_id=1 AND e.depto_emp_oficina_id=d.departamento_empresa_id AND d.departamento_empresa_id=de.id;

-- 9) Empleados cuya contratación se produjo en el año X.-------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,YEAR(e.fecha_contratacion) AS fecha_contratacion FROM empleados AS e WHERE YEAR(e.fecha_contratacion)='2030';

-- 10) Empleados que no sean jefe de Departamento (atributo nombre tipo empleado dentro de la entidad Tipos Empleados) X----------------
SELECT e.id,e.nombre,e.apellido,e.fecha_contratacion,e.telefono,t.nombre_tipo_empleado AS tipo_empleado FROM empleados AS e INNER JOIN 
tipos_empleados AS t ON e.tipo_empleado_id!=8 AND e.tipo_empleado_id=t.id;

-- 11) Empleados contratados entre los años X y X.--------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,YEAR(e.fecha_contratacion) fecha_contratacion FROM empleados AS e WHERE YEAR(e.fecha_contratacion) BETWEEN '2020' AND '2030';

-- 12) Tipos de Empleado que tienen un salario superior a 35.000 e inferior a 40.000.----------------------------------------------------
SELECT t.nombre_tipo_empleado,t.sueldo_base AS sueldo FROM tipos_empleados AS t WHERE t.sueldo_base>35000 AND t.sueldo_base<40000;

-- 13) Empleados cuyo tipo de empleado es director o jefe de sección.---------------------------------------------------------------------
SELECT e.id,e.nombre,e.apellido,e.fecha_contratacion,e.telefono,t.nombre_tipo_empleado AS tipo_empleado FROM empleados AS e INNER JOIN 
tipos_empleados AS t ON e.tipo_empleado_id=10 AND e.tipo_empleado_id=t.id;

-- 14) Empleados de nombre 'Jose'.---------------------------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,e.fecha_nacimiento,e.fecha_contratacion,e.telefono FROM empleados AS e WHERE e.nombre LIKE "Jose";

-- 15) Empleados que pertenecen al departamento administrativo y que tienen una edad mayor a 35 años.--------------------------------------
SELECT e.id,e.nombre,e.apellido,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad
,e.fecha_contratacion,e.telefono,de.nombre_depto_emp AS departamento_empresa
FROM empleados AS e 
INNER JOIN depto_emp_oficinas AS d
INNER JOIN departamentos_empresas AS de
ON e.depto_emp_oficina_id=d.departamento_empresa_id AND d.departamento_empresa_id=de.id AND de.id=4 AND TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE())>35;

-- 16) Empleados que no pertenecen al departamento de la empresa X.-------------------------------------------------------------------------
SELECT e.nombre,e.apellido,e.fecha_nacimiento,e.fecha_contratacion,e.telefono,e.depto_emp_oficina_id
FROM empleados AS e 
INNER JOIN depto_emp_oficinas AS d
INNER JOIN departamentos_empresas AS de
ON e.depto_emp_oficina_id=d.departamento_empresa_id AND d.departamento_empresa_id=de.id AND de.id!=1;

-- 17) Nombre y edad de los empleados ordenados de menor a mayor edad.-----------------------------------------------------------------------
SELECT e.nombre,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad FROM empleados AS e ORDER BY TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) ASC;

-- 18) Nombre y edad de los empleados ordenados por nombre de forma descendente.--------------------------------------------------------------
SELECT e.nombre,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad FROM empleados AS e ORDER BY e.nombre DESC;

-- 19) Nombre del empleado y el departamento de la empresa en la que trabaja.-----------------------------------------------------------------
SELECT e.nombre,de.nombre_depto_emp AS departamento_empresa
FROM empleados AS e 
INNER JOIN depto_emp_oficinas AS d
INNER JOIN departamentos_empresas AS de
ON e.depto_emp_oficina_id=d.departamento_empresa_id AND d.departamento_empresa_id=de.id;

-- 20) Código y teléfonos de los departamentos de las oficinas de la región 'Centro'.----------------------------------------------------------
SELECT d.id,t.numero_telefono
FROM depto_emp_oficinas AS d
INNER JOIN telefonos AS t
INNER JOIN oficinas AS o
INNER JOIN departamentos_guate AS de
INNER JOIN departamentos_empresas AS dep
INNER JOIN regiones AS r
ON r.id=5 AND de.region_id=5 AND o.departamentos_guate_id=de.id AND d.oficina_id=o.id AND d.telefono_id=t.id AND d.departamento_empresa_id=dep.id
ORDER BY d.id;

-- 21) Nombre del empleado y departamento de Guatemala en el que trabaja.-----------------------------------------------------------------------
SELECT e.nombre,de.nombre_depto_guate AS nombre_depto_guate
FROM empleados AS e
INNER JOIN depto_emp_oficinas AS d
INNER JOIN oficinas AS o
INNER JOIN departamentos_guate AS de
ON e.depto_emp_oficina_id=d.id AND d.oficina_id=o.id AND o.departamentos_guate_id=de.id;

-- 22) Sueldo de cada empleado y sus bonificaciones.--------------------------------------------------------------------------------------------
SELECT e.nombre,e.apellido,(t.sueldo_base/12)+t.bonificacion_ley+t.bonificacion_empresa AS sueldo_total_mes
FROM empleados AS e
INNER JOIN tipos_empleados AS t
ON e.tipo_empleado_id=t.id;

-- 23) Nombre de los empleados y de sus jefes de departamento.------------------------------------------------------------------------------------
SELECT e.nombre AS nombre_empleado, e.apellido AS apellido_empleado,j.nombre AS nombre_jefe,j.apellido AS apellido_jefe
FROM empleados AS e 
CROSS JOIN empleados AS j 
ON j.tipo_empleado_id=8  AND e.tipo_empleado_id!=8;

-- 24) Suma del sueldo de los empleados, sin la bonificación.--------------------------------------------------------------------------------------
SELECT SUM(t.sueldo_base) AS sueldo_empleados_anual
FROM empleados AS e
INNER JOIN tipos_empleados AS t
ON e.tipo_empleado_id=t.id;

-- 25) Promedio del sueldo, sin contar bonificación.------------------------------------------------------------------------------------------------
SELECT AVG(t.sueldo_base) AS sueldo_empleados_anual
FROM empleados AS e
INNER JOIN tipos_empleados AS t
ON e.tipo_empleado_id=t.id;

-- 26) Salarios máximo y mínimo de los empleados, incluyendo bonificación.--------------------------------------------------------------------------
SELECT MIN(t.sueldo_base+t.bonificacion_ley+t.bonificacion_empresa) AS salario_minimo_anual,
MAX(t.sueldo_base+t.bonificacion_ley+t.bonificacion_empresa) AS salario_maximo_anual
FROM empleados AS e
INNER JOIN tipos_empleados AS t
ON e.tipo_empleado_id=t.id;

-- 27) Número de empleados que superan los 40 años.--------------------------------------------------------------------------------------------------
SELECT COUNT(e.id) AS cant_empleados_mayores_40
FROM empleados AS e 
WHERE TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE())>40;

-- 28) Número de edades diferentes que tienen los empleados.-----------------------------------------------------------------------------------------
SELECT COUNT(e.id) AS cantidad_emp,TIMESTAMPDIFF(YEAR,e.fecha_nacimiento,CURDATE()) AS edad
FROM empleados AS e 
GROUP BY YEAR(e.fecha_nacimiento);