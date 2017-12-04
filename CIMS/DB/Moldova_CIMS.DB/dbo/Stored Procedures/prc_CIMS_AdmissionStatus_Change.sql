CREATE PROCEDURE [dbo].[prc_CIMS_AdmissionStatus_Change] 
	@id uniqueidentifier,
	@Status int
AS
BEGIN
SET NOCOUNT ON;

update CIMS_Admission set Status = @Status where id = @id;
update CIMS_Applicant set AdmissionStatus = @Status where Admission = @id;
update CIMS_AdmissionOrders set AdmissionStatus = @Status where Admission = @id;

END