CREATE TABLE [dbo].[CIMS_Employee] (
    [ID]                      UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]               DATETIME         NULL,
    [CreatedBy]               UNIQUEIDENTIFIER NULL,
    [CreatedIP]               VARCHAR (50)     NULL,
    [ModifiedOn]              DATETIME         NULL,
    [ModifiedBy]              UNIQUEIDENTIFIER NULL,
    [ModifiedIP]              VARCHAR (50)     NULL,
    [ApplicationId]           UNIQUEIDENTIFIER NULL,
    [FirstName]               NVARCHAR (30)    NULL,
    [MiddleName]              NVARCHAR (30)    NULL,
    [LastName]                NVARCHAR (30)    NULL,
    [FullName]                AS               ((isnull([FirstName],'')+isnull(' '+[MiddleName],''))+isnull(' '+[LastName],'')),
    [TeamId]                  UNIQUEIDENTIFIER NULL,
    [Type]                    INT              NULL,
    [Status]                  INT              NULL,
    [Gender]                  INT              NULL,
    [EmployedFrom]            DATETIME         NULL,
    [QuitOn]                  DATETIME         NULL,
    [IDNP]                    VARCHAR (13)     NULL,
    [Birthdate]               DATETIME         NULL,
    [DidacticExperienceYears] INT              NULL,
    [HasPedagogicalStudies]   BIT              NULL,
    [DidacticDegree]          INT              NULL,
    [Education]               INT              NULL,
    [Position]                INT              NULL,
    [EmploymentType]          INT              NULL,
    [ContractDuration]        INT              NULL,
    [HoursPerWeek]            FLOAT (53)       NULL,
    [UserId]                  UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Employee] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Employee_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Employee_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Employee_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_Employee_CIMS_d_Gender] FOREIGN KEY ([Gender]) REFERENCES [dbo].[CIMS_d_Gender] ([ID]),
    CONSTRAINT [FK_CIMS_Employee_CIMS_d_Position] FOREIGN KEY ([Position]) REFERENCES [dbo].[CIMS_d_Position] ([ID])
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CIMS_Employee]
    ON [dbo].[CIMS_Employee]([UserId] ASC) WHERE ([UserId] IS NOT NULL);

