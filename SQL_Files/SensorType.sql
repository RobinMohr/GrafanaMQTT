IF NOT EXISTS (SELECT * FROM sysobsjects WHERE name='SensorType' and xtype='U')
BEGIN
    CREATE TABLE SensorType(
        SensorTypeId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(16)
    )
END