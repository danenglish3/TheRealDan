CREATE OR ALTER PROCEDURE [dbo].[WorkoutProgram_List] 
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	SELECT	WorkoutProgram.WorkoutProgramID, 
		WorkoutProgram.[Name],
		WorkoutProgram.Identifier
	FROM dbo.[WorkoutProgram]
END 
GO


