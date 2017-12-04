CREATE PROCEDURE [dbo].[prc_CIMS_GetLecturerByUser]
	@UserId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id from CIMS_Employee where UserId = @UserId
END