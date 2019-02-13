# coding=utf-8
# para que funcione cambiar
from pprint import pprint

# from objbrowser import browse

# sitepackages/pyorient/constants.py
# cambiar de 36 a 37
# SUPPORTED_PROTOCOL = 37

import pyorient
print ('empezamos!')

client = pyorient.OrientDB("localhost", 2424)
session_id = client.connect( "root", "root")
client.db_open("demodb", "root", "root")
records = client.query('select from OUser')

print (records)

client.db_close()