USE [$(DatabaseName)]

BEGIN TRAN

--
--  Generate aspnet_Teams
--

-- Disable all check on table
ALTER TABLE aspnet_Teams NOCHECK CONSTRAINT ALL

-- Insert new records
IF EXISTS (SELECT * FROM aspnet_Teams WHERE [Id] = N'bedf58f7-224f-480b-9aec-1a231703678a')
BEGIN
    UPDATE aspnet_Teams SET   [DeletionStateCode] = null,   [OrganizationId] = null,   [BusinessUnitId] = null,   [Name] = N'Center of Excellence in Informatics and Informational Technologies',   [Description] = null,   [Address] = null,   [EMailAddress] = null,   [CreatedOn] = null,   [CreatedBy] = null,   [CreatedIP] = null,   [ModifiedOn] = null,   [ModifiedBy] = null,   [ModifiedIP] = null,   [DomainName] = null,   [ApplicationId] = null WHERE [Id] = N'bedf58f7-224f-480b-9aec-1a231703678a' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Teams ([Id], [DeletionStateCode], [OrganizationId], [BusinessUnitId], [Name], [Description], [Address], [EMailAddress], [CreatedOn], [CreatedBy], [CreatedIP], [ModifiedOn], [ModifiedBy], [ModifiedIP], [DomainName], [ApplicationId]) VALUES (N'bedf58f7-224f-480b-9aec-1a231703678a', null, null, null, N'Center of Excellence in Informatics and Informational Technologies', null, null, null, null, null, null, null, null, null, null, null)
END

IF EXISTS (SELECT * FROM aspnet_Teams WHERE [Id] = N'8c22f766-98cb-4aa0-baed-20349ecb5443')
BEGIN
    UPDATE aspnet_Teams SET   [DeletionStateCode] = null,   [OrganizationId] = null,   [BusinessUnitId] = null,   [Name] = N'Construction College',   [Description] = null,   [Address] = null,   [EMailAddress] = null,   [CreatedOn] = null,   [CreatedBy] = null,   [CreatedIP] = null,   [ModifiedOn] = null,   [ModifiedBy] = null,   [ModifiedIP] = null,   [DomainName] = null,   [ApplicationId] = null WHERE [Id] = N'8c22f766-98cb-4aa0-baed-20349ecb5443' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Teams ([Id], [DeletionStateCode], [OrganizationId], [BusinessUnitId], [Name], [Description], [Address], [EMailAddress], [CreatedOn], [CreatedBy], [CreatedIP], [ModifiedOn], [ModifiedBy], [ModifiedIP], [DomainName], [ApplicationId]) VALUES (N'8c22f766-98cb-4aa0-baed-20349ecb5443', null, null, null, N'Construction College', null, null, null, null, null, null, null, null, null, null, null)
END

IF EXISTS (SELECT * FROM aspnet_Teams WHERE [Id] = N'fdec2c48-05a0-4e2e-a901-6d9b6bedb92b')
BEGIN
    UPDATE aspnet_Teams SET   [DeletionStateCode] = null,   [OrganizationId] = null,   [BusinessUnitId] = null,   [Name] = N'College of Informatics',   [Description] = null,   [Address] = null,   [EMailAddress] = null,   [CreatedOn] = null,   [CreatedBy] = null,   [CreatedIP] = null,   [ModifiedOn] = null,   [ModifiedBy] = null,   [ModifiedIP] = null,   [DomainName] = null,   [ApplicationId] = null WHERE [Id] = N'fdec2c48-05a0-4e2e-a901-6d9b6bedb92b' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Teams ([Id], [DeletionStateCode], [OrganizationId], [BusinessUnitId], [Name], [Description], [Address], [EMailAddress], [CreatedOn], [CreatedBy], [CreatedIP], [ModifiedOn], [ModifiedBy], [ModifiedIP], [DomainName], [ApplicationId]) VALUES (N'fdec2c48-05a0-4e2e-a901-6d9b6bedb92b', null, null, null, N'College of Informatics', null, null, null, null, null, null, null, null, null, null, null)
END

IF EXISTS (SELECT * FROM aspnet_Teams WHERE [Id] = N'19c6a7ba-22ba-41d6-b397-74f0fa4579e7')
BEGIN
    UPDATE aspnet_Teams SET   [DeletionStateCode] = null,   [OrganizationId] = null,   [BusinessUnitId] = null,   [Name] = N'College of Finance',   [Description] = null,   [Address] = null,   [EMailAddress] = null,   [CreatedOn] = null,   [CreatedBy] = null,   [CreatedIP] = null,   [ModifiedOn] = null,   [ModifiedBy] = null,   [ModifiedIP] = null,   [DomainName] = null,   [ApplicationId] = null WHERE [Id] = N'19c6a7ba-22ba-41d6-b397-74f0fa4579e7' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Teams ([Id], [DeletionStateCode], [OrganizationId], [BusinessUnitId], [Name], [Description], [Address], [EMailAddress], [CreatedOn], [CreatedBy], [CreatedIP], [ModifiedOn], [ModifiedBy], [ModifiedIP], [DomainName], [ApplicationId]) VALUES (N'19c6a7ba-22ba-41d6-b397-74f0fa4579e7', null, null, null, N'College of Finance', null, null, null, null, null, null, null, null, null, null, null)
END

IF EXISTS (SELECT * FROM aspnet_Teams WHERE [Id] = N'0e5e79f6-d894-4127-8122-7d01265e9e8a')
BEGIN
    UPDATE aspnet_Teams SET   [DeletionStateCode] = null,   [OrganizationId] = null,   [BusinessUnitId] = null,   [Name] = N'Medical College',   [Description] = null,   [Address] = null,   [EMailAddress] = null,   [CreatedOn] = null,   [CreatedBy] = null,   [CreatedIP] = null,   [ModifiedOn] = null,   [ModifiedBy] = null,   [ModifiedIP] = null,   [DomainName] = null,   [ApplicationId] = null WHERE [Id] = N'0e5e79f6-d894-4127-8122-7d01265e9e8a' ;
END
ELSE
BEGIN
    INSERT INTO aspnet_Teams ([Id], [DeletionStateCode], [OrganizationId], [BusinessUnitId], [Name], [Description], [Address], [EMailAddress], [CreatedOn], [CreatedBy], [CreatedIP], [ModifiedOn], [ModifiedBy], [ModifiedIP], [DomainName], [ApplicationId]) VALUES (N'0e5e79f6-d894-4127-8122-7d01265e9e8a', null, null, null, N'Medical College', null, null, null, null, null, null, null, null, null, null, null)
END

-- Enable all check on table
ALTER TABLE aspnet_Teams CHECK CONSTRAINT ALL



COMMIT

