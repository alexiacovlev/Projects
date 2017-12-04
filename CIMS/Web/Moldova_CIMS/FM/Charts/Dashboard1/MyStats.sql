select 'Jan-Feb', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 1
union
select 'March-May', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 2
union
select 'Jun-Aug', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 3
union
select 'Sep-Nov', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 4
ORDER BY Y, M