--***********************************************************
--conectarse a base de datos
--***********************************************************
connect remote:localhost/meetup root root;
script sql
begin;

--insertando profesores
-- aplicando    select sequence('idseq').next()
--
insert into Profesor set id =sequence('idseq').next(), nombre="Merlin";
insert into Profesor set id =sequence('idseq').next(), nombre="Vandel";

--para insertar alumnos nos conviene usar json
INSERT	INTO Alumno CONTENT {
        "nombre": "Hans Kruger", 
        "direccionCasa": {
            "calle":  "Chucuito 333",
            "pais": "Venezuela"
            },
        "direccionTrabajo": {
            "calle":  "Derbes 323",
            "pais": "Croacia"
            }
    };

INSERT INTO Alumno CONTENT {
        "nombre": "Helga Vykena", 
        "direccionCasa": {
            "calle":  "Karlin 222",
            "pais": "Tailandia"
            },
        "direccionTrabajo": {
            "calle":  "Precursores 200",
            "pais": "Finlandia"
            }
    };

--insertar curso
insert into Curso (nombre) values ("Dibujo por computador");
insert into Curso (nombre) values ("Energías renovables");
insert into Curso (nombre) values ("Base de datos");

--crear relaciones entre profesores y cursos
CREATE EDGE dicta FROM 
(SELECT FROM Profesor WHERE	nombre = 'Merlin') 
TO	
(SELECT FROM Curso    WHERE	nombre = 'Base de datos');

--relacionar alumnos y cursos
CREATE EDGE matriculadoEn FROM 
(SELECT FROM Alumno WHERE nombre = 'Helga Vykena') 
TO	
(SELECT FROM Curso);

CREATE EDGE matriculadoEn FROM 
(SELECT FROM Alumno WHERE nombre = 'Hans Kruger') 
TO	
(SELECT FROM Curso where nombre ='Base de datos');

commit;
end
