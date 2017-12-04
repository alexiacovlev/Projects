CREATE TABLE [dbo].[CIMS_Timetable_Hours] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [TeamId]        UNIQUEIDENTIFIER NULL,
    [HourNr]        INT              NULL,
    [StartTime]     INT              NULL,
    [EndTime]       INT              NULL,
    [Duration]      INT              NULL,
    [Comments]      NVARCHAR (100)   NULL,
    [StartTimeF]    AS               ((right('0'+CONVERT([varchar](2),[StartTime]/(60)),(2))+':')+right('0'+CONVERT([varchar](2),[StartTime]%(60)),(2))),
    [EndTimeF]      AS               ((right('0'+CONVERT([varchar](2),[EndTime]/(60)),(2))+':')+right('0'+CONVERT([varchar](2),[EndTime]%(60)),(2))),
    CONSTRAINT [PK_CIMS_Timetable_Hours] PRIMARY KEY CLUSTERED ([ID] ASC)
);

