USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate aspnet_Applications
--

-- Disable all check on table
ALTER TABLE aspnet_Applications NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM aspnet_Applications WHERE [ApplicationId] = N'11111111-0000-1111-0000-000000000001')
BEGIN
    UPDATE aspnet_Applications SET   [ApplicationName] = N'default',   [LoweredApplicationName] = N'default',   [Description] = N'Alfasoft Portal' WHERE [ApplicationId] = N'11111111-0000-1111-0000-000000000001' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Applications ([ApplicationName], [LoweredApplicationName], [ApplicationId], [Description]) VALUES (N'default', N'default', N'11111111-0000-1111-0000-000000000001', N'Alfasoft Portal')
END

-- Enable all check on table
ALTER TABLE aspnet_Applications CHECK CONSTRAINT ALL



COMMIT

