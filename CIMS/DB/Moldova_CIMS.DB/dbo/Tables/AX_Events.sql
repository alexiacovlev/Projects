CREATE TABLE [dbo].[AX_Events] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [Title]         NVARCHAR (200)   NOT NULL,
    [Description]   NVARCHAR (1024)  NULL,
    [StartTime]     DATETIME         NOT NULL,
    [EndTime]       DATETIME         NOT NULL,
    [AllDay]        BIT              NOT NULL,
    [RepeatMode]    INT              NOT NULL,
    [RepeatPeriod]  INT              NULL,
    [TeamID]        UNIQUEIDENTIFIER NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NOT NULL,
    [CreatedIP]     NVARCHAR (20)    NOT NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedIP]    NVARCHAR (20)    NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [LocationID]    INT              NULL,
    [CategoryID]    INT              NULL,
    CONSTRAINT [PK_AX_Events] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_AX_Events_AX_Events_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[AX_Events_Categories] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_AX_Events_AX_Events_Locations] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[AX_Events_Locations] ([ID]) ON DELETE CASCADE
);

