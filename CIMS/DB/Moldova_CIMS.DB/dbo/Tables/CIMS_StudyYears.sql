CREATE TABLE [dbo].[CIMS_StudyYears] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [TeamId]        UNIQUEIDENTIFIER NULL,
    [StudyYear]     INT              NULL,
    [Status]        INT              NULL,
    CONSTRAINT [PK_CIMS_StudyYears] PRIMARY KEY CLUSTERED ([ID] ASC)
);

