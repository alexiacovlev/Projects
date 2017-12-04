USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate AX_Incidents_Status
--

-- Disable all check on table
ALTER TABLE AX_Incidents_Status NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 1)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Submitted',   [Description] = N'Created Incident',   [Color] = N'#AA0000' WHERE [id] = 1 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (1, N'Submitted', N'Created Incident', N'#AA0000')
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 2)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Impact Assessed',   [Description] = N'Set Incident in Impact stage',   [Color] = null WHERE [id] = 2 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (2, N'Impact Assessed', N'Set Incident in Impact stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 3)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'On Hold',   [Description] = N'Set Incident in On Hold stage',   [Color] = null WHERE [id] = 3 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (3, N'On Hold', N'Set Incident in On Hold stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 4)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Declined',   [Description] = N'Incident id Declined',   [Color] = null WHERE [id] = 4 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (4, N'Declined', N'Incident id Declined', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 5)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'In Progress',   [Description] = N'Set Incident in Progress stage',   [Color] = null WHERE [id] = 5 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (5, N'In Progress', N'Set Incident in Progress stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 6)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Ready for Testing',   [Description] = N'Set Incident in Ready for Testing stage',   [Color] = N'#3A8F3F' WHERE [id] = 6 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (6, N'Ready for Testing', N'Set Incident in Ready for Testing stage', N'#3A8F3F')
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 7)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Resolved',   [Description] = N'Incident is Resolved',   [Color] = N'#5566FB' WHERE [id] = 7 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (7, N'Resolved', N'Incident is Resolved', N'#5566FB')
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 8)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Cancelled',   [Description] = N'Set Incident is Canceled stage',   [Color] = null WHERE [id] = 8 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (8, N'Cancelled', N'Set Incident is Canceled stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 9)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Reopened',   [Description] = N'Set Incident is Reopened stage',   [Color] = null WHERE [id] = 9 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (9, N'Reopened', N'Set Incident is Reopened stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 10)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Postponed',   [Description] = N'Set Incident is Postponed stage',   [Color] = null WHERE [id] = 10 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (10, N'Postponed', N'Set Incident is Postponed stage', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Status WHERE [id] = 11)
BEGIN
    UPDATE AX_Incidents_Status SET   [Status] = N'Not Accepted',   [Description] = N'Incident is Not accepted',   [Color] = null WHERE [id] = 11 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Status ([id], [Status], [Description], [Color]) VALUES (11, N'Not Accepted', N'Incident is Not accepted', null)
END

-- Enable all check on table
ALTER TABLE AX_Incidents_Status CHECK CONSTRAINT ALL



COMMIT

