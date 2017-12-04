CREATE TABLE [dbo].[CIMS_Practice2Groups] (
    [Practice] UNIQUEIDENTIFIER NOT NULL,
    [Group]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_CIMS_Practice2Groups] PRIMARY KEY CLUSTERED ([Practice] ASC, [Group] ASC),
    CONSTRAINT [FK_CIMS_Practice2Groups_CIMS_Groups] FOREIGN KEY ([Group]) REFERENCES [dbo].[CIMS_Groups] ([ID]),
    CONSTRAINT [FK_CIMS_Practice2Groups_CIMS_Practice] FOREIGN KEY ([Practice]) REFERENCES [dbo].[CIMS_Practice] ([ID])
);



