select a.*, s.Name
from CIMS_Admission2Subjects a 
inner join CIMS_d_Subjects s on s.id = a.Subject