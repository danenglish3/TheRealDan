DROP TABLE IF EXISTS [dbo].[MediaType]

CREATE TABLE dbo.MediaType (
	MediaTypeID int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	BaseURL nvarchar(500) NULL,
	PRIMARY KEY (MediaTypeID)
)

INSERT INTO dbo.MediaType (
	[Name],
	BaseURL
)
VALUES (
	N'PlantImage',
	N'https://therealdan-images.s3.amazonaws.com/'
)