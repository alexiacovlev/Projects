CREATE TABLE [dbo].[CIMS_d_TypeOfEvaluation] (
    [ID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_CIMS_d_TypeOfEvaluation] PRIMARY KEY CLUSTERED ([ID] ASC)
);

