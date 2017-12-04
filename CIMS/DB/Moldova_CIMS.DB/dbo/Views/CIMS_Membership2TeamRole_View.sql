

CREATE VIEW [dbo].[CIMS_Membership2TeamRole_View]
AS
select m.*, tu.TeamId, r.RoleName
, case 
	when exists (select top 1 id from CIMS_Student where UserId = m.UserId) then 1
	when exists (select top 1 id from CIMS_Employee where UserId = m.UserId) then 1
	else 0
end as AssigneToProfile

from aspnet_Membership m
inner join aspnet_Team2Users tu on tu.PortalUserId = m.UserId
inner join aspnet_UsersInRoles ur on ur.UserId = m.UserId
inner join aspnet_Roles r on r.RoleId = ur.RoleId