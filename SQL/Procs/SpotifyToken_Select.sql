CREATE OR ALTER PROCEDURE dbo.SpotifyToken_Select
	@Pin NVARCHAR(150)
AS 
BEGIN 
SET NOCOUNT ON 
	SELECT Token.AccessToken,
		Token.RefreshToken,
		Token.ExpiresIn
	FROM Token
		INNER JOIN SpotifyUser ON Token.ContactId = SpotifyUser.SpotifyUserId
	WHERE SpotifyUser.Pin = @Pin
END 
GO
