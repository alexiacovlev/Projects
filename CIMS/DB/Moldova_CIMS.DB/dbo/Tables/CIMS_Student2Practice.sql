CREATE TABLE [dbo].[CIMS_Student2Practice] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [Practice]      UNIQUEIDENTIFIER NULL,
    [Student]       UNIQUEIDENTIFIER NULL,
    [Mark]          INT              NULL,
    [Destination]   NVARCHAR (255)   NULL,
    CONSTRAINT [PK_CIMS_Student2Practice] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Student2Practice_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Student2Practice_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Student2Practice_CIMS_Practice] FOREIGN KEY ([Practice]) REFERENCES [dbo].[CIMS_Practice] ([ID])
);







