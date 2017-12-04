CREATE TABLE [dbo].[aspnet_Team2Users] (
    [TeamId]       UNIQUEIDENTIFIER NOT NULL,
    [PortalUserId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_aspnet_Team2Users] PRIMARY KEY CLUSTERED ([TeamId] ASC, [PortalUserId] ASC) WITH (FILLFACTOR = 90)
);

