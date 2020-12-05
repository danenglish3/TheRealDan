CREATE OR ALTER PROCEDURE [dbo].[SpotifyToken_Update]
	@AccessToken NVARCHAR(250),
	@Identifier nvarchar(50)
AS 
BEGIN 
SET NOCOUNT ON 
	UPDATE dbo.Token
	SET AccessToken = @AccessToken
	WHERE Identifier = @Identifier
END 
GO
