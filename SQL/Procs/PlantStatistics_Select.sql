CREATE OR ALTER PROCEDURE [dbo].[PlantStatistics_List] 
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	SELECT PlantStatistics.Number,
		PlantStatistics.[Description]
	FROM dbo.PlantStatistics
	WHERE PlantStatistics.Active = 1
END 
GO


