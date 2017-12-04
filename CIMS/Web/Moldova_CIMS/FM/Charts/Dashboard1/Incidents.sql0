SELECT YearWithMonth= (CAST(YEAR(CreatedOn) as varchar(4)) + ' ' + left(DATENAME(MONTH,CreatedOn),3)),
       COUNT(*),
       Y = YEAR(CreatedOn), M = MONTH(CreatedOn)
FROM     AX_Incidents
GROUP BY YEAR(CreatedOn),
         MONTH(CreatedOn),
         DATENAME(MONTH,CreatedOn)