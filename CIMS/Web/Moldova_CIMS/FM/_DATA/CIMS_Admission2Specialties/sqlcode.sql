select a.*, s.Name
from CIMS_Admission2Specialties a 
inner join CIMS_d_Specialties s on s.id = a.Specialty