CREATE TABLE [dbo].[AX_Notifications] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [UserId]        UNIQUEIDENTIFIER NOT NULL,
    [Header]        NVARCHAR (50)    NOT NULL,
    [Text]          NVARCHAR (1024)  NOT NULL,
    [IsRead]        BIT              NOT NULL,
    [ReadOn]        DATETIME         NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL
);

