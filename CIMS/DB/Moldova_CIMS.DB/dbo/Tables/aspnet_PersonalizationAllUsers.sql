CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers] (
    [PathId]          UNIQUEIDENTIFIER NOT NULL,
    [PageSettings]    IMAGE            NOT NULL,
    [LastUpdatedDate] DATETIME         NOT NULL,
    CONSTRAINT [PK_aspnet_PersonalizationAllUsers] PRIMARY KEY CLUSTERED ([PathId] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK__aspnet_Pe__PathI__22751F6C] FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
);



