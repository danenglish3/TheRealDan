CREATE OR ALTER PROCEDURE dbo.SpotifyUser_Insert 
	@AccessToken NVARCHAR(250),
	@RefreshToken NVARCHAR(250), 
	@ExpiresIn NVARCHAR(150), 
	@Pin NVARCHAR(150),
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	INSERT INTO dbo.SpotifyUser
	(                    
		Pin
	) 
	VALUES 
	( 
		@PIn
	)

	DECLARE @SpotifyUserId int
	SET @SpotifyUserId = SCOPE_IDENTITY()

	INSERT INTO dbo.Token
	(                    
		ContactId,
		[Type],
		AccessToken,
		RefreshToken,
		ExpiresIn,
		Active
	) 
	VALUES 
	( 
		@SpotifyUserId,
		N'Spotify',
		@AccessToken,
		@RefreshToken,
		@ExpiresIn,
		1
	)
END 
GO