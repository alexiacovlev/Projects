select '2017 Jan', ROUND(100*RAND(), 0, 0), Y = 2017, M = 1
union
select '2017 Feb', ROUND(100*RAND(), 0, 0), Y = 2017, M = 2
union
select '2017 Mar', ROUND(100*RAND(), 0, 0), Y = 2017, M = 3
union
select '2017 Apr', ROUND(100*RAND(), 0, 0), Y = 2017, M = 4
union
select '2017 May', ROUND(100*RAND(), 0, 0), Y = 2017, M = 5
union
select '2017 Jun', ROUND(100*RAND(), 0, 0), Y = 2017, M = 6
union
select '2017 Jul', ROUND(100*RAND(), 0, 0), Y = 2017, M = 7
ORDER BY Y, M