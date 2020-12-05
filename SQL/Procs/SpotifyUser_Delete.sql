CREATE OR ALTER PROCEDURE dbo.SpotifyUser_Delete
AS 
BEGIN 
SET NOCOUNT ON 
	BEGIN TRANSACTION
		DELETE t
		FROM Token t
			INNER JOIN SpotifyUser s ON t.ContactID = s.SpotifyUserId
		WHERE s.LastUsed IS NULL OR s.LastUsed < DATEADD(HOUR, -1, GETDATE())

		DELETE FROM SpotifyUser
		WHERE LastUsed IS NULL OR LastUsed < DATEADD(HOUR, -1, GETDATE())
	COMMIT TRANSACTION
END 
GO