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

IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'234d5c85-98cd-4335-a453-d233ab456582')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'CollegeAdmin',   [LoweredRoleName] = N'collegeadmin',   [Description] = null WHERE [RoleId] = N'234d5c85-98cd-4335-a453-d233ab456582' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'234d5c85-98cd-4335-a453-d233ab456582', N'CollegeAdmin', N'collegeadmin', null)
END

IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'1ef8a2d2-7e04-4472-b456-1fe85d9819ca')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'Lecturer',   [LoweredRoleName] = N'lecturer',   [Description] = null WHERE [RoleId] = N'1ef8a2d2-7e04-4472-b456-1fe85d9819ca' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'1ef8a2d2-7e04-4472-b456-1fe85d9819ca', N'Lecturer', N'lecturer', null)
END

IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'6e80a48a-070d-41f1-89ed-c4435be4bdd0')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'Registered Users',   [LoweredRoleName] = N'registered users',   [Description] = null WHERE [RoleId] = N'6e80a48a-070d-41f1-89ed-c4435be4bdd0' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'6e80a48a-070d-41f1-89ed-c4435be4bdd0', N'Registered Users', N'registered users', null)
END

IF EXISTS (SELECT * FROM aspnet_Roles WHERE [RoleId] = N'ba3db080-cff2-475b-91bf-3c6cd5ed0f4a')
BEGIN
    UPDATE aspnet_Roles SET   [ApplicationId] = N'11111111-0000-1111-0000-000000000001',   [RoleName] = N'Student',   [LoweredRoleName] = N'student',   [Description] = null WHERE [RoleId] = N'ba3db080-cff2-475b-91bf-3c6cd5ed0f4a' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Roles ([ApplicationId], [RoleId], [RoleName], [LoweredRoleName], [Description]) VALUES (N'11111111-0000-1111-0000-000000000001', N'ba3db080-cff2-475b-91bf-3c6cd5ed0f4a', N'Student', N'student', null)
END

-- Enable all check on table
ALTER TABLE aspnet_Roles CHECK CONSTRAINT ALL



COMMIT

