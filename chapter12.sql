--Using Subqueries--

SELECT * FROM us_counties_2010;
--Generating Values for a Query Expression
--(Query showing us counties at or above 90th percentile for population)
SELECT
	geo_name, 
	state_us_abbreviation,
	p0010001
FROM us_counties_2010
WHERE p0010001 >= (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
	FROM us_counties_2010
	)
ORDER BY p0010001 DESC;

--Using a Subquery to Identify Rows to Delete
CREATE TABLE us_counties_2010_top10 AS 
SELECT * FROM us_counties_2010;

DELETE FROM us_counties_2010_top10
WHERE p0010001 < (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
	FROM us_counties_2010
	);
	
SELECT count(*) FROM us_counties_2010_top10;


--Creating Derived Tables with Subqueries
SELECT round(calcs.average, 0) AS average,
 calcs.median,
 round(calcs.average - calcs.median, 0) AS median_average_diff
FROM (
 SELECT avg(p0010001) AS average,
 percentile_cont(.5)
 WITHIN GROUP (ORDER BY p0010001)::numeric(10,1) AS median
 FROM us_counties_2010
 ) 
AS calcs;


--Joining Derived Tables
SELECT census.state_us_abbreviation AS st,
 census.st_population,
 plants.plant_count,
 round((plants.plant_count/census.st_population::numeric(10,1))*1000000, 1)
 AS plants_per_million
 
FROM
 (
 SELECT st,
 count(*) AS plant_count
 FROM meat_poultry_egg_inspect
 GROUP BY st
 )
 
 AS plants
JOIN
 (
 SELECT state_us_abbreviation,
 sum(p0010001) AS st_population
 FROM us_counties_2010
 GROUP BY state_us_abbreviation
 ) 
 AS census
ON plants.st = census.state_us_abbreviation
ORDER BY plants_per_million DESC;


--Generating Columns with Subqueries
