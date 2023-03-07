SELECT 3.14 * 5 ^ 2;

/*SELECT geo_name as "County", 
	state_us_abbreviation as "State", 
	p0010001 AS "Total population",
	p0010005 AS "American Indian/ Alaskan Native Alone",
	(CAST(p0010005 AS numeric(8,1)) / p0010001) * 100 AS "Percent Identifies"
FROM us_counties_2010
WHERE state_us_abbreviation ILIKE '%ny%'
ORDER BY p0010005 DESC
LIMIT  1;
*/

SELECT geo_name,
       state_us_abbreviation,
       p0010001 AS total_population,
       p0010005 AS american_indian_alaska_native_alone,
       (CAST (p0010005 AS numeric(8,1)) / p0010001) * 100
           AS percent_american_indian_alaska_native_alone
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY'
ORDER BY percent_american_indian_alaska_native_alone DESC;


SELECT percentile_cont(0.5)
	WITHIN GROUP(ORDER BY p0010001)
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY';

SELECT percentile_cont(0.5)
	WITHIN GROUP(ORDER BY p0010001)
FROM us_counties_2010
WHERE state_us_abbreviation = 'CA';

	


