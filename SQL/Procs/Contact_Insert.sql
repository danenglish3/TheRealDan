CREATE OR ALTER PROCEDURE dbo.Contact_Insert 
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50), 
	@Email NVARCHAR(150), 
	@PasswordHash NVARCHAR(150),
	@PasswordSalt NVARCHAR(150),
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	DECLARE @ExistingEmail NVARCHAR(150)
	
	SELECT @ExistingEmail = Email
	FROM dbo.Contact
	WHERE Contact.Email = @Email
	
	IF (@ExistingEmail IS NOT NULL)
	BEGIN
		SET @Message = 'A user with that email already exists.'
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Contact
		  (                    
			FirstName,
			LastName,
			Email,
			PasswordHash,
			PasswordSalt
		  ) 
		VALUES 
		  ( 
			@FirstName,
			@LastName,
			@Email,
			@PasswordHash,
			@PasswordSalt
		  ) 
	END
END 
GO