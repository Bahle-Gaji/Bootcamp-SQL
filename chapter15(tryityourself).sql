--1. 
CREATE OR REPLACE VIEW taxi_trips_per_hour AS
    SELECT date_part('hour', tpep_pickup_datetime),
         count(date_part('hour', tpep_pickup_datetime))
    FROM nyc_yellow_taxi_trips_2016_06_01
    GROUP BY date_part('hour', tpep_pickup_datetime)
    ORDER BY date_part('hour', tpep_pickup_datetime);

SELECT * FROM nyc_taxi_trips_per_hour;


--2. 
CREATE OR REPLACE FUNCTION 
rates_per_1000(observed_number numeric,
			   base_number numeric,
			   decimal_places integer DEFAULT 1)
RETURNS numeric AS
'SELECT round(
	(observed_number / base_number) * 1000, decimal_places
);'
LANGUAGE SQL
IMMUTABLE 
RETURNS NULL ON NULL INPUT;


--answer
CREATE OR REPLACE FUNCTION
rate_per_thousand(observed_number numeric,
                  base_number numeric,
                  decimal_places integer DEFAULT 1)
RETURNS numeric(10,2) AS $$
BEGIN
    RETURN
        round(
        (observed_number / base_number) * 1000, decimal_places
        );
END;
$$ LANGUAGE plpgsql;

--3.
