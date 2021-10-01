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

-- removing column 

alter table [google project].dbo.union$
drop column ride_time

-- changing format on ride_length

alter table union$
add ride_time time;

update union$
set ride_time = Convert(time, ride_length)

select *
from union$

alter table union$
drop column ride_length

-- number of classic vs electric bikes

select rideable_type, count(*)
from union$
group by rideable_type
order by count(*)

-- member vs casual rides on specific day of the week

select member_casual, 
sum(case when day_of_week = 1 then 1 else 0 end) sunday,
sum(case when day_of_week = 2 then 1 else 0 end) monday,
sum(case when day_of_week = 3 then 1 else 0 end) tuesday,
sum(case when day_of_week = 4 then 1 else 0 end) wednesday,
sum(case when day_of_week = 5 then 1 else 0 end) thursday,
sum(case when day_of_week = 6 then 1 else 0 end) friday,
sum(case when day_of_week = 7 then 1 else 0 end) saturday
from union$
group by member_casual