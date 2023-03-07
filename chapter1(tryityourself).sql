CREATE TABLE animal_type (
	animal_type_id bigserial CONSTRAINT animal_type_key PRIMARY KEY,
	type varchar(25),
	dietary_habits varchar(25),
	reproduction varchar(25),
	walking_posture varchar(25)
);

SELECT * FROM animal_type;

INSERT INTO animal_type(type, dietary_habits, reproduction, walking_posture)
VALUES ('Lion', 'Carnivore', 'Viviparous', 'Quadropedal'),
	('Giraffe', 'Herbivore', 'Viviparous', 'Quadropedal'),
	('Panda', 'Omnivore', 'Viviparous', 'Quadropedal');

SELECT * FROM animal_type;


CREATE TABLE zoo_animals (
	zoo_id bigserial CONSTRAINT zoo_key PRIMARY KEY,
	animal_name varchar(25),
	type_id bigint REFERENCES animal_type(animal_type_id),
	date_of_birth date,
	colour varchar(25),
	gender varchar(25)
);

SELECT * FROM zoo_animals;

INSERT INTO zoo_animals(animal_name, type_id, date_of_birth, colour, gender)
VALUES ('Simba', 1,  '2013-10-23', 'Yellow/Brown', 'M'),
		('Melman', 2, '2011-04-14', 'Brown', 'M'),
		('Po', 3, '2010-03-23', 'Black/White', 'M');
		
SELECT * FROM animal_type;
SELECT * FROM zoo_animals;

