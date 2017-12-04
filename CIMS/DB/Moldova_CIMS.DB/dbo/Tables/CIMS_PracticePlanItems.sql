CREATE TABLE [dbo].[CIMS_PracticePlanItems] (
    [ID]             UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]      DATETIME         NULL,
    [CreatedBy]      UNIQUEIDENTIFIER NULL,
    [CreatedIP]      VARCHAR (50)     NULL,
    [ModifiedOn]     DATETIME         NULL,
    [ModifiedBy]     UNIQUEIDENTIFIER NULL,
    [ModifiedIP]     VARCHAR (50)     NULL,
    [ApplicationId]  UNIQUEIDENTIFIER NULL,
    [StudyPlan]      UNIQUEIDENTIFIER NULL,
    [Semester]       UNIQUEIDENTIFIER NULL,
    [Name]           NVARCHAR (255)   NULL,
    [TypeOfPractice] INT              NULL,
    [NumberOfHours]  FLOAT (53)       NULL,
    [TeamId]         UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_PracticePlanItems] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_PracticePlanItems_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_PracticePlanItems_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_PracticePlanItems_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_PracticePlanItems_CIMS_d_TypeOfPractice] FOREIGN KEY ([TypeOfPractice]) REFERENCES [dbo].[CIMS_d_TypeOfPractice] ([ID]),
    CONSTRAINT [FK_CIMS_PracticePlanItems_CIMS_Semesters] FOREIGN KEY ([Semester]) REFERENCES [dbo].[CIMS_Semesters] ([ID]),
    CONSTRAINT [FK_CIMS_PracticePlanItems_CIMS_StudyPlans] FOREIGN KEY ([StudyPlan]) REFERENCES [dbo].[CIMS_StudyPlans] ([ID])
);





