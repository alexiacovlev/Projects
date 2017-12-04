CREATE TABLE [dbo].[CIMS_Applicant2Marks] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [Applicant]     UNIQUEIDENTIFIER NULL,
    [Mark]          FLOAT (53)       NULL,
    [Subject]       UNIQUEIDENTIFIER NULL,
    [Admission]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Applicant2Marks] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Applicant2Marks_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Applicant2Marks_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Applicant2Marks_CIMS_Admission] FOREIGN KEY ([Admission]) REFERENCES [dbo].[CIMS_Admission] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant2Marks_CIMS_Admission2Subjects] FOREIGN KEY ([Subject]) REFERENCES [dbo].[CIMS_Admission2Subjects] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant2Marks_CIMS_Applicant] FOREIGN KEY ([Applicant]) REFERENCES [dbo].[CIMS_Applicant] ([ID])
);





