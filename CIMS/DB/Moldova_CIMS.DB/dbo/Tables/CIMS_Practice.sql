CREATE TABLE [dbo].[CIMS_Practice] (
    [ID]             UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]      DATETIME         NULL,
    [CreatedBy]      UNIQUEIDENTIFIER NULL,
    [CreatedIP]      VARCHAR (50)     NULL,
    [ModifiedOn]     DATETIME         NULL,
    [ModifiedBy]     UNIQUEIDENTIFIER NULL,
    [ModifiedIP]     VARCHAR (50)     NULL,
    [ApplicationId]  UNIQUEIDENTIFIER NULL,
    [StudyYear]      INT              NULL,
    [TeamId]         UNIQUEIDENTIFIER NULL,
    [TypeOfPractice] INT              NULL,
    [Semester]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Practice] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Practice_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Practice_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Practice_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_Practice_CIMS_d_StudyYears] FOREIGN KEY ([StudyYear]) REFERENCES [dbo].[CIMS_d_StudyYears] ([ID]),
    CONSTRAINT [FK_CIMS_Practice_CIMS_d_TypeOfPractice] FOREIGN KEY ([TypeOfPractice]) REFERENCES [dbo].[CIMS_d_TypeOfPractice] ([ID]),
    CONSTRAINT [FK_CIMS_Practice_CIMS_Semesters] FOREIGN KEY ([Semester]) REFERENCES [dbo].[CIMS_Semesters] ([ID])
);





