IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SensorLocation' and xtype='U')
BEGIN
    CREATE TABLE SensorLocation(
        SensorLocationId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(32)
    )
END