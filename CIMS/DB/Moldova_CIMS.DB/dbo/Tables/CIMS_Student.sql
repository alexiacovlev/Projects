﻿CREATE TABLE [dbo].[CIMS_Student] (
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
    [Application]                     UNIQUEIDENTIFIER NULL,
    [CardNr]                          NVARCHAR (100)   NULL,
    [BirthDay]                        DATETIME         NULL,
    [BirthPlace]                      NVARCHAR (200)   NULL,
    [Gender]                          INT              NULL,
    [ResidenceCountry]                INT              NULL,
    [ResidenceRaion]                  INT              NULL,
    [ResidenceLocality]               INT              NULL,
    [ResidenceAddress]                NVARCHAR (200)   NULL,
    [ResidenceHomePhone]              NVARCHAR (100)   NULL,
    [ResidenceParentPhone]            NVARCHAR (100)   NULL,
    [ResidenceStudentMobile]          NVARCHAR (100)   NULL,
    [ResidenceStudentEMail]           NVARCHAR (100)   NULL,
    [ID_Type]                         INT              NULL,
    [ID_Series]                       NVARCHAR (5)     NULL,
    [ID_Number]                       NVARCHAR (100)   NULL,
    [ID_IssuedBy]                     NVARCHAR (100)   NULL,
    [ID_IssuedOn]                     DATETIME         NULL,
    [IDNP]                            NVARCHAR (13)    NULL,
    [Citizenship]                     INT              NULL,
    [Ethnicity]                       INT              NULL,
    [MilitaryTypeOfEvidence]          INT              NULL,
    [MilitaryDocumentNr]              NVARCHAR (50)    NULL,
    [MilitaryDocumentIssuedOn]        DATETIME         NULL,
    [FatherFullName]                  NVARCHAR (100)   NULL,
    [MotherFullName]                  NVARCHAR (100)   NULL,
    [NumberOfParents]                 INT              NULL,
    [NumberOfChildrenInFamily]        INT              NULL,
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
    [DecisionReason]                  NVARCHAR (1024)  NULL,
    [TypeOfFinancing]                 INT              NULL,
    [LocalityCategory]                INT              NULL,
    [ShareOfAdmissionVacancies]       INT              NULL,
    [LivingEnvironment]               INT              NULL,
    [SpecialCategory]                 INT              NULL,
    [SpecialAdmissionCategoryItem]    INT              NULL,
    [Recommendation]                  BIT              NULL,
    [RecommendationDetails]           NVARCHAR (250)   NULL,
    [CertificateOfEducationSeries]    NVARCHAR (5)     NULL,
    [SpecialCategoryDocument]         NVARCHAR (500)   NULL,
    [UserId]                          UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Student] PRIMARY KEY CLUSTERED ([ID] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CIMS_Student]
    ON [dbo].[CIMS_Student]([UserId] ASC) WHERE ([UserId] IS NOT NULL);
