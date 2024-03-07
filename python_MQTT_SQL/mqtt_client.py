from paho.mqtt import client as mqtt
import sqlite3
import json


def setup_client():
    client = mqtt.Client()
    client.connect("192.168.101.210", 1883, 60)

    def on_connect(client, userdata, flags, rc):
        print("connected with result code " + str(rc))
        client.subscribe("kos/sensors")

    def on_message(client, userdata, msg):
        json_obj = json.loads(msg.payload)
        sql_cursor = get_sql_cursor()
        sql_cursor.execute(
            f"""INSERT INTO SensorData (
                sensorId, sensorValue, latitude, 
                date, time, lng, unit, type, description
                ) 
                VALUES(
                    {json_obj.id},{json_obj.value},{json_obj.lat},
                    {json_obj.date},{json_obj.time},{json_obj.lng},
                    {json_obj.type},{json_obj.description}
                    );"""
        )
        print(json_obj)

    client.on_connect = on_connect
    client.on_message = on_message
    return client


def get_sql_cursor() -> sqlite3.Cursor:
    try:
        connection = sqlite3.connect("school_weather.db")
        cursor = connection.cursor()
        cursor.execute(
            """CREATE TABLE if not exists SensorData (
                dataId INTEGER PRIMARY KEY AUTOINCREMENT,sensorId int, 
                sensorValue text,latitude text, date text, time text, 
                lng integer, unit text, type text, description text);"""
        )
        return cursor
    except sqlite3.Error as e:
        print(e)


if __name__ == "__main__":
    client = setup_client()

    client.loop_forever()
