CREATE TABLE [dbo].[AX_Events_Categories] (
    [ID]              INT              IDENTITY (1, 1) NOT NULL,
    [Title]           NVARCHAR (50)    NOT NULL,
    [BackgroundColor] NCHAR (6)        NULL,
    [BorderColor]     NCHAR (6)        NULL,
    [TextColor]       NCHAR (6)        NULL,
    [ApplicationId]   UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AX_Events_Categories] PRIMARY KEY CLUSTERED ([ID] ASC)
);

