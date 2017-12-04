CREATE TABLE [dbo].[AX_Incidents_Comments] (
    [id]                  UNIQUEIDENTIFIER NOT NULL,
    [Comments]            NVARCHAR (MAX)   NULL,
    [ObjectId]            UNIQUEIDENTIFIER NULL,
    [ModifiedIP]          NVARCHAR (20)    NULL,
    [ModifiedOn]          DATETIME         NULL,
    [ModifiedBy]          UNIQUEIDENTIFIER NULL,
    [CreatedOn]           DATETIME         NULL,
    [CreatedBy]           UNIQUEIDENTIFIER NULL,
    [CreatedIP]           NVARCHAR (20)    NULL,
    [Subject]             NVARCHAR (250)   NULL,
    [Email]               NVARCHAR (50)    NULL,
    [CreatedBy_FullName]  NVARCHAR (100)   NULL,
    [ModifiedBy_FullName] NVARCHAR (100)   NULL,
    [RequestURL]          NVARCHAR (100)   NULL,
    CONSTRAINT [PK_AX_Incidents_Comments] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

