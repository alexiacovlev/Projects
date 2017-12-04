CREATE PROCEDURE [dbo].[prc_CIMS_StudyYear_Start] 
	@YearId uniqueidentifier,
	@College uniqueidentifier,
	@YearNr int
AS
BEGIN
SET NOCOUNT ON;

update CIMS_Groups
set GroupStatus = 2
where CurrentStudyYear = @YearNr and TeamId = @College

update CIMS_StudyYears set Status = 2 where id = @YearId

END