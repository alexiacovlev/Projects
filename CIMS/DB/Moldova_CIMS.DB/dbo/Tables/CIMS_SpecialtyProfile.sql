CREATE TABLE [dbo].[CIMS_SpecialtyProfile] (
    [ID]               UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]        DATETIME         NULL,
    [CreatedBy]        UNIQUEIDENTIFIER NULL,
    [CreatedIP]        VARCHAR (50)     NULL,
    [ModifiedOn]       DATETIME         NULL,
    [ModifiedBy]       UNIQUEIDENTIFIER NULL,
    [ModifiedIP]       VARCHAR (50)     NULL,
    [ApplicationId]    UNIQUEIDENTIFIER NULL,
    [TeamId]           UNIQUEIDENTIFIER NULL,
    [Specialty]        INT              NULL,
    [Code]             NVARCHAR (50)    NULL,
    [Language]         INT              NULL,
    [Profile]          INT              NULL,
    [DurationOfStudy]  INT              NULL,
    [Qualification]    NVARCHAR (100)   NULL,
    [MainFieldOfStudy] NVARCHAR (1024)  NULL,
    [Objectives]       NVARCHAR (1024)  NULL,
    [Section]          UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_SpecialtyProfile] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_CIMS_d_Language] FOREIGN KEY ([Language]) REFERENCES [dbo].[CIMS_d_Language] ([ID]),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_CIMS_d_Specialties] FOREIGN KEY ([Specialty]) REFERENCES [dbo].[CIMS_d_Specialties] ([ID]),
    CONSTRAINT [FK_CIMS_SpecialtyProfile_CIMS_Sections] FOREIGN KEY ([Section]) REFERENCES [dbo].[CIMS_Sections] ([ID])
);





