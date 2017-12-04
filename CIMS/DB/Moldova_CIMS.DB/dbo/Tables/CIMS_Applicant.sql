﻿CREATE TABLE [dbo].[CIMS_Applicant] (
    [ID]                              UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]                       DATETIME         NULL,
    [CreatedBy]                       UNIQUEIDENTIFIER NULL,
    [CreatedIP]                       VARCHAR (50)     NULL,
    [ModifiedOn]                      DATETIME         NULL,
    [ModifiedBy]                      UNIQUEIDENTIFIER NULL,
    [ModifiedIP]                      VARCHAR (50)     NULL,
    [ApplicationId]                   UNIQUEIDENTIFIER NULL,
    [TeamId]                          UNIQUEIDENTIFIER NULL,
    [FirstName]                       NVARCHAR (30)    NULL,
    [LastName]                        NVARCHAR (30)    NULL,
    [MiddleName]                      NVARCHAR (30)    NULL,
    [ApplicationNr]                   NVARCHAR (100)   NULL,
    [CardNr]                          NVARCHAR (100)   NULL,
    [ApplicationStatus]               INT              NULL,
    [ApplicationDate]                 DATETIME         NULL,
    [BirthDay]                        DATETIME         NULL,
    [BirthPlace]                      NVARCHAR (200)   NULL,
    [Gender]                          INT              NULL,
    [ID_Type]                         INT              NULL,
    [ID_Number]                       NVARCHAR (100)   NULL,
    [ID_IssuedBy]                     NVARCHAR (100)   NULL,
    [ID_IssuedOn]                     DATETIME         NULL,
    [IDNP]                            NVARCHAR (13)    NULL,
    [Citizenship]                     INT              NULL,
    [Ethnicity]                       INT              NULL,
    [MilitaryTypeOfEvidence]          INT              NULL,
    [MilitaryDocumentNr]              NVARCHAR (50)    NULL,
    [MilitaryDocumentIssuedOn]        DATETIME         NULL,
    [ResidenceCountry]                INT              NULL,
    [ResidenceRaion]                  INT              NULL,
    [ResidenceLocality]               INT              NULL,
    [ResidenceAddress]                NVARCHAR (200)   NULL,
    [ResidenceHomePhone]              NVARCHAR (100)   NULL,
    [ResidenceParentPhone]            NVARCHAR (100)   NULL,
    [ResidenceApplicantMobile]        NVARCHAR (100)   NULL,
    [ResidenceApplicantEMail]         NVARCHAR (100)   NULL,
    [FatherFullName]                  NVARCHAR (100)   NULL,
    [MotherFullName]                  NVARCHAR (100)   NULL,
    [NumberOfParents]                 INT              NULL,
    [NumberOfChildrenInFamily]        INT              NULL,
    [ShareOfAdmissionVacancies]       INT              NULL,
    [SpecialCategory]                 INT              NULL,
    [LanguageOfStudying]              INT              NULL,
    [NeedADorm]                       BIT              NULL,
    [OnlyStateBudget]                 BIT              NULL,
    [ForeignLanguageStudied]          INT              NULL,
    [WorkExperience]                  INT              NULL,
    [OlympicAwards]                   BIT              NULL,
    [OlimpicAwardsDetails]            NVARCHAR (200)   NULL,
    [GraduatedInstitutionName]        NVARCHAR (100)   NULL,
    [GraduatedInstitutionCountry]     INT              NULL,
    [GraduatedInstitutionRaion]       INT              NULL,
    [GraduatedInstitutionLocality]    INT              NULL,
    [GraduatedInstitutionEnvironment] INT              NULL,
    [GraduatedInstitutionType]        INT              NULL,
    [GraduatedInstitutionGrade]       INT              NULL,
    [GraduatedInstitutionYear]        INT              NULL,
    [GraduatedInstitutionAverageMark] FLOAT (53)       NULL,
    [DocApplication]                  BIT              NULL,
    [DocMedicalCertificate]           BIT              NULL,
    [DocPhoto]                        BIT              NULL,
    [DocStudiesCertificate]           BIT              NULL,
    [DocCopyOfPersonalID]             BIT              NULL,
    [DocCopyOfPersonalIDParent]       BIT              NULL,
    [DocCopyOfBirthCertificate]       BIT              NULL,
    [DocCopyOfRecrutingCertificate]   BIT              NULL,
    [DocFamilyComponentsCertificate]  BIT              NULL,
    [DocOther]                        NVARCHAR (1000)  NULL,
    [LivingEnvironment]               INT              NULL,
    [CertificateOfEducationType]      INT              NULL,
    [CertificateOfEducationNumber]    NVARCHAR (100)   NULL,
    [CertificateOfEducationIssuedOn]  DATETIME         NULL,
    [Specialty]                       UNIQUEIDENTIFIER NULL,
    [Admission]                       UNIQUEIDENTIFIER NULL,
    [PersonStatus]                    INT              NULL,
    [Photo]                           IMAGE            NULL,
    [GroupId]                         UNIQUEIDENTIFIER NULL,
    [DormNr]                          NVARCHAR (100)   NULL,
    [DormAddress]                     NVARCHAR (255)   NULL,
    [DormFloor]                       INT              NULL,
    [DormRoomNr]                      NVARCHAR (100)   NULL,
    [DormRoomCapacity]                INT              NULL,
    [Facilities]                      NVARCHAR (255)   NULL,
    [FacilitiesProof]                 NVARCHAR (1000)  NULL,
    [ApplicantAvgMark]                FLOAT (53)       NULL,
    [DecisionReason]                  NVARCHAR (1024)  NULL,
    [TypeOfFinancing]                 INT              NULL,
    [LocalityCategory]                INT              NULL,
    [SpecialAdmissionCategoryItem]    INT              NULL,
    [MarkMNDP]                        FLOAT (53)       NULL,
    [MarkMNEA]                        FLOAT (53)       NULL,
    [Recommendation]                  BIT              NULL,
    [RecommendationDetails]           NVARCHAR (250)   NULL,
    [Admission_Position]              INT              NULL,
    [Admission_VacanciesItem]         UNIQUEIDENTIFIER NULL,
    [Admission_Result]                INT              NULL,
    [AdmissionOrder]                  UNIQUEIDENTIFIER NULL,
    [ID_Series]                       NVARCHAR (5)     NULL,
    [CertificateOfEducationSeries]    NVARCHAR (5)     NULL,
    [SpecialCategoryDocument]         NVARCHAR (500)   NULL,
    [Cancel]                          BIT              NULL,
    [AdmissionStatus]                 INT              NULL,
    CONSTRAINT [PK_CIMS_Applicant] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Applicant_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Applicant_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Applicant_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_Admission] FOREIGN KEY ([Admission]) REFERENCES [dbo].[CIMS_Admission] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_ApplicationStatus] FOREIGN KEY ([ApplicationStatus]) REFERENCES [dbo].[CIMS_d_ApplicationStatus] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Country] FOREIGN KEY ([Citizenship]) REFERENCES [dbo].[CIMS_d_Country] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Country1] FOREIGN KEY ([ResidenceCountry]) REFERENCES [dbo].[CIMS_d_Country] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Country2] FOREIGN KEY ([GraduatedInstitutionCountry]) REFERENCES [dbo].[CIMS_d_Country] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Ethnicity] FOREIGN KEY ([Ethnicity]) REFERENCES [dbo].[CIMS_d_Ethnicity] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Gender] FOREIGN KEY ([Gender]) REFERENCES [dbo].[CIMS_d_Gender] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Grade] FOREIGN KEY ([GraduatedInstitutionGrade]) REFERENCES [dbo].[CIMS_d_Grade] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Language] FOREIGN KEY ([LanguageOfStudying]) REFERENCES [dbo].[CIMS_d_Language] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Language1] FOREIGN KEY ([ForeignLanguageStudied]) REFERENCES [dbo].[CIMS_d_Language] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_LivingEnvironment] FOREIGN KEY ([GraduatedInstitutionEnvironment]) REFERENCES [dbo].[CIMS_d_LivingEnvironment] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_LivingEnvironment1] FOREIGN KEY ([LivingEnvironment]) REFERENCES [dbo].[CIMS_d_LivingEnvironment] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Locality] FOREIGN KEY ([ResidenceLocality]) REFERENCES [dbo].[CIMS_d_Locality] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Locality1] FOREIGN KEY ([GraduatedInstitutionLocality]) REFERENCES [dbo].[CIMS_d_Locality] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Raion] FOREIGN KEY ([ResidenceRaion]) REFERENCES [dbo].[CIMS_d_Raion] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_Raion1] FOREIGN KEY ([GraduatedInstitutionRaion]) REFERENCES [dbo].[CIMS_d_Raion] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_ShareOfAdmissionVacancies] FOREIGN KEY ([ShareOfAdmissionVacancies]) REFERENCES [dbo].[CIMS_d_ShareOfAdmissionVacancies] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_SpecialAdmissionCategories] FOREIGN KEY ([SpecialCategory]) REFERENCES [dbo].[CIMS_d_SpecialAdmissionCategories] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_TypeOfDocument] FOREIGN KEY ([CertificateOfEducationType]) REFERENCES [dbo].[CIMS_d_TypeOfDocument] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_TypeOfID] FOREIGN KEY ([ID_Type]) REFERENCES [dbo].[CIMS_d_TypeOfID] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_TypeOfInstitution] FOREIGN KEY ([GraduatedInstitutionType]) REFERENCES [dbo].[CIMS_d_TypeOfInstitution] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_d_TypeOfMilitaryEvidence] FOREIGN KEY ([MilitaryTypeOfEvidence]) REFERENCES [dbo].[CIMS_d_TypeOfMilitaryEvidence] ([ID]),
    CONSTRAINT [FK_CIMS_Applicant_CIMS_SpecialtyProfile] FOREIGN KEY ([Specialty]) REFERENCES [dbo].[CIMS_SpecialtyProfile] ([ID])
);

























