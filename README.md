# Python Orientdb Meetup

Ejemplo de conexion a OrientDB con python, implementado para el python meetup en el Centro Astronomico de Trelew el sabado 09 de marzo de 2019.


## Preparacion

1. Agregar el virtualenv dentro de la carpeta del proyecto: `python3 -m venv .`
2. Ejecutar el script de creación de esquema: `orientdb-3.0.2/bin/console.sh 10_schema.sql`
3. Ejecutar el script de carga de datos: `orientdb-3.0.2/bin/console.sh 20_data.sql`


## Despliegue (Primera vez)

1. Activar el virtualenv: `source ./bin/activate`
2. Actualizar pip: `pip install --upgrade pip wheel`
3. Instalar las dependencias: `pip install -r requirements.txt` 

```bash
export FLASK_APP=src/app.py

python -m flask run
```


## Notas

La libreria [pyorient](https://github.com/mogui/pyorient) se encuentra desactualizada, por lo que no soporta las nuevas versiones de OrientDB > 3.x. Para solucionar este problema se descubrio que era necesario incrementar el valor de una constante de la libreria en `lib/python3.6/sitepackages/pyorient/constants.py` cambiando `SUPPORTED_PROTOCOL = 36` por `SUPPORTED_PROTOCOL = 37`.
