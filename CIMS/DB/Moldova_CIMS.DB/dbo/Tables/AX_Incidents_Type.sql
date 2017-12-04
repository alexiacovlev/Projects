CREATE TABLE [dbo].[AX_Incidents_Type] (
    [id]    INT           NOT NULL,
    [Type]  NVARCHAR (50) NULL,
    [Color] NVARCHAR (50) NULL,
    CONSTRAINT [PK_AX_Incidents_Type] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

