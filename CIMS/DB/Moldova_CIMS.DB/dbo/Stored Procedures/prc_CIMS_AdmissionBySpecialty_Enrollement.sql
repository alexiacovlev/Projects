CREATE PROCEDURE [dbo].[prc_CIMS_AdmissionBySpecialty_Enrollement] 
	@Admission uniqueidentifier,
	@Specialty uniqueidentifier,
	@Order uniqueidentifier
AS
BEGIN
SET NOCOUNT ON;

declare @ID uniqueidentifier;
declare @TypeOfFinancing int;
declare @AdmissionCategory int;
declare @LocalityCategory int;
declare @NrOfVacancies int;

update CIMS_Applicant 
set AdmissionOrder = @Order
, PersonStatus = 3
where Admission = @Admission
and Specialty = @Specialty
and Admission_Result = 1
and AdmissionOrder is null
and PersonStatus = 2

update CIMS_Applicant 
set AdmissionOrder = @Order
, PersonStatus = 5
where Admission = @Admission
and Specialty = @Specialty
and Admission_Result = 2
and AdmissionOrder is null
and PersonStatus = 2


INSERT INTO [dbo].[CIMS_Student]
           ([ID]
           ,[CreatedOn]
           ,[CreatedBy]
           ,[CreatedIP]
           ,[ModifiedOn]
           ,[ModifiedBy]
           ,[ModifiedIP]
           ,[ApplicationId]
           ,[TeamId]
           ,[FirstName]
           ,[LastName]
           ,[MiddleName]
           ,[Application]
           ,[CardNr]
           ,[BirthDay]
           ,[BirthPlace]
           ,[Gender]
           ,[ResidenceCountry]
           ,[ResidenceRaion]
           ,[ResidenceLocality]
           ,[ResidenceAddress]
           ,[ResidenceHomePhone]
           ,[ResidenceParentPhone]
           ,[ResidenceStudentMobile]
           ,[ResidenceStudentEMail]
           ,[ID_Type]
           ,[ID_Series]
           ,[ID_Number]
           ,[ID_IssuedBy]
           ,[ID_IssuedOn]
           ,[IDNP]
           ,[Citizenship]
           ,[Ethnicity]
           ,[MilitaryTypeOfEvidence]
           ,[MilitaryDocumentNr]
           ,[MilitaryDocumentIssuedOn]
           ,[FatherFullName]
           ,[MotherFullName]
           ,[NumberOfParents]
           ,[NumberOfChildrenInFamily]
           ,[LanguageOfStudying]
           ,[NeedADorm]
           ,[OnlyStateBudget]
           ,[ForeignLanguageStudied]
           ,[WorkExperience]
           ,[OlympicAwards]
           ,[OlimpicAwardsDetails]
           ,[GraduatedInstitutionName]
           ,[GraduatedInstitutionCountry]
           ,[GraduatedInstitutionRaion]
           ,[GraduatedInstitutionLocality]
           ,[GraduatedInstitutionEnvironment]
           ,[GraduatedInstitutionType]
           ,[GraduatedInstitutionGrade]
           ,[GraduatedInstitutionYear]
           ,[GraduatedInstitutionAverageMark]
           ,[CertificateOfEducationType]
           ,[CertificateOfEducationNumber]
           ,[CertificateOfEducationIssuedOn]
           ,[Specialty]
           ,[Admission]
           ,[PersonStatus]
           ,[Photo]
           ,[GroupId]
           ,[DormNr]
           ,[DormAddress]
           ,[DormFloor]
           ,[DormRoomNr]
           ,[DormRoomCapacity]
           ,[Facilities]
           ,[FacilitiesProof]
           ,[DecisionReason]
           ,[TypeOfFinancing]
           ,[LocalityCategory]
           ,[ShareOfAdmissionVacancies]
           ,[LivingEnvironment]
           ,[SpecialCategory]
           ,[SpecialAdmissionCategoryItem]
           ,[Recommendation]
           ,[RecommendationDetails]
           ,[CertificateOfEducationSeries]
           ,[SpecialCategoryDocument])

select [ID]
           ,[CreatedOn]
           ,[CreatedBy]
           ,[CreatedIP]
           ,[ModifiedOn]
           ,[ModifiedBy]
           ,[ModifiedIP]
           ,[ApplicationId]
           ,[TeamId]
           ,[FirstName]
           ,[LastName]
           ,[MiddleName]
           ,ID
           ,[CardNr]
           ,[BirthDay]
           ,[BirthPlace]
           ,[Gender]
           ,[ResidenceCountry]
           ,[ResidenceRaion]
           ,[ResidenceLocality]
           ,[ResidenceAddress]
           ,[ResidenceHomePhone]
           ,[ResidenceParentPhone]
           ,[ResidenceApplicantMobile]
           ,[ResidenceApplicantEMail]
           ,[ID_Type]
           ,[ID_Series]
           ,[ID_Number]
           ,[ID_IssuedBy]
           ,[ID_IssuedOn]
           ,[IDNP]
           ,[Citizenship]
           ,[Ethnicity]
           ,[MilitaryTypeOfEvidence]
           ,[MilitaryDocumentNr]
           ,[MilitaryDocumentIssuedOn]
           ,[FatherFullName]
           ,[MotherFullName]
           ,[NumberOfParents]
           ,[NumberOfChildrenInFamily]
           ,[LanguageOfStudying]
           ,[NeedADorm]
           ,[OnlyStateBudget]
           ,[ForeignLanguageStudied]
           ,[WorkExperience]
           ,[OlympicAwards]
           ,[OlimpicAwardsDetails]
           ,[GraduatedInstitutionName]
           ,[GraduatedInstitutionCountry]
           ,[GraduatedInstitutionRaion]
           ,[GraduatedInstitutionLocality]
           ,[GraduatedInstitutionEnvironment]
           ,[GraduatedInstitutionType]
           ,[GraduatedInstitutionGrade]
           ,[GraduatedInstitutionYear]
           ,[GraduatedInstitutionAverageMark]
           ,[CertificateOfEducationType]
           ,[CertificateOfEducationNumber]
           ,[CertificateOfEducationIssuedOn]
           ,[Specialty]
           ,[Admission]
           ,[PersonStatus]
           ,[Photo]
           ,[GroupId]
           ,[DormNr]
           ,[DormAddress]
           ,[DormFloor]
           ,[DormRoomNr]
           ,[DormRoomCapacity]
           ,[Facilities]
           ,[FacilitiesProof]
           ,[DecisionReason]
           ,[TypeOfFinancing]
           ,[LocalityCategory]
           ,[ShareOfAdmissionVacancies]
           ,[LivingEnvironment]
           ,[SpecialCategory]
           ,[SpecialAdmissionCategoryItem]
           ,[Recommendation]
           ,[RecommendationDetails]
           ,[CertificateOfEducationSeries]
           ,[SpecialCategoryDocument]
from CIMS_Applicant 
where Admission = @Admission
and Specialty = @Specialty
and Admission_Result = 1
and AdmissionOrder = @Order
and PersonStatus = 3

END