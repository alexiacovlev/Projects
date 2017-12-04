
CREATE VIEW [dbo].[CIMS_SpecialtyProfile2Admission_View]
AS
select s.*
, asp.Admission
, sp.Name + isnull(', '+l.Name, '') as SpecialtyName
from CIMS_SpecialtyProfile s
inner join CIMS_Admission2Specialties asp on asp.Specialty = s.id
inner join CIMS_d_Specialties sp on sp.id = s.Specialty
left join CIMS_d_Language l on l.id = s.Language