WITH (FORMAT CSV, HEADER, DELIMITER ':', QUOTE '#')

COPY (
	SELECT geo_name,
		state_us_abbreviation,
		housing_unit_count_100_percent
	FROM us_counties_2010
	ORDER BY housing_unit_count_100_percent DESC
	LIMIT (20)
)
TO 'C:\DIRECTORY\us_counties_highest_housing_units.csv'
WITH (FORMAT CSV, HEADER, DELIMITER '|')

