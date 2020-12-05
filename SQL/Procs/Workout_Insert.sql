CREATE OR ALTER PROCEDURE dbo.Workout_Insert 
	@ContactID int,
	@WorkoutProgramIdentifier nvarchar(50), 
	@WorkoutIdentifer NVARCHAR(50) OUTPUT, 
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	INSERT INTO dbo.Workout
	(                    
		ContactID,
		WhenStarted,
		WorkoutProgramID
	) 
	VALUES 
	( 
		@ContactID,
		GETDATE(),
		(SELECT WorkoutProgram.WorkoutProgramID FROM dbo.WorkoutProgram WHERE WorkoutProgram.Identifier = @WorkoutProgramIdentifier)
	) 

	SELECT @WorkoutIdentifer = Workout.Identifier
	FROM dbo.Workout
	WHERE Workout.WorkoutID = SCOPE_IDENTITY()
END 
GO