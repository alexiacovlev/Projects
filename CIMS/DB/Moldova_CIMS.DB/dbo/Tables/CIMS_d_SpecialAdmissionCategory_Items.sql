CREATE TABLE [dbo].[CIMS_d_SpecialAdmissionCategory_Items] (
    [ID]            INT              IDENTITY (1, 1) NOT NULL,
    [Title]         NVARCHAR (500)   NOT NULL,
    [Description]   NVARCHAR (2000)  NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [Category]      INT              NULL,
    CONSTRAINT [PK_CIMS_d_SpecialAdmissionCategory_Items] PRIMARY KEY CLUSTERED ([ID] ASC)
);

