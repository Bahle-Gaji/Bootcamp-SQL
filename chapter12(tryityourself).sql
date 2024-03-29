--1.--
WITH temps_collapsed (station_name, max_temperature_group) AS
	(SELECT station_name,
	 CASE WHEN max_temp >= 90 THEN 'Hot'
		 WHEN max_temp BETWEEN 88 AND 89 THEN '88-89'
		 WHEN max_temp BETWEEN 86 AND 87 THEN '86-87'
		 WHEN max_temp BETWEEN 82 AND 83 THEN '82-83'
		 WHEN max_temp BETWEEN 80 AND 81 THEN '80-81'
		 WHEN max_temp <= 79 THEN '79 or less' 
	 END
	 FROM temperature_readings
	 WHERE station_name = 'WAIKIKI 717.2 HI US')
	 
 SELECT station_name, max_temperature_group, count(*)
FROM temps_collapsed
GROUP BY station_name, max_temperature_group
ORDER BY station_name, count(*) DESC;

--MOST AT 86-87


--2.--
SELECT *
FROM crosstab('SELECT flavor,
                      office,
                      count(*)
               FROM ice_cream_survey
               GROUP BY flavor, office
               ORDER BY flavor',

              'SELECT office
               FROM ice_cream_survey
               GROUP BY office
               ORDER BY office')

AS (flavor varchar(20),
    downtown bigint,
    midtown bigint,
    uptown bigint);