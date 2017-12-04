CREATE TABLE [dbo].[CIMS_StudyPlanItems2Lecturers] (
    [ParentID]  UNIQUEIDENTIFIER NOT NULL,
    [ObjectID]  UNIQUEIDENTIFIER NOT NULL,
    [HoursType] INT              NOT NULL,
    CONSTRAINT [PK_CIMS_StudyPlanItems2Lecturers] PRIMARY KEY CLUSTERED ([ParentID] ASC, [ObjectID] ASC, [HoursType] ASC)
);

