CREATE VIEW [dbo].[CIMS_Membership2Team_View]
AS
select m.*, tu.TeamId
from aspnet_Membership m
inner join aspnet_Team2Users tu on tu.PortalUserId = m.UserId