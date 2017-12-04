CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName]        NVARCHAR (256)   NOT NULL,
    [LoweredApplicationName] NVARCHAR (256)   NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Description]            NVARCHAR (256)   NULL,
    CONSTRAINT [PK_aspnet_Applications] PRIMARY KEY NONCLUSTERED ([ApplicationId] ASC) WITH (FILLFACTOR = 90),
    UNIQUE NONCLUSTERED ([ApplicationName] ASC) WITH (FILLFACTOR = 90),
    UNIQUE NONCLUSTERED ([LoweredApplicationName] ASC) WITH (FILLFACTOR = 90)
);




GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index]
    ON [dbo].[aspnet_Applications]([LoweredApplicationName] ASC) WITH (FILLFACTOR = 90);

