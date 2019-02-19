# coding=utf-8
from flask import Flask
from flask import jsonify
from pprint import pprint
import pyorient

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