--***********************************************************
--conectarse a base de datos
--***********************************************************
connect remote:localhost/meetup root root;

--secuencia
CREATE SEQUENCE idseq TYPE ORDERED;

--clases simples
create class Direccion;
create property Direccion.calle  STRING;
create property Direccion.pais   STRING;

--clases vertex
create class Profesor extends V;
create property Profesor.id                  LONG;
create property Profesor.nombre  STRING;

create class Alumno extends V;
create property Alumno.nombre              STRING;
create property Alumno.direccionCasa       embedded Direccion;
create property Alumno.direccionTrabajo    embedded Direccion;

create class Curso extends V;
create property Curso.nombre     STRING;

--clases edge
create class matriculadoEn extends E;
create property matriculadoEn.out LINK Alumno;
create property matriculadoEn.in  LINK Curso;

create class dicta extends E;
create property dicta.out LINK Profesor;
create property dicta.in  LINK Curso;
