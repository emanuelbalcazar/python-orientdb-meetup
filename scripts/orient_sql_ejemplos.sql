/* PRIMEROS EJEMPLOS */

-- traigo los usuarios
SELECT FROM OUser

-- selecciono un atributo
SELECT Version FROM DBInfo

-- selecciono un registro por su ID
SELECT FROM #5:0

-- selecciono por un conjunto de ids
SELECT FROM [#10:1, #10:30, #10:5]

-- clausula Where
SELECT FROM OUser WHERE name = 'admin'

SELECT FROM OUser WHERE name <> 'admin'

-- ordenamiento descendente
SELECT FROM Countries ORDER BY Id DESC

-- limites
SELECT FROM Countries  LIMIT 20
SELECT FROM Countries SKIP 20 LIMIT 20
SELECT FROM Countries  SKIP 40 LIMIT 20

-- selecciono y cuento los tipos de atracciones
SELECT Type, COUNT(Type) FROM Attractions GROUP BY Type

-- año de nacimiento de los perfiles, y cuantos nacieron el mismo año
SELECT  COUNT (*) as NumberOfProfiles, 
Birthday.format('yyyy') AS YearOfBirth
FROM Profiles
GROUP BY YearOfBirth 
ORDER BY NumberOfProfiles DESC

/* OPERACIONES ABM */

-- el clasico insert de sql
INSERT INTO Locations(Name, Type) VALUES ('Madryn', 'hostel')

-- insert utilizando SET para definir los atributos y valores
INSERT INTO Locations SET Name='Madryn', Type='hostel'

-- insert con JSON, util para el mapeo de clases
INSERT INTO Locations CONTENT {Name: 'Madryn', Type: 'hostel'}

-- update con SET
UPDATE Locations SET Type='albergue' WHERE Name='Madryn'

-- update con MERGE
UPDATE Locations MERGE {Type: 'albergue'} WHERE Name='Madryn'

-- delete, baia baia hay un vertex por aca...
DELETE VERTEX FROM Locations WHERE Name='Madryn' UNSAFE


-- que hacen?
SELECT FROM Profiles WHERE Email LIKE '%.com'

SELECT FROM Profiles WHERE Email.right(3) = 'org'

SELECT FROM Profiles WHERE ANY() LIKE '%vogolo%'


-- convierto a mayusculas los nombres obtenidos
SELECT Name.toUppercase() FROM Profiles

/* FUNCIONES */

-- creamos la funcion para concatenar dos parametros
CREATE FUNCTION concatenar "return a.concat(b)" PARAMETERS [a,b] LANGUAGE JAVASCRIPT

SELECT concatenar('hola ', 3) as resultado

-- creamos la funcion que devuelve todos los hosteles
CREATE FUNCTION hosteles "SELECT Name, Type FROM Services WHERE Type = 'hostel'" LANGUAGE SQL

CREATE FUNCTION hosteles "SELECT Name, Type FROM Services WHERE Type = 'hostel'" IDEMPOTENT TRUE LANGUAGE SQL 

SELECT hosteles() as hosteles

-- accedemos a la base de datos desde una funcion javascript

var username = username;
var db = orient.getDatabase();
var user = db.query("select from OUser where name = ?", username);
var roles = db.query("select from ORole");

if (user && user.length > 0)
	return response.send(500, "El usuario ya existe", "text/plain", "Error: el usuario ya existe con el nombre: " + username);

db.begin();
try {
	var result = db.save({ "@class" : "OUser", name : username, password : "secret", status: "ACTIVE", roles: roles });
    db.commit();
    return result;
} catch (err) {
   	db.rollback();
	return response.send(500, "Error al crear un nuevo usuario", "text/plain", err.toString());
}

-- crear una función que sume dos números (acá no esta escrita)
-- crear una función que devuelva el mayor entre dos números (se puede hacer en una línea!) (ayuda: operador ternario)

/* PETICIONES HTTP */

-- Recuerden poner en la pestaña "Authorization" -> "Basic Auth" -> su usuario y contraseña en Postman.

-- GET - llamamos a las funciones creadas
http://localhost:2480/function/demodb/toUpperCase/<name>

http://localhost:2480/function/demodb/mayor/3/5

http://localhost:2480/function/demodb/concatenar/3/5

http://localhost:2480/function/demodb/hosteles


-- POST - creamos una funcion desde una peticion HTTP
http://localhost:2480/document/demodb

{
	"@class": "OFunction",
	"idempotent": true,
	"code": "return text.toLowerCase();",
    "name": "toLowerCase",
    "language": "Javascript",
    "parameters": [
        "text"
    ]
}

-- GET - traemos la info de la db
http://localhost:2480/query/demodb/sql/select from DBInfo


-- POST - ejecutamos una consulta sql
http://localhost:2480/command/demodb/sql

-- trae todos los servicios de la base
{
	"command": "SELECT Name, Type FROM Services"
}

-- trae todos los servicios de la base que cumplan con la condicion
{
	"command": "SELECT Name, Type FROM Services WHERE Type=:type",
	"parameters": {
		"type": "hostel"
	}
}

-- POST - agregamos un nuevo pais
http://localhost:2480/document/demodb

{
	"@class": "Countries",
    "Name": "Argentina"
}

-- GET - obtenemos el pais
-- ejemplo: http://localhost:2480/document/demodb/33:0
http://localhost:2480/document/demodb/<id>


-- PUT - actualizar el pais
http://localhost:2480/document/demodb/<id>

{
  "@class": "Countries",
    "Name": "Argentinaaaaaa"
}

-- DELETE - elimino el pais
http://localhost:2480/document/demodb/<id>

-- Podemos obtener información sobre una clase en particular.
http://localhost:2480/class/demodb/Services
