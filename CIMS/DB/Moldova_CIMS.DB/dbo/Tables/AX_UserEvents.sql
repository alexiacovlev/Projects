CREATE TABLE [dbo].[AX_UserEvents] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [TypeId]        INT              NOT NULL,
    [TypeName]      VARCHAR (50)     NULL,
    [Message]       NVARCHAR (1024)  NULL,
    [Data]          NVARCHAR (512)   NULL,
    [UserName]      NVARCHAR (255)   NULL,
    [UserId]        UNIQUEIDENTIFIER NULL,
    [EventTime]     DATETIME         NOT NULL,
    [IPAddress]     VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AX_UserEvents] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

