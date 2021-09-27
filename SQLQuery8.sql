--checking number of rows for February
select count(*)
from [Google Project].dbo.February_2021$

--checking number of rows for January

select count(*)
from [Google Project].dbo.Janaury_2021$

--combining January and February into one table

select * 
into [Google Project].dbo.union$
From [Google Project].dbo.January_2021$
union
select *
from [Google Project].dbo.February_2021$

--creating table for ride_length calculations

SELECT cast(ride_length as time) [ride_length]
into [Google Project].dbo.ride_length$
FROM [Google Project].dbo.union$

--calculating most popular day of the week ridden ( 1 = sunday)

select day_of_week, count(*) as frequency
from [Google Project].dbo.union$
group by day_of_week
order by count(*) desc

-- calculating most popular station

select start_station_name, count(*) as frequency
from [Google Project].dbo.union$
group by start_station_name
order by count(*) desc

-- number of members vs casuals renting bikes

select member_casual, count(*) as frequency
from [Google Project].dbo.union$
group by member_casual
order by count(*) desc