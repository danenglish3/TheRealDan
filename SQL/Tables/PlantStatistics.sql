DROP TABLE IF EXISTS [dbo].[PlantStatistics]

CREATE TABLE dbo.PlantStatistics (
	PlantStatisticsID int IDENTITY(1,1) NOT NULL,
	Number nvarchar(50) NOT NULL,
	[Description] nvarchar(150) NOT NULL,
	Active bit DEFAULT 1,
	PRIMARY KEY (PlantStatisticsID)
)

INSERT INTO dbo.PlantStatistics (
	Number,
	[Description]
)
VALUES (
	N'4',
	N'Total'
)

INSERT INTO dbo.PlantStatistics (
	Number,
	[Description]
)
VALUES (
	N'4',
	N'Current'
)

INSERT INTO dbo.PlantStatistics (
	Number,
	[Description]
)
VALUES (
	N'0',
	N'Dead'
)