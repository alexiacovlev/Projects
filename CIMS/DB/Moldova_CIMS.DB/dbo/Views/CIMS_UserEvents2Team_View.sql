CREATE VIEW [dbo].[CIMS_UserEvents2Team_View]
AS
select e.*, tu.TeamId
from AX_UserEvents e
inner join aspnet_Team2Users tu on tu.PortalUserId = e.UserId