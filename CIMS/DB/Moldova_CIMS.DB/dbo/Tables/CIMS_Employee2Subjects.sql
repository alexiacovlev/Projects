CREATE TABLE [dbo].[CIMS_Employee2Subjects] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [Employee]      UNIQUEIDENTIFIER NULL,
    [Subject]       INT              NULL,
    [HoursPerWeek]  FLOAT (53)       NULL,
    CONSTRAINT [PK_CIMS_Employee2Subjects] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Employee2Subjects_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Employee2Subjects_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Employee2Subjects_CIMS_d_SubjectsToStudy] FOREIGN KEY ([Subject]) REFERENCES [dbo].[CIMS_d_SubjectsToStudy] ([ID]),
    CONSTRAINT [FK_CIMS_Employee2Subjects_CIMS_d_SubjectsToStudy1] FOREIGN KEY ([Subject]) REFERENCES [dbo].[CIMS_d_SubjectsToStudy] ([ID]),
    CONSTRAINT [FK_CIMS_Employee2Subjects_CIMS_Employee] FOREIGN KEY ([Employee]) REFERENCES [dbo].[CIMS_Employee] ([ID])
);





