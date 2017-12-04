SELECT YearWithMonth= (CAST(YEAR(EventTime) as varchar(4)) + ' ' + left(DATENAME(MONTH,EventTime),3)),
       COUNT(*),
       Y = YEAR(EventTime), M = MONTH(EventTime)
FROM     AX_UserEvents
GROUP BY YEAR(EventTime),
         MONTH(EventTime),
         DATENAME(MONTH,EventTime)
ORDER BY Y, M