# coding=utf-8
from flask import Flask, request, render_template
from flask import jsonify
from pprint import pprint
import pyorient
import json

# sitepackages/pyorient/constants.py
# cambiar de 36 a 37
# SUPPORTED_PROTOCOL = 37

app = Flask(__name__)

# solo para pruebas
DATABASE = "meetup"
HOST = "localhost"
PORT = 2424
USER = "root"
PASSWORD = "root"

def get_connection():
    client = pyorient.OrientDB(HOST, PORT)
    session_id = client.connect(USER, PASSWORD)
    client.db_open(DATABASE, USER, PASSWORD)

    return client

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')


@app.route('/api/info', methods=['GET'])
def info():
    client = pyorient.OrientDB(HOST, PORT)
    session_id = client.connect(USER, PASSWORD)
    client.db_open(DATABASE, USER, PASSWORD)

    records = client.query("SELECT name FROM OUser where name = 'admin'")
    client.db_close()

    return jsonify(records[0].oRecordData)


@app.route('/api/profesores', methods=['GET'])
def profesores():
    client = get_connection()
    records = client.query("SELECT FROM Profesor")
    result = [];

    for profesor in records:
        result.append({"id": profesor._rid , "class": profesor._class, "nombre": profesor.oRecordData['nombre']})

    client.db_close()
    return jsonify(result)


@app.route('/api/agregarProfesor', methods=['POST'])
def agregarProfesor():
    data = request.get_json()
    client = get_connection()

    records = client.command("INSERT INTO Profesor CONTENT " + str(data))
    result = records[0]

    client.db_close()
    return jsonify({"id": result._rid , "class": result._class, "nombre": result.oRecordData['nombre']})


@app.route('/api/borrarProfesor/<id>', methods=['DELETE'])
def borrarProfesor(id):
    client = get_connection()
    records = client.command("DELETE FROM Profesor WHERE @rid = #" + id + " unsafe")
    result = records[0]

    client.db_close()
    return jsonify({"deleted": str(result)})


@app.route('/api/actualizarProfesor', methods=['POST'])
def actualizarProfesor():
    data = request.get_json()
    client = get_connection()

    records = client.command("UPDATE Profesor SET nombre = '" + data['nombre'] + "' WHERE @rid = " + data['id'])
    result = records[0]

    client.db_close()
    return jsonify({"updated": str(result)})
