--DROP TABLE IF EXISTS [WorkoutActivity]
--DROP TABLE IF EXISTS [WorkoutProgramme]
--DROP TABLE IF EXISTS [Workout]
--DROP TABLE IF EXISTS [WorkoutActivityTargetArea]
--DROP TABLE IF EXISTS [WorkoutDetails]

CREATE TABLE [WorkoutActivityTargetArea]
(
 [WorkoutActivityTargetAreaID] int NOT NULL ,
 [WorkoutTargetArea]           nvarchar(50) NOT NULL ,
 [WorkoutGroup]                nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_WorkoutTargetArea] PRIMARY KEY CLUSTERED ([WorkoutActivityTargetAreaID] ASC)
);
GO

CREATE TABLE [Workout]
(
 [WorkoutID]   int NOT NULL ,
 [ContactID]   int NOT NULL ,
 [WhenStarted] datetime NOT NULL ,
 [WhenEnded]   datetime NOT NULL ,


 CONSTRAINT [PK_Workout] PRIMARY KEY CLUSTERED ([WorkoutID] ASC),
 CONSTRAINT [FK_52] FOREIGN KEY ([ContactID])  REFERENCES dbo.[Contact]([ContactID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_52] ON [Workout] 
 (
  [ContactID] ASC
 )

GO

CREATE TABLE [WorkoutProgramme]
(
 [WorkoutProgrammeID] int NOT NULL ,
 [WorkoutID]          int NOT NULL ,


 CONSTRAINT [PK_WorkoutProgramme] PRIMARY KEY CLUSTERED ([WorkoutProgrammeID] ASC),
 CONSTRAINT [FK_120] FOREIGN KEY ([WorkoutID])  REFERENCES [Workout]([WorkoutID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_120] ON [WorkoutProgramme] 
 (
  [WorkoutID] ASC
 )

GO

CREATE TABLE [WorkoutActivity]
(
 [WorkoutActivityID]           int NOT NULL ,
 [ActivityName]                nvarchar(50) NOT NULL ,
 [ActivityDescription]         nvarchar(200) NOT NULL ,
 [WorkoutActivityTargetAreaID] int NOT NULL ,
 [WorkoutProgrammeID]          int NOT NULL ,


 CONSTRAINT [PK_WorkoutActivity] PRIMARY KEY CLUSTERED ([WorkoutActivityID] ASC),
 CONSTRAINT [FK_114] FOREIGN KEY ([WorkoutProgrammeID])  REFERENCES [WorkoutProgramme]([WorkoutProgrammeID]),
 CONSTRAINT [FK_98] FOREIGN KEY ([WorkoutActivityTargetAreaID])  REFERENCES [WorkoutActivityTargetArea]([WorkoutActivityTargetAreaID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_114] ON [WorkoutActivity] 
 (
  [WorkoutProgrammeID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_98] ON [WorkoutActivity] 
 (
  [WorkoutActivityTargetAreaID] ASC
 )

GO

CREATE TABLE [WorkoutDetails]
(
 [WorkoutDetailsID]  int NOT NULL ,
 [Weight]            float NOT NULL ,
 [Reps]              int NOT NULL ,
 [WorkoutActivityID] int NOT NULL ,


 CONSTRAINT [PK_WorkoutDetails] PRIMARY KEY CLUSTERED ([WorkoutDetailsID] ASC),
 CONSTRAINT [FK_95] FOREIGN KEY ([WorkoutActivityID])  REFERENCES [WorkoutActivity]([WorkoutActivityID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_95] ON [WorkoutDetails] 
 (
  [WorkoutActivityID] ASC
 )

GO