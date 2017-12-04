CREATE PROCEDURE [dbo].[prc_CIMS_GetStudentByUser]
	@UserId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id from CIMS_Student where UserId = @UserId
END