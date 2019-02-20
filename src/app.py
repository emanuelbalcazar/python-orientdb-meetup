# coding=utf-8
from flask import Flask, request
from flask import jsonify
from pprint import pprint
import pyorient
import json

# sitepackages/pyorient/constants.py
# cambiar de 36 a 37
# SUPPORTED_PROTOCOL = 37

app = Flask(__name__)

# solo para pruebas
DATABASE = "demodb"
HOST = "localhost"
PORT = 2424
USER = "root"
PASSWORD = "root"

@app.route('/', methods=['GET'])
def hello_world():
    return 'Hello World!'


@app.route('/api/info', methods=['GET'])
def info():
    client = pyorient.OrientDB(HOST, PORT)
    session_id = client.connect(USER, PASSWORD)
    client.db_open(DATABASE, USER, PASSWORD)

    records = client.query("SELECT name FROM OUser where name = 'admin'")
    client.db_close()

    return jsonify(records[0].oRecordData)


@app.route('/api/nodes', methods=['GET'])
def get_nodes():
    client = pyorient.OrientDB(HOST, PORT)
    session_id = client.connect(USER, PASSWORD)
    client.db_open(DATABASE, USER, PASSWORD)

    records = client.query("SELECT FROM V")
    result = [];

    for node in records:
        result.append({"id": node._rid, "label": node.oRecordData['Name']})

    client.db_close()
    return jsonify(result)


@app.route('/api/edges', methods=['GET'])
def get_edges():
    client = pyorient.OrientDB(HOST, PORT)
    session_id = client.connect(USER, PASSWORD)
    client.db_open(DATABASE, USER, PASSWORD)
    records = client.query("SELECT FROM E")
    result = [];

    for edge in records:
        result.append({"id": edge._rid , "label": edge._class, "from": str(edge._out), "to": str(edge._in)})

    client.db_close()
    return jsonify(result)