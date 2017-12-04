CREATE TABLE [dbo].[CIMS_d_Specialties] (
    [ID]      INT              IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (200)   NOT NULL,
    [TeamId]  UNIQUEIDENTIFIER NULL,
    [Active]  BIT              NULL,
    [Profile] INT              NULL,
    CONSTRAINT [PK_CIMS_d_Specialties] PRIMARY KEY CLUSTERED ([ID] ASC)
);

