-- =============================================
-- Author:		Alexandr Pascalov
-- Create date: 24/10/2017
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[prc_CIMS_UM_GetUserTeam] 
	-- Add the parameters for the stored procedure here
	@userName nvarchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @userId uniqueidentifier;

	SELECT @userId=UserId FROM aspnet_Users WHERE UserName=@userName;
	
	 SELECT TOP 1 tu.TeamId, t.Name 
	 FROM  aspnet_Team2Users as tu
	 INNER JOIN aspnet_Teams as t ON t.Id=tu.TeamId
	 WHERE tu.PortalUserId=@userId;


END