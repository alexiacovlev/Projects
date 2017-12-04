CREATE TABLE [dbo].[CIMS_AdmissionVacancies] (
    [ID]                UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]         DATETIME         NULL,
    [CreatedBy]         UNIQUEIDENTIFIER NULL,
    [CreatedIP]         VARCHAR (50)     NULL,
    [ModifiedOn]        DATETIME         NULL,
    [ModifiedBy]        UNIQUEIDENTIFIER NULL,
    [ModifiedIP]        VARCHAR (50)     NULL,
    [ApplicationId]     UNIQUEIDENTIFIER NULL,
    [College]           UNIQUEIDENTIFIER NULL,
    [Admission]         UNIQUEIDENTIFIER NULL,
    [Specialty]         UNIQUEIDENTIFIER NULL,
    [TypeOfFinancing]   INT              NULL,
    [AdmissionCategory] INT              NULL,
    [LocalityCategory]  INT              NULL,
    [NrOfVacancies]     INT              NULL,
    CONSTRAINT [PK_CIMS_AdmissionVacancies] PRIMARY KEY CLUSTERED ([ID] ASC)
);

