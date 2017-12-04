CREATE TABLE [dbo].[aspnet_UserHashHistory] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [UserId]        UNIQUEIDENTIFIER NOT NULL,
    [Password]      NVARCHAR (128)   NOT NULL,
    [ModifiedOn]    DATETIME         NOT NULL,
    [ModifiedIP]    VARCHAR (50)     NOT NULL,
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_aspnet_UserHashHistory] PRIMARY KEY CLUSTERED ([ID] ASC)
);

