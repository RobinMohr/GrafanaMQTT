from paho.mqtt import client as mqtt
import sqlite3
import json
from sql_cursor import SQL_Cursor


def setup_client():
    client = mqtt.Client()
    client.connect("192.168.101.210", 1883, 60)

    def on_connect(client, userdata, flags, rc):
        print("connected with result code " + str(rc))
        # client.subscribe("kos/sensors")

    def on_message(client, userdata, msg):
        json_obj = json.loads(msg.payload)
        yield json_obj
        # sql_cursor = SQL_Cursor()
        # sql_cursor.execute(
        #     f"""INSERT INTO SensorData (
        #         sensorId, sensorValue, latitude, 
        #         date, time, lng, unit, type, description
        #         ) 
        #         VALUES(
        #             {json_obj.id},{json_obj.value},{json_obj.lat},
        #             {json_obj.date},{json_obj.time},{json_obj.lng},
        #             {json_obj.type},{json_obj.description}
        #             );"""
        # )
        # print(json_obj)

    client.on_connect = on_connect
    client.on_message = on_message
    return client

if __name__ == "__main__":
    sql_cursor = SQL_Cursor()
    client = setup_client()
    for message in client.on_message:
        print(message)
        sql_cursor.cursor.execute()

    client.loop_forever()
