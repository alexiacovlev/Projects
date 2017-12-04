CREATE TABLE [dbo].[CIMS_DUMMY] (
    [ID]                   UNIQUEIDENTIFIER NOT NULL,
    [YesNo]                INT              NULL,
    [SpecialtyByAdmission] UNIQUEIDENTIFIER NULL,
    [tmpRecordID]          UNIQUEIDENTIFIER NULL,
    [tmpTableName]         NVARCHAR (255)   NULL,
    [tmpTemplateName]      VARCHAR (255)    NULL,
    [tmpRefObjectID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_DUMMY] PRIMARY KEY CLUSTERED ([ID] ASC)
);





