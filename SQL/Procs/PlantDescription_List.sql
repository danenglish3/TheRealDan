CREATE OR ALTER PROCEDURE [dbo].[PlantDescription_List] 
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	SELECT	Plant.NickName, 
		Plant.NameShort,
		Plant.DescriptionShort,
		MediaType.BaseURL,
		PlantMedia.MediaID
	FROM dbo.Plant
		INNER JOIN dbo.PlantMedia ON PlantMedia.PlantID = Plant.PlantID 
		INNER JOIN dbo.MediaType ON MediaType.MediaTypeID = PlantMedia.MediaTypeID
	WHERE MediaType.[Name] = 'PlantImage'
END 
GO


