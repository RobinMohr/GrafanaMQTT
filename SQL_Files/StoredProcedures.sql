
CREATE PROCEDURE CreateNewSensor
(
	@LocationId int = NULL,
	@LocationDescription NVARCHAR(32) = NULL,
	@SensorName NVARCHAR(16)
)
AS
BEGIN
	insert into Sensor(SensorName, LocationId)
	values(@SensorName, @LocationId)
END
GO

CREATE PROCEDURE CreateNewUnit
(
	@UnitDescription NVARCHAR(16)
)
AS
BEGIN
	insert into Unit(Description)
	values(@UnitDescription)
END
GO

CREATE PROCEDURE CreateNewType
(
	@TypeDescription NVARCHAR(16)
)
AS
BEGIN
	insert into SensorType(Description)
	values(@TypeDescription)
END
GO

CREATE PROCEDURE CreateNewLocation
(
	@LocationDescription NVARCHAR(32)
)
AS
BEGIN
	insert into SensorLocation(Description)
	values(@LocationDescription)
END
GO


CREATE PROCEDURE InsertSensorData
(
	@SensorId int = Null,
	@UnitId int = NULL,
	@TypeId int = NULL,
	@LocationId int = NULL,
	@RecordedValue VARCHAR(64) = NULL,
	@RecordedTime Datetime = NULL
)
AS
BEGIN
   INSERT INTO SensorEntry(RecordedValue, RecordedTime, LocationId, UnitId,SensorTypeId)
   values(@RecordedValue,@RecordedTime,@LocationId,@UnitId)
END
GO
		RecordedValue VARCHAR(64),
		RecordedTime Datetime,
		LocationId INT FOREIGN KEY REFERENCES SensorLocation(SensorLocationId),
		UnitId INT FOREIGN KEY REFERENCES  Unit(UnitId),
		SensorTypeId INT FOREIGN KEY REFERENCES  SensorType(SensorTypeId)