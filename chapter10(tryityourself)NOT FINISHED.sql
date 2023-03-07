--1.--
SELECT corr(median_hh_income, pct_bachelors_higher) 
 AS bachelors_income_r,
 corr(median_hh_income, pct_masters_higher) 
 AS masters_income_r
FROM acs_2011_2015_stats;

--2.--
SELECT st, 
	city,
	population,
	motor_vehicle_theft,
	round(
	(motor_vehicle_theft::numeric / population) * 1000, 1
		) AS mvh_per_1000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY (motor_vehicle_theft::numeric / population) DESC;

--3.--
--DO ******--