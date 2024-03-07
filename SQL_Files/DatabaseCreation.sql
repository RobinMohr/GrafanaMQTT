IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Unit' and xtype='U')
BEGIN
    CREATE TABLE Unit (
        UnitId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(16)
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobsjects WHERE name='SensorType' and xtype='U')
BEGIN
    CREATE TABLE SensorType(
        SensorTypeId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(16)
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SensorLocation' and xtype='U')
BEGIN
    CREATE TABLE SensorLocation(
        SensorLocationId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(32)
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sensor' and xtype='U')
BEGIN
    CREATE TABLE Sensor(
        SensorId INT PRIMARY KEY IDENTITY (1, 1),
        SensorName NVARCHAR(16),
		LocationId INT FOREIGN KEY REFERENCES SensorLocation(SensorLocationId)
    )
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SensorEntry' and xtype='U')
BEGIN
    CREATE TABLE SensorEntry(
        SensorEntryId INT PRIMARY KEY IDENTITY (1, 1),
        RecordedValue VARCHAR(64),
		RecordedTime Datetime,
		LocationId INT FOREIGN KEY REFERENCES SensorLocation(SensorLocationId),
		UnitId INT FOREIGN KEY REFERENCES  Unit(UnitId),
		SensorTypeId INT FOREIGN KEY REFERENCES  SensorType(SensorTypeId)
    )
END