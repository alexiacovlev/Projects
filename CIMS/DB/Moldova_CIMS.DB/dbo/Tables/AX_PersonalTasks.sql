CREATE TABLE [dbo].[AX_PersonalTasks] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [UserId]        UNIQUEIDENTIFIER NOT NULL,
    [Type]          SMALLINT         NOT NULL,
    [Title]         NVARCHAR (400)   NOT NULL,
    [Status]        INT              NOT NULL,
    [Handler]       VARCHAR (50)     NULL,
    [Parameters]    VARCHAR (200)    NULL,
    [Window]        VARCHAR (20)     NULL,
    [MessageText]   NVARCHAR (1000)  NULL,
    [RegardingId]   UNIQUEIDENTIFIER NULL,
    [RegardingType] INT              NULL,
    [RegardingText] NVARCHAR (300)   NULL,
    [ActualStart]   DATETIME         NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [OpenedOn]      DATETIME         NULL,
    [CompletedOn]   DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedIP]    NVARCHAR (50)    NULL,
    CONSTRAINT [PK_AX_PersonalTasks] PRIMARY KEY CLUSTERED ([ID] ASC)
);

