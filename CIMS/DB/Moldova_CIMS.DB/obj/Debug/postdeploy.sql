/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

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


USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate aspnet_Roles
--

-- Disable all check on table
ALTER TABLE aspnet_Roles NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'c1f33cd1-1fd0-48ad-bd3a-8e46484e43dc')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'Administrators',   [LoweredRoleName] = N'administrators',   [Description] = null WHERE [RoleId] = N'c1f33cd1-1fd0-48ad-bd3a-8e46484e43dc' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'c1f33cd1-1fd0-48ad-bd3a-8e46484e43dc', N'Administrators', N'administrators', null)
END

IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'6e80a48a-070d-41f1-89ed-c4435be4bdd0')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'Registered Users',   [LoweredRoleName] = N'registered users',   [Description] = null WHERE [RoleId] = N'6e80a48a-070d-41f1-89ed-c4435be4bdd0' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'6e80a48a-070d-41f1-89ed-c4435be4bdd0', N'Registered Users', N'registered users', null)
END

-- Enable all check on table
ALTER TABLE aspnet_Roles CHECK CONSTRAINT ALL



COMMIT


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


GO
