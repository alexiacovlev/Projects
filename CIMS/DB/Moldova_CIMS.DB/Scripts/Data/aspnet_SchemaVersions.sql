USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate aspnet_SchemaVersions
--

-- Disable all check on table
ALTER TABLE aspnet_SchemaVersions NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'common')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'common' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'common', N'1', 1)
END

IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'health monitoring')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'health monitoring' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'health monitoring', N'1', 1)
END

IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'membership')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'membership' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'membership', N'1', 1)
END

IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'personalization')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'personalization' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'personalization', N'1', 1)
END

IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'profile')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'profile' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'profile', N'1', 1)
END

IF EXISTS (SELECT * FROM aspnet_SchemaVersions WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'role manager')
BEGIN
    UPDATE aspnet_SchemaVersions SET   [IsCurrentVersion] = 1 WHERE [CompatibleSchemaVersion] = N'1' AND [Feature] = N'role manager' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_SchemaVersions ([Feature], [CompatibleSchemaVersion], [IsCurrentVersion]) VALUES (N'role manager', N'1', 1)
END

-- Enable all check on table
ALTER TABLE aspnet_SchemaVersions CHECK CONSTRAINT ALL



COMMIT

