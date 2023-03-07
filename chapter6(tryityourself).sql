--MY ATTEMPT
SELECT c2010.geo_name, c2000.geo_name
FROM us_counties_2010 c2010 LEFT JOIN us_counties_2000 c2000
ON c2010.geo_name = c2000.geo_name
WHERE c2000.geo_name IS NULL;

--ANSWER
SELECT c2010.geo_name,
       c2010.state_us_abbreviation,
       c2000.geo_name
FROM us_counties_2010 c2010 LEFT JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips
WHERE c2000.geo_name IS NULL;

SELECT c2010.geo_name,
       c2000.geo_name,
       c2000.state_us_abbreviation
FROM us_counties_2010 c2010 RIGHT JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips
WHERE c2010.geo_name IS NULL;
---------------

SELECT percentile_cont(.5)
WITHIN GROUP(ORDER BY round((CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001) / c2000.p0010001 * 100, 1)) AS percentile_50th
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
			 AND c2010.county_fips = c2000.county_fips;