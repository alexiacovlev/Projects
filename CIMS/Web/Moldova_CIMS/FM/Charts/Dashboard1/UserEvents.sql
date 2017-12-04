select '2017 Jan', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 1
union
select '2017 Feb', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 2
union
select '2017 Mar', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 3
union
select '2017 Apr', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 4
union
select '2017 May', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 5
union
select '2017 Jun', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 6
union
select '2017 Jul', ROUND(10000*RAND(), 0, 0), Y = 2017, M = 7
ORDER BY Y, M