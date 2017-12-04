CREATE TABLE [dbo].[CIMS_ExamsPlanItems] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [TeamId]        UNIQUEIDENTIFIER NULL,
    [StudyPlan]     UNIQUEIDENTIFIER NULL,
    [Semester]      UNIQUEIDENTIFIER NULL,
    [Subject]       INT              NULL,
    [TypeOfSubject] INT              NULL,
    [TypeOfExam]    INT              NULL,
    CONSTRAINT [PK_CIMS_ExamsPlanItems] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_CIMS_d_SubjectsToStudy] FOREIGN KEY ([Subject]) REFERENCES [dbo].[CIMS_d_SubjectsToStudy] ([ID]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_CIMS_d_TypeOfExams] FOREIGN KEY ([TypeOfExam]) REFERENCES [dbo].[CIMS_d_TypeOfExams] ([ID]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_CIMS_Semesters] FOREIGN KEY ([Semester]) REFERENCES [dbo].[CIMS_Semesters] ([ID]),
    CONSTRAINT [FK_CIMS_ExamsPlanItems_CIMS_StudyPlans] FOREIGN KEY ([StudyPlan]) REFERENCES [dbo].[CIMS_StudyPlans] ([ID])
);





