--1.--

SELECT * FROM nyc_yellow_taxi_trips_2016_06_01;

SELECT trip_id,
	tpep_dropoff_datetime - tpep_pickup_datetime AS ride_length
FROM nyc_yellow_taxi_trips_2016_06_01
ORDER BY ride_length DESC;

--2.--
SELECT 
'2100-01-01 00:00:00' AT TIME ZONE 'US/Eastern' AS New_York,
'2100-01-01 00:00:00' AT TIME ZONE 'Europe/London' AS London,
'2100-01-01 00:00:00' AT TIME ZONE 'Africa/Johannesburg' AS Johannesburg,
'2100-01-01 00:00:00' AT TIME ZONE 'Europe/Moscow' AS Moscow,
'2100-01-01 00:00:00' AT TIME ZONE 'Australia/Melbourne' AS Melbourne;