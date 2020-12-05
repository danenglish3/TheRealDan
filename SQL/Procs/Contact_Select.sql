CREATE OR ALTER PROCEDURE [dbo].[Contact_Select] 
	@Email NVARCHAR(50),
	@Message NVARCHAR(MAX) OUTPUT
AS 
BEGIN 
SET NOCOUNT ON 
	SELECT Contact.ContactID,
		Contact.FirstName,
		Contact.LastName,
		Contact.Email,
		Contact.PasswordHash
	FROM dbo.Contact
	WHERE Contact.Email = @Email
END 
GO


