select 'Hotel', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 1
union
select 'Restaurant', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 2
union
select 'SPA', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 3
union
select 'Fitness', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 4
union
select 'Cafe', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 5
ORDER BY Y, M