DROP TABLE [dbo].[Contact]

CREATE TABLE dbo.Contact (
	ContactID int IDENTITY(1,1) NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Email nvarchar(150) NOT NULL,
	[PasswordHash] nvarchar(150) NOT NULL,
	PasswordSalt nvarchar(150) NOT NULL
)