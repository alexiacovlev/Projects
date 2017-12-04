CREATE TABLE [dbo].[AX_Events_Locations] (
    [ID]    INT            IDENTITY (1, 1) NOT NULL,
    [Title] NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_AX_Events_Locations] PRIMARY KEY CLUSTERED ([ID] ASC)
);

