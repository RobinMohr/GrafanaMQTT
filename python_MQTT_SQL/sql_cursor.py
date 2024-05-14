import pypyodbc
import time
import numpy
import os

class SQL_Cursor:
    def __init__(self) -> None:
        self.connected: bool = False
        self._connection = None
        self.connect()
        self._cursor = None
        self.create_tables_if_not_exist()

    def create_tables_if_not_exist(self):
        all_tables = numpy.array(sorted([x[0] for x in self.cursor.execute("SELECT name FROM sysobjects WHERE xtype = 'U' and name != 'sysdiagrams'").fetchall()]))
        wanted_tables = numpy.array(sorted(["Unit","SensorType","SensorLocation","Sensor","SensorEntry","Log"]))
        missing_tables = numpy.setdiff1d(wanted_tables,all_tables)
        for missing_table in missing_tables:
            file = open(f"{os.getcwd()}\\SQL_Files\\{missing_table}.sql", "r")
            self.cursor.execute(file.read())

    def connect(self):
        try:
            self._connection = pypyodbc.connect("Driver={SQL Server Native Client 11.0};"
                                "Server=grafanasql.database.windows.net,1433;"
                                "Database=GrafanaSQL;"
                                "uid=azureuser;pwd=Passwort1234")
            self.connected = True
        except:
            self.connected = False

    def reconnect(self):
        counter = 0
        while self._connection is None:
            counter += 1
            try:
                self.connect()
            except pypyodbc.Error as error:
                time.sleep(5)
                print("error while trying to connect number: " + counter)
                print("retrying...")
                print(error)
            finally:
                if counter > 5:
                    print("couldn't establish a connection")
                    break

    @property
    def connection(self):
        if self._connection is None or self.connected is False:
            self.reconnect()
        return self._connection
    
    @property
    def cursor(self) -> pypyodbc.Cursor:
        if self._cursor is None:
            self._cursor = self.connection.cursor()
        return self._cursor