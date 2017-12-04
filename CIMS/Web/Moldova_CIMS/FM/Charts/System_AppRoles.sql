select T2.RoleId, T3.RoleName from aspnet_Membership T1
left join aspnet_UsersInRoles T2 ON T2.UserId=T1.UserId
inner join aspnet_Roles T3 ON T3.RoleId = T2.RoleId
where T1.ApplicationId=@ApplicationId