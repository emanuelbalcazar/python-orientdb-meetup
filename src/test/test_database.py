# coding=utf-8
from pprint import pprint

# sitepackages/pyorient/constants.py
# cambiar de 36 a 37
# SUPPORTED_PROTOCOL = 37

import pyorient

client = pyorient.OrientDB("localhost", 2424)
session_id = client.connect( "root", "root")
client.db_open("demodb", "root", "root")
records = client.query('select from OUser')

print (records[0].oRecordData)

client.db_close()