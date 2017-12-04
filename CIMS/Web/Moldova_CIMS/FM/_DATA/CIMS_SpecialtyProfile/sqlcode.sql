select a.*, s.Name+isnull(', '+l.name, '') as Name
from CIMS_SpecialtyProfile a 
inner join CIMS_d_Specialties s on s.id = a.Specialty
left join CIMS_d_Language l on l.id = a.Language