CREATE PROCEDURE [dbo].[prc_CIMS_AdmissionBySpecialty_Run] 
	@Admission uniqueidentifier,
	@Specialty uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @ID uniqueidentifier;
declare @TypeOfFinancing int;
declare @AdmissionCategory int;
declare @LocalityCategory int;
declare @NrOfVacancies int;

If(OBJECT_ID('tempdb..#mytemp') Is Not Null)
Begin
    Drop Table #mytemp
End

create table #mytemp(
	[ID] [uniqueidentifier],
	[Admission] [uniqueidentifier],
	[Specialty] [uniqueidentifier],
	[TypeOfFinancing] [int],
	[AdmissionCategory] [int],
	[LocalityCategory] [int],
	[NrOfVacancies] [int]
)

update CIMS_Applicant set Admission_Position = NULL where Admission = @Admission and Specialty = @Specialty;

insert into #mytemp
select ID, Admission, Specialty, TypeOfFinancing, AdmissionCategory, LocalityCategory, NrOfVacancies 
from CIMS_AdmissionVacancies 
where Admission = @Admission and Specialty = @Specialty

While EXISTS(select id from #mytemp)
	begin
	select top 1 @ID=ID
	, @TypeOfFinancing=TypeOfFinancing
	, @AdmissionCategory=AdmissionCategory
	, @LocalityCategory=LocalityCategory
	, @NrOfVacancies=NrOfVacancies 
	from #mytemp

	update a set a.Admission_Position = aa.Rown, a.Admission_VacanciesItem=@ID
	from CIMS_Applicant a
	inner join (
		select id, ROW_NUMBER() OVER(ORDER BY ApplicantAvgMark desc) as Rown 
		from CIMS_Applicant a 
		where PersonStatus = 2
		and Admission = @Admission
		and Specialty = @Specialty
		and TypeOfFinancing = @TypeOfFinancing
		and SpecialCategory = @AdmissionCategory
		and LocalityCategory = @LocalityCategory
		) aa on aa.id = a.id

	update CIMS_Applicant set Admission_Result = case when Admission_Position <= @NrOfVacancies then 1 else 2 end where Admission_VacanciesItem=@ID;
	delete from #mytemp where ID = @ID
	end
Drop Table #mytemp;

END