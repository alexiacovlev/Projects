CREATE TABLE [dbo].[CIMS_Admission] (
    [ID]                UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]         DATETIME         NULL,
    [CreatedBy]         UNIQUEIDENTIFIER NULL,
    [CreatedIP]         VARCHAR (50)     NULL,
    [ModifiedOn]        DATETIME         NULL,
    [ModifiedBy]        UNIQUEIDENTIFIER NULL,
    [ModifiedIP]        VARCHAR (50)     NULL,
    [ApplicationId]     UNIQUEIDENTIFIER NULL,
    [Year]              INT              NULL,
    [Status]            INT              NULL,
    [TeamId]            UNIQUEIDENTIFIER NULL,
    [ResponsiblePerson] UNIQUEIDENTIFIER NULL,
    [AdmissionChairman] UNIQUEIDENTIFIER NULL,
    [MarkWeight_MNDP]   FLOAT (53)       NULL,
    [MarkWeight_MNEA]   FLOAT (53)       NULL,
    CONSTRAINT [PK_CIMS_Admission] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Admission_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Admission_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Admission_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_Admission_CIMS_d_AdmissionStatus] FOREIGN KEY ([Status]) REFERENCES [dbo].[CIMS_d_AdmissionStatus] ([ID]),
    CONSTRAINT [FK_CIMS_Admission_CIMS_d_StudyYears] FOREIGN KEY ([Year]) REFERENCES [dbo].[CIMS_d_StudyYears] ([ID]),
    CONSTRAINT [FK_CIMS_Admission_CIMS_Employee] FOREIGN KEY ([ResponsiblePerson]) REFERENCES [dbo].[CIMS_Employee] ([ID])
);







