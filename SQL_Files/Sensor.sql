IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sensor' and xtype='U')
BEGIN
    CREATE TABLE Sensor(
        SensorId INT PRIMARY KEY IDENTITY (1, 1),
        SensorName NVARCHAR(16),
		LocationId INT FOREIGN KEY REFERENCES SensorLocation(SensorLocationId)
    )
END