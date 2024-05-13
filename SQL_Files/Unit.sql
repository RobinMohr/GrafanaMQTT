IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Unit' and xtype='U')
BEGIN
    CREATE TABLE Unit (
        UnitId INT PRIMARY KEY IDENTITY (1, 1),
        Description NVARCHAR(16)
    )
END