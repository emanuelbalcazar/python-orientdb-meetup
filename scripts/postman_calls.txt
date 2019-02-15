API

--leer lista de alumnos
GET  http://localhost:2480/query/eip/sql/select from Alumno

--agregar alumno
POST http://localhost:2480/document/eip
{
	"@class":	"Alumno",
	 "direccionCasa": {
                "calle": "Mirimande 222",
                "pais": "Colombia"
            },
            "nombre": "Holver Vander",
            "direccionTrabajo": {
                "calle": "Manzanos 200",
                "pais": "Ecuador"
            }
}

--hacer un sql
POST http://localhost:2480/command/eip/sql
{
	"command":	"select nombre, out('dicta').in('matriculadoEn').nombre as alumnoMatriculado from Profesor"
}



--ahora vamos a crear accesos de usuarios
INSERT INTO OUser SET name = 'escribidor', password = 'escribidor', status = 'ACTIVE', roles = (SELECT FROM ORole WHERE name = 'writer');
INSERT INTO OUser SET name = 'lector', password = 'lector', status = 'ACTIVE', roles = (SELECT FROM ORole WHERE name = 'reader');


