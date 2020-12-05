DROP TABLE IF EXISTS [dbo].[PlantMedia]

CREATE TABLE dbo.PlantMedia (
	PlantMediaID int IDENTITY(1,1) NOT NULL,
	MediaTypeID int NOT NULL,
	MediaID nvarchar(100) NOT NULL,
	PlantID int NOT NULL,
	FOREIGN KEY (PlantID) REFERENCES Plant(PlantID),
	FOREIGN KEY (MediaTypeID) REFERENCES MediaType(MediaTypeID)
)