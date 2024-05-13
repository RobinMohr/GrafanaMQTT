IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Log' and xtype='U')
BEGIN
Create Table Log
(
	LogId int Identity(1,1),
	ActionType text,
	ActionTable text,
	ActionStatement NVARCHAR(MAX),
	ActionTime DateTime DEFAULT GETDATE(),
	Primary Key(LogId)
)
END