-- =============================================
-- Author:		Alexandr Pascalov
-- Create date: 24/10/2017
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[prc_CIMS_UM_IsUserInTheSameTeam] 
	-- Add the parameters for the stored procedure here
	@userId uniqueidentifier,
	@teamId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT COUNT(TeamId) FROM aspnet_Team2Users WHERE PortalUserId=@userId AND TeamId=@teamId
	
END