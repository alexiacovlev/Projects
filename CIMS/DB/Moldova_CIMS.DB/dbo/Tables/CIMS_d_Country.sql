﻿CREATE TABLE [dbo].[CIMS_d_Country] (
    [ID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_CIMS_d_Country] PRIMARY KEY CLUSTERED ([ID] ASC)
);
