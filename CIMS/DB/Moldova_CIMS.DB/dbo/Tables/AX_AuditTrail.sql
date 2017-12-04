CREATE TABLE [dbo].[AX_AuditTrail] (
    [atID]            UNIQUEIDENTIFIER CONSTRAINT [DF_AX_AuditTrail_atID] DEFAULT (newid()) NOT NULL,
    [atApplicationId] UNIQUEIDENTIFIER NOT NULL,
    [atUserId]        UNIQUEIDENTIFIER NOT NULL,
    [atDateCreated]   DATETIME         NOT NULL,
    [atIP]            VARCHAR (50)     NULL,
    [atKeyValue]      VARCHAR (50)     NOT NULL,
    [atTable]         VARCHAR (255)    NOT NULL,
    [atObject]        VARCHAR (255)    NOT NULL,
    [atURL]           NVARCHAR (1000)  NULL,
    [atAction]        SMALLINT         NOT NULL,
    [atInfo]          NTEXT            NULL,
    CONSTRAINT [PK_AX_AuditTrail] PRIMARY KEY CLUSTERED ([atID] ASC) WITH (FILLFACTOR = 90)
);

