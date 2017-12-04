CREATE TABLE [dbo].[AX_WF_StateTasks_Regarding] (
    [TaskId]        UNIQUEIDENTIFIER NOT NULL,
    [RegardingId]   UNIQUEIDENTIFIER NOT NULL,
    [RegardingType] INT              NOT NULL,
    CONSTRAINT [PK_AX_WF_StateTasks_Regarding] PRIMARY KEY CLUSTERED ([TaskId] ASC, [RegardingId] ASC),
    CONSTRAINT [FK_AX_WF_StateTasks_Regarding_AX_WF_StateTasks] FOREIGN KEY ([TaskId]) REFERENCES [dbo].[AX_WF_StateTasks] ([ID]) ON DELETE CASCADE
);

