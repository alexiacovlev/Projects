﻿CREATE TABLE [dbo].[AX_Incidents] (
    [id]                         UNIQUEIDENTIFIER CONSTRAINT [DF1_Incident_id] DEFAULT (newid()) NOT NULL,
    [RelationObjectID]           UNIQUEIDENTIFIER NULL,
    [RelationObjectTypeId]       INT              NULL,
    [ParentIncidentId]           UNIQUEIDENTIFIER NULL,
    [IncidentNr]                 NVARCHAR (50)    NULL,
    [Subject]                    NVARCHAR (1024)  NOT NULL,
    [Description]                NVARCHAR (MAX)   NULL,
    [Comments]                   NVARCHAR (MAX)   NULL,
    [InProgress]                 BIT              NULL,
    [Result]                     NVARCHAR (MAX)   NULL,
    [ResultDate]                 DATETIME         NULL,
    [ResolutionCode]             INT              NULL,
    [ControlDate]                DATETIME         NULL,
    [IncidentTypeId]             INT              NULL,
    [PriorityCodeId]             INT              NULL,
    [IncidentStatusId]           INT              NULL,
    [IncidentStateId]            INT              NULL,
    [AssignTo]                   UNIQUEIDENTIFIER NULL,
    [RequestedBy]                UNIQUEIDENTIFIER NULL,
    [ModifiedIP]                 NVARCHAR (20)    NULL,
    [ModifiedOn]                 DATETIME         NULL,
    [ModifiedBy]                 UNIQUEIDENTIFIER NULL,
    [CreatedOn]                  DATETIME         NULL,
    [CreatedBy]                  UNIQUEIDENTIFIER NULL,
    [CreatedIP]                  NVARCHAR (20)    NULL,
    [ApplicationId]              UNIQUEIDENTIFIER NULL,
    [TeamId]                     UNIQUEIDENTIFIER NULL,
    [RequestedName]              NVARCHAR (150)   NULL,
    [RequestedDate]              DATETIME         NULL,
    [ApprovedId]                 UNIQUEIDENTIFIER NULL,
    [ApprovedName]               NVARCHAR (150)   NULL,
    [ApprovedAcceptingPartyId]   UNIQUEIDENTIFIER NULL,
    [ApprovedAcceptingPartyName] NVARCHAR (150)   NULL,
    [ApprovedAcceptingPartyDate] DATETIME         NULL,
    [EstimatedTime]              NVARCHAR (50)    NULL,
    [AffectedModules]            NVARCHAR (MAX)   NULL,
    [ResonForChange]             NVARCHAR (MAX)   NULL,
    [ExpectedDeadline]           DATETIME         NULL,
    [ApprovedDate]               DATETIME         NULL,
    [EstimatedTimeDescription]   NVARCHAR (MAX)   NULL,
    [ActualStart]                DATETIME         NULL,
    [ActualEnd]                  DATETIME         NULL,
    [SendNotification]           BIT              NULL,
    [StateReason]                NVARCHAR (250)   NULL,
    [AssignTo_FullName]          NVARCHAR (100)   NULL,
    [RequestedBy_FullName]       NVARCHAR (100)   NULL,
    [CreatedBy_FullName]         NVARCHAR (100)   NULL,
    [ModifiedBy_FullName]        NVARCHAR (100)   NULL,
    [RequestURL]                 NVARCHAR (150)   NULL,
    [IncidentApplicationId]      UNIQUEIDENTIFIER NULL,
    [Screenshot]                 IMAGE            NULL,
    [PostedByUser]               BIT              NULL,
    [IsWorkflowCreated]          BIT              NULL,
    [Work_Hours]                 INT              NULL,
    [CreatedOn_Year]             AS               (datepart(year,[CreatedOn])),
    [CreatedOn_Month]            AS               (datepart(month,[CreatedOn])),
    CONSTRAINT [PK_AX_Incidents] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_AX1_Incidents_aspnet_Applications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId]) ON DELETE CASCADE
);

