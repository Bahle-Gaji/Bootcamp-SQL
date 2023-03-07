-- 1.--
SELECT * FROM meat_poultry_egg_inspect;
ALTER TABLE meat_poultry_egg_inspect ADD COLUMN meat_processing boolean;
ALTER TABLE meat_poultry_egg_inspect ADD COLUMN poultry_processing boolean;

--2.--
UPDATE meat_poultry_egg_inspect
SET meat_processing = TRUE
WHERE activities ILIKE '%meat processing%';

UPDATE meat_poultry_egg_inspect
SET poultry_processing = TRUE
WHERE activities ILIKE '%poultry processing%';

SELECT activities, meat_processing, poultry_processing FROM meat_poultry_egg_inspect;

--3.--
SELECT count(meat_processing) count_meat, count(poultry_processing) count_poultry
FROM meat_poultry_egg_inspect;

SELECT count(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = TRUE AND poultry_processing = TRUE;