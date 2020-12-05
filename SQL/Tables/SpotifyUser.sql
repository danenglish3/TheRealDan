CREATE TABLE [SpotifyUser]
(
 [SpotifyUserId]           int IDENTITY(1,1) NOT NULL ,
 [Pin]                nvarchar(50) NOT NULL ,
 [Identifier]			nvarchar(50) DEFAULT NEWID() NOT NULL 


 CONSTRAINT [PK_SpotifyUser] PRIMARY KEY CLUSTERED ([SpotifyUserId] ASC),
);
GO