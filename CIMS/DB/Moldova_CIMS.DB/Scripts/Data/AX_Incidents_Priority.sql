USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate AX_Incidents_Priority
--

-- Disable all check on table
ALTER TABLE AX_Incidents_Priority NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM AX_Incidents_Priority WHERE [id] = 1)
BEGIN
    UPDATE AX_Incidents_Priority SET   [Priority] = N'Low' WHERE [id] = 1 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Priority ([id], [Priority]) VALUES (1, N'Low')
END

IF EXISTS (SELECT * FROM AX_Incidents_Priority WHERE [id] = 2)
BEGIN
    UPDATE AX_Incidents_Priority SET   [Priority] = N'Medium' WHERE [id] = 2 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Priority ([id], [Priority]) VALUES (2, N'Medium')
END

IF EXISTS (SELECT * FROM AX_Incidents_Priority WHERE [id] = 3)
BEGIN
    UPDATE AX_Incidents_Priority SET   [Priority] = N'High' WHERE [id] = 3 ;
END
ELSE
BEGIN
    INSERT INTO AX_Incidents_Priority ([id], [Priority]) VALUES (3, N'High')
END

-- Enable all check on table
ALTER TABLE AX_Incidents_Priority CHECK CONSTRAINT ALL



COMMIT

