DROP TABLE IF EXISTS [WorkoutDetails]
DROP TABLE IF EXISTS [WorkoutActivity]
DROP TABLE IF EXISTS [Workout]
DROP TABLE IF EXISTS [WorkoutActivityTargetArea]
DROP TABLE IF EXISTS [WorkoutProgram]

CREATE TABLE [WorkoutProgram]
(
 [WorkoutProgramID]		int IDENTITY(1,1) NOT NULL ,
 [Name]					nvarchar(50) NOT NULL ,
 [Identifier]			nvarchar(50) DEFAULT NEWID() NOT NULL 

 CONSTRAINT [PK_WorkoutProgram] PRIMARY KEY CLUSTERED ([WorkoutProgramID] ASC)
);
GO

CREATE TABLE [WorkoutActivityTargetArea]
(
 [WorkoutActivityTargetAreaID] int IDENTITY(1,1) NOT NULL ,
 [WorkoutTargetArea]           nvarchar(50) NOT NULL ,
 [WorkoutGroup]                nvarchar(50) NOT NULL ,

 CONSTRAINT [PK_WorkoutTargetArea] PRIMARY KEY CLUSTERED ([WorkoutActivityTargetAreaID] ASC)
);
GO

CREATE TABLE [Workout]
(
 [WorkoutID]   int IDENTITY(1,1) NOT NULL ,
 [ContactID]   int NOT NULL ,
 [WhenStarted] datetime NOT NULL ,
 [WhenEnded]   datetime NULL ,
 [WorkoutProgramID] int NOT NULL ,
 [Identifier]			nvarchar(50) DEFAULT NEWID() NOT NULL 

 CONSTRAINT [PK_Workout] PRIMARY KEY CLUSTERED ([WorkoutID] ASC),
 CONSTRAINT [FK_52] FOREIGN KEY ([ContactID])  REFERENCES dbo.[Contact]([ContactID]),
 CONSTRAINT [FK_WorkoutProgram] FOREIGN KEY ([WorkoutProgramID])  REFERENCES [WorkoutProgram]([WorkoutProgramID])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_52] ON [Workout] 
 (
  [ContactID] ASC
 )

GO


CREATE TABLE [WorkoutActivity]
(
 [WorkoutActivityID]           int IDENTITY(1,1) NOT NULL ,
 [ActivityName]                nvarchar(50) NOT NULL ,
 [ActivityDescription]         nvarchar(200) NOT NULL ,
 [WorkoutActivityTargetAreaID] int NULL ,
 [WorkoutProgramID]          int NOT NULL ,
 [Identifier]			nvarchar(50) DEFAULT NEWID() NOT NULL 


 CONSTRAINT [PK_WorkoutActivity] PRIMARY KEY CLUSTERED ([WorkoutActivityID] ASC),
 CONSTRAINT [FK_114] FOREIGN KEY ([WorkoutProgramID])  REFERENCES [WorkoutProgram]([WorkoutProgramID]),
 CONSTRAINT [FK_98] FOREIGN KEY ([WorkoutActivityTargetAreaID])  REFERENCES [WorkoutActivityTargetArea]([WorkoutActivityTargetAreaID])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_114] ON [WorkoutActivity] 
 (
  [WorkoutProgramID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_98] ON [WorkoutActivity] 
 (
  [WorkoutActivityTargetAreaID] ASC
 )

GO

CREATE TABLE [WorkoutDetails]
(
 [WorkoutDetailsID]  int IDENTITY(1,1) NOT NULL ,
 [Weight]            float NOT NULL ,
 [Reps]              int NOT NULL ,
 [WorkoutActivityID] int NOT NULL ,
 [Identifier]			nvarchar(50) DEFAULT NEWID() NOT NULL 


 CONSTRAINT [PK_WorkoutDetails] PRIMARY KEY CLUSTERED ([WorkoutDetailsID] ASC),
 CONSTRAINT [FK_95] FOREIGN KEY ([WorkoutActivityID])  REFERENCES [WorkoutActivity]([WorkoutActivityID])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_95] ON [WorkoutDetails] 
 (
  [WorkoutActivityID] ASC
 )

GO

INSERT INTO dbo.[WorkoutProgram] (
	[Name]
)
VALUES (
	N'5x5 - A'
)

INSERT INTO dbo.[WorkoutProgram] (
	[Name]
)
VALUES (
	N'5x5 - B'
)

INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Squat',
	N'5 x 5 squats',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - A')
)

INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Bench Press',
	N'5 x 5 Bench Press',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - A')
)

INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Barbell Row',
	N'5 x 5 Barbell Row',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - A')
)
INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Squat',
	N'5 x 5 squats',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - B')
)

INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Overhead Press',
	N'5 x 5 Overhead Press',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - B')
)

INSERT INTO dbo.[WorkoutActivity] (
	ActivityName,
	ActivityDescription,
	WorkoutProgramID
)
VALUES (
	N'Deadlift',
	N'1 x 5 Deadlift',
	(SELECT WorkoutProgram.WorkoutProgramID FROM WorkoutProgram WHERE WorkoutProgram.[Name] = N'5x5 - B')
)
