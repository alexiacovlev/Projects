USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate AX_Incidents_Type
--

-- Disable all check on table
ALTER TABLE AX_Incidents_Type NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 1)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Bug',   [Color] = N'#FF0000' WHERE [id] = 1 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (1, N'Bug', N'#FF0000')
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 2)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Need support',   [Color] = N'#051CE0' WHERE [id] = 2 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (2, N'Need support', N'#051CE0')
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 3)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Enhancement',   [Color] = N'#3A8F3F' WHERE [id] = 3 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (3, N'Enhancement', N'#3A8F3F')
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 4)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Feature Request',   [Color] = N'#DE7238' WHERE [id] = 4 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (4, N'Feature Request', N'#DE7238')
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 5)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Misconfiguration',   [Color] = null WHERE [id] = 5 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (5, N'Misconfiguration', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 6)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Change Request',   [Color] = null WHERE [id] = 6 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (6, N'Change Request', null)
END

IF EXISTS (SELECT * FROM AX_Incidents_Type WHERE [id] = 7)
BEGIN
    UPDATE AX_Incidents_Type SET   [Type] = N'Requirement',   [Color] = null WHERE [id] = 7 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Type ([id], [Type], [Color]) VALUES (7, N'Requirement', null)
END

-- Enable all check on table
ALTER TABLE AX_Incidents_Type CHECK CONSTRAINT ALL



COMMIT

