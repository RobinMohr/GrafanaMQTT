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