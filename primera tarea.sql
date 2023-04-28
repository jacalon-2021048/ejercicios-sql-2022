drop database if exists control_academico_in5bm;
create database control_academico_in5bm;
use control_academico_in5bm;

drop table if exists alumno;
create table if not exists alumno(
	carne varchar(16) not null,
    nombres varchar(45),
    apellidos varchar(45),
    email varchar(32),
	primary key(carne)
);

drop table if exists horarios;
create table if not exists horarios(
	id int not null auto_increment,
    horario_inicial time not null,
    horario_final time not null,
    primary key (id)
);

drop table if exists salones;
create table if not exists salones(
	id int not null auto_increment,
    capacidad int, 
    descripcion varchar(255),
    nombre_salon varchar(255),
    primary key (id)
);

drop table if exists carreras_tecnicas;
create table if not exists carreras_tecnicas(
	id varchar(128),
    nombre varchar(45),
    primary key(id)
);

drop table if exists instructores;
create table if not exists instructores(
	id int not null auto_increment,
    nombres varchar(45),
    apellidos varchar(45),
    direccion varchar(45),
    telefono varchar(45),
    primary key(id)
);

drop table if exists curso;
create table if not exists curso(
	id int not null auto_increment,
    ciclo year,
    cupo_maximo int,
    cupo_minimo int,
    descripcion varchar(255),
    carrera_tecnica_id varchar(128) not null,
    horario_id int not null,
    instructor_id int not null,
    salon_id int not null,
    primary key (id),
    constraint fk_cursos_carreras_tecnicas
		foreign key (carrera_tecnica_id)
		references carreras_tecnicas (id)
		on delete cascade on update cascade,
	constraint fk_cursos_horarios
		foreign key (horario_id)
        references horarios(id)
        on delete cascade on update cascade,
	constraint fk_cursos_instructores
		foreign key (instructor_id)
		references instructores(id)
		on delete cascade on update cascade,
	constraint fk_cursos_salones
		foreign key (salon_id)
        references salones(id)
        on delete cascade on update cascade
);

drop table if exists asignaciones_alumnos;
create table if not exists asignaciones_alumnos(
	id varchar(45),
    fecha_asignacion datetime,
    alumno_carne varchar(16) not null,
    curso_id int not null,
    primary key (id),
    constraint fk_asignaciones_alumnos_alumno
		foreign key (alumno_carne)
        references alumno(carne)
        on delete cascade on update cascade,
	constraint fk_asignaciones_alumnos_curso
		foreign key (curso_id)
        references curso(id)
        on delete cascade on update cascade
);

-- alumnos----------------------------------------------------------------------------------------------------------------------------
insert into alumno(carne,nombres,apellidos,email) 
values ("2021048","Jhonatan","Acalon","jacalon-2021048@kinal.edu.gt");

insert into alumno(carne,nombres,apellidos,email) 
values ("2021095","Pedro","Agustin","pagustin-2021095@kinal.edu.gt");

insert into alumno(carne,nombres,apellidos,email) 
values ("2021950","Andres","Gomez","agomez-2021950@kinal.edu.gt");

insert into alumno(carne,nombres,apellidos,email) 
values ("2021465","Gabriel","Bustamante","gbustamante-2021465@kinal.edu.gt");

insert into alumno(carne,nombres,apellidos,email) 
values ("2021564","Pablo","Gonzalez","pgonzalez-2021564@kinal.edu.gt");

insert into alumno(carne,nombres,apellidos,email) 
values ("2021075","Guillermo","Salinas","gsalinas-2021075@kinal.edu.gt");

update alumno set nombres="Jose",apellidos="Andrade",email="jandrade-2021048@kinal.edu.gt" where carne="2021048";

delete from alumno where carne="2021075";

select alumno.carne,alumno.nombres,alumno.apellidos,alumno.email from alumno;

-- horarios----------------------------------------------------------------------------------------------------------------------------
insert into horarios(horario_inicial,horario_final)
values ('07:05:00','12:05:00');

insert into horarios(horario_inicial,horario_final)
values ('07:05:00','07:40:00');

insert into horarios(horario_inicial,horario_final)
values ('07:40:00','08:15:00');

insert into horarios(horario_inicial,horario_final)
values ('08:15:00','08:50:00');

insert into horarios(horario_inicial,horario_final)
values ('18:50:00','09:25:00');

insert into horarios(horario_inicial,horario_final)
values ('09:25:00','10:20:00');

update horarios set horario_inicial='07:00:00',horario_final='11:35:00' where id=1;

delete from horarios where id=4;

select horarios.id,horarios.horario_inicial,horarios.horario_final from horarios;

-- salones----------------------------------------------------------------------------------------------------------------------------
insert into salones(capacidad,descripcion,nombre_salon)
values (250,"Salon para trabajos varios","Uso variado");

insert into salones(capacidad,descripcion,nombre_salon)
values (65,"Salon para trabajos de carpinteria","Carpinteria");

insert into salones(capacidad,descripcion,nombre_salon)
values (250,"Salon para electricidad","Electricidad");

insert into salones(capacidad,descripcion,nombre_salon)
values (500,"Salon para trabajos mecanicos","Mecanicas");

insert into salones(capacidad,descripcion,nombre_salon)
values (250,"Salon para informatica","Informatica");

insert into salones(capacidad,descripcion,nombre_salon)
values (950,"Salon para recreacion","Salon general");

update salones set capacidad=350,descripcion="Salon para mecanica",nombre_salon="Mecanica" where id=4;

delete from salones where id=2;

select salones.id,salones.capacidad,salones.descripcion,salones.nombre_salon from salones;

-- carreras tecnicas-------------------------------------------------------------------------------------------------------------------
insert into carreras_tecnicas(id,nombre)
values ("comp","Informatica");

insert into carreras_tecnicas(id,nombre)
values ("elec","Electricidad");

insert into carreras_tecnicas(id,nombre)
values ("meca","Mecanica");

insert into carreras_tecnicas(id,nombre)
values ("dibu","Dibujo");

insert into carreras_tecnicas(id,nombre)
values ("tron","Electronica");

insert into carreras_tecnicas(id,nombre)
values ("carp","Carpinteria");

update carreras_tecnicas set nombre="Computacion" where id="comp";

delete from carreras_tecnicas where id="carp";

select carreras_tecnicas.id,carreras_tecnicas.nombre from carreras_tecnicas;

-- instructores------------------------------------------------------------------------------------------------------------------------
insert into instructores(nombres,apellidos,direccion,telefono)
values ("Pedro","Gomez","ciudad zona 2","4458-8653");

insert into instructores(nombres,apellidos,direccion,telefono)
values (null,null,null,null);

insert into instructores(nombres,apellidos,direccion,telefono)
values ("Rodrigo","Nandes","villa nueva zona 5","4564-5662");

insert into instructores(nombres,apellidos,direccion,telefono)
values ("Lucas","Martinelli","mixco zona 9","5549-9851");

insert into instructores(nombres,apellidos,direccion,telefono)
values ("Daniel","Perez","ciudad zona 7","4864-9875");

insert into instructores(nombres,apellidos,direccion,telefono)
values ("Samuel","Valdez","villa nueva zona 2","8569-4560");

update instructores set nombres="Keneth",apellidos="Fernandez",direccion="mixco zona 5",telefono="4658-8965" where id=2;

delete from instructores where id=1;

select instructores.id,instructores.nombres,instructores.apellidos,instructores.direccion,instructores.telefono from instructores;

-- curso----------------------------------------------------------------------------------------------------------------------------
insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2022,40,10,"Tecnologia II","comp",2,4,5);

insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2022,45,15,"Dibujo Artistico","dibu",6,2,1);

insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2022,35,10,"Motores II","meca",1,3,4);

insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2022,90,10,"Conectores electricos II","elec",3,5,3);

insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2021,40,10,"Diseño de maquetas II","tron",2,4,1);

insert into curso(ciclo,cupo_maximo,cupo_minimo,descripcion,carrera_tecnica_id,horario_id,instructor_id,salon_id)
values(2022,40,10,"Mecanica I","meca",3,2,3);

update curso set cupo_maximo=50,cupo_minimo=15,descripcion="Electronica II",carrera_tecnica_id="tron"
	,horario_id=1,instructor_id=4,salon_id=6 where id=6;

delete from curso where ciclo=2021;

select curso.id,curso.ciclo,curso.cupo_maximo,curso.cupo_minimo,curso.descripcion,
	curso.carrera_tecnica_id,curso.horario_id,curso.instructor_id,curso.salon_id from curso;

-- asignaciones_alumnos-----------------------------------------------------------------------------------------------------------------
insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("IN5TEBM2022",'2022-01-10 05:15:05',"2021048",1);

insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("ELE5ELBM2022",'2022-01-11 11:10:00',"2021465",6);

insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("DB5DABM2022",'2022-01-05 07:10:50',"2021564",2);

insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("ElECT5COBM2022",'2022-01-01 12:55:12',"2021048",1);

insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("ME5MOBM2022",'2022-02-15 06:52:45',"2021950",3);

insert into asignaciones_alumnos(id,fecha_asignacion,alumno_carne,curso_id)
values("IN4TEBM2021",'2021-01-06 20:59:05',"2021950",1);

update asignaciones_alumnos set fecha_asignacion='2022-02-08 13:53:50',alumno_carne="2021095",curso_id=4 where id="ElECT5COBM2022";

delete from asignaciones_alumnos where id="IN4TEBM2021";

select asignaciones_alumnos.id,asignaciones_alumnos.fecha_asignacion
	,asignaciones_alumnos.alumno_carne,asignaciones_alumnos.curso_id from asignaciones_alumnos;