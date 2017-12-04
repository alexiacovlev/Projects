CREATE TABLE [dbo].[CIMS_d_SubjectsToStudy] (
    [ID]     INT              IDENTITY (1, 1) NOT NULL,
    [Name]   NVARCHAR (200)   NOT NULL,
    [TeamId] UNIQUEIDENTIFIER NULL,
    [Active] BIT              NULL,
    [Type]   INT              NULL,
    CONSTRAINT [PK_CIMS_d_SubjectsToStudy] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_d_SubjectsToStudy_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_d_SubjectsToStudy_CIMS_d_TypeOfSubjectsToStudy] FOREIGN KEY ([Type]) REFERENCES [dbo].[CIMS_d_TypeOfSubjectsToStudy] ([ID])
);



