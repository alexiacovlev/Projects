SELECT v.*
, s.Name+isnull(', '+l.name, '') 
+ isnull(', '+fin.Name, '') 
+ isnull(', '+ac.Name, '') 
+ isnull(', '+lc.Name, '') 
+ isnull(', '+cast(NrOfVacancies as varchar) + ' vacancies', '') as Name
FROM CIMS_AdmissionVacancies v
left join CIMS_SpecialtyProfile sp on sp.id = v.Specialty
left join CIMS_d_Specialties s on s.id = sp.Specialty
left join CIMS_d_Language l on l.id = sp.Language
left join CIMS_d_TypeOfFinancing fin on fin.id = v.TypeOfFinancing
left join CIMS_d_SpecialAdmissionCategories ac on ac.id = v.AdmissionCategory
left join CIMS_d_LocalityCategory lc on lc.id = v.LocalityCategory
