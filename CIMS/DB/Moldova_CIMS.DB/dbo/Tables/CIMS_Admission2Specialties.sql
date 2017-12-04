CREATE TABLE [dbo].[CIMS_Admission2Specialties] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [Admission]     UNIQUEIDENTIFIER NULL,
    [OrderSpec]     INT              NULL,
    [Profile]       INT              NULL,
    [Specialty]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Admission2Specialties] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Admission2Specialties_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Admission2Specialties_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Admission2Specialties_CIMS_Admission] FOREIGN KEY ([Admission]) REFERENCES [dbo].[CIMS_Admission] ([ID]),
    CONSTRAINT [FK_CIMS_Admission2Specialties_CIMS_SpecialtyProfile] FOREIGN KEY ([Specialty]) REFERENCES [dbo].[CIMS_SpecialtyProfile] ([ID])
);







