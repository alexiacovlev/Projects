CREATE TABLE [dbo].[CIMS_AdmissionOrders] (
    [ID]                UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]         DATETIME         NULL,
    [CreatedBy]         UNIQUEIDENTIFIER NULL,
    [CreatedIP]         VARCHAR (50)     NULL,
    [ModifiedOn]        DATETIME         NULL,
    [ModifiedBy]        UNIQUEIDENTIFIER NULL,
    [ModifiedIP]        VARCHAR (50)     NULL,
    [ApplicationId]     UNIQUEIDENTIFIER NULL,
    [TeamId]            UNIQUEIDENTIFIER NULL,
    [Admission]         UNIQUEIDENTIFIER NULL,
    [Specialty]         UNIQUEIDENTIFIER NULL,
    [OrderNr]           NVARCHAR (100)   NULL,
    [OrderDate]         DATETIME         NULL,
    [AdmissionChairman] UNIQUEIDENTIFIER NULL,
    [ResponsiblePerson] UNIQUEIDENTIFIER NULL,
    [OrderStatus]       INT              NULL,
    [AdmissionStatus]   INT              NULL,
    CONSTRAINT [PK_CIMS_AdmissionOrders] PRIMARY KEY CLUSTERED ([ID] ASC)
);



