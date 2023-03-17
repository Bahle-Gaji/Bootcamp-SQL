DROP TABLE IF EXISTS contact_interest;
DROP TABLE IF EXISTS contact_seeking;
DROP TABLE IF EXISTS my_contacts;
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS seeking;
DROP TABLE IF EXISTS profession;
DROP TABLE IF EXISTS zip_code;
DROP TABLE IF EXISTS status;
-- Makes easier to edit tables without manually deleting individually

CREATE TABLE interests (
	interest_id bigserial CONSTRAINT interest_id_key PRIMARY KEY UNIQUE,
	interest varchar(50)
);

CREATE TABLE seeking (
	seeking_id bigserial CONSTRAINT seeking_id_key PRIMARY KEY UNIQUE,
	seeking varchar(50)
);

CREATE TABLE profession (
	prof_id bigserial CONSTRAINT prof_id_key PRIMARY KEY,
	profession varchar(50) CONSTRAINT profession_unique UNIQUE
);

CREATE TABLE zip_code (
	zip_code varchar(4) CONSTRAINT zip_code_key PRIMARY KEY CHECK (length(zip_code) <= 4) NOT NULL,
	city varchar(50) NOT NULL,
	province varchar(50) NOT NULL
);

CREATE TABLE status (
	status_id bigserial CONSTRAINT status_id_key PRIMARY KEY,
	status varchar(20) NOT NULL
);

CREATE TABLE my_contacts (
	contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	phone varchar(10) UNIQUE NOT NULL,
	email varchar(30) UNIQUE NOT NULL,
	gender varchar(6) NOT NULL,
	birthday date NOT NULL,
	prof_id bigint REFERENCES profession(prof_id),
	zip_code varchar(5) REFERENCES zip_code(zip_code),
	status_id bigint REFERENCES status(status_id)
);

CREATE TABLE contact_interest (
	contact_id bigint REFERENCES my_contacts(contact_id) NOT NULL,
	interest_id bigint REFERENCES interests(interest_id) NOT NULL
);

CREATE TABLE contact_seeking (
	contact_id bigint REFERENCES my_contacts(contact_id) NOT NULL,
	seeking_id bigint REFERENCES seeking(seeking_id) NOT NULL
);

SELECT * FROM interests;
SELECT * FROM seeking;
SELECT * FROM profession;
SELECT * FROM zip_code;
SELECT * FROM status;
SELECT * FROM my_contacts;
SELECT * FROM contact_interest;
SELECT * FROM contact_seeking;

INSERT INTO interests (interest)
VALUES ('pets'), 
('beach walks'), 
('reading'), 
('movies'), 
('golfing'),
('painting'), 
('music'),
('meditation'),
('video games'),
('cycling'),
('travelling'),
('surfing'),
('astronomy'),
('running'),
('bodybuilding'),
('chess'),
('singing'),
('hiking'),
('board games'),
('martial arts'),
('acting');
	
INSERT INTO seeking (seeking)
VALUES ('long term'), ('casual'), ('marriage');

INSERT INTO profession (profession)
VALUES ('Electrician'),
	('Accountant'),
	('Auditor'),
	('Financial Advisor'),
	('Teacher'),
	('Professor'),
	('Doctor'),
	('Realtor'),
	('Judge'),
	('Musician'),
	('Construnction'),
	('Mechanical Engineer'),
	('Unemployed');

INSERT INTO zip_code
VALUES ('0182', 'Pretoria', 'Gauteng'), ('2192', 'Johannesburg', 'Gauteng'), 
	('0480', 'Bela-Bela', 'Limpopop'), ('0699', 'Polokwane', 'Limpopo'), 
	('1307', 'Mbombela', 'Mpumalanga'), ('1120', 'Lydenburg', 'Mpumalanga'),
	('2745', 'Mahikeng', 'North West'), ('0337', 'Rustenburg', 'North West'),
	('3080', 'Dannhauser', 'KwaZulu-Natal'), ('4172', 'Newcastle', 'KwaZulu-Natal'),
	('9300', 'Bloemfontein', 'Free State'), ('9690', 'Wesselsbron', 'Free State'),
	('8303', 'Kimberly', 'Northern Cape'), ('8801', 'Upington', 'Northern Cape'),
	('7130', 'Cape Town', 'Western Cape'), ('6670', 'Swellendam', 'Western Cape'),
	('6024', 'Gqeberha','Eastern Cape'), ('5201','East London','Eastern Cape');
	
INSERT INTO status(status)
VALUES ('single'), ('married'), ('divorced'), ('widowed');

INSERT INTO my_contacts(last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
VALUES ('Derulo', 'Jason', '0671000013', 'jasond@gmail.com', 'male', '1993-02-12', 01, '6024', 01),
	('Hannah', 'Streydom', '0971123323', 'hannahs@outlook.com', 'female', '1987-12-09', 02, '7130', 03),
	('Karina', 'Maxwell', '0762230987', 'kmaxwell@gmail.com', 'female', '1992-06-09', 04, '8303', 01),
	('Karabo', 'Sekowe', '0882219282', 'ksekowe@outlook.com', 'male', '1989-08-22', 03, '9300', 04),
	('Jan', 'Yster', '0632281293', 'ysterjan@gmail.com', 'female', '1987-02-03', 08, '3080', 01),
	('Jako', 'Livanos', '0887637229', 'jlivanos@outlook.com', 'male', '2000-03-21', 06, '2745', 01),
	('Megan', 'Foxxer', '0766654382', 'foxxerm@gmail.com', 'female', '1987-09-23', 05, '1307', 02),
	('Marcy','Hayy', '0829047607','marcyhayy@dumpmail.com','female', '1989-04-27', 07,'0480', 03),
	('Benjamin', 'Waters', '0986622272', 'benwaters@outlook.com', 'male', '1988-11-11', 09, '6024', 04),
	('Caryll', 'Denvers', '0877362820', 'denverscaryll@gmail.com', 'female', '1993-09-02', 10, '5201', 01),
	('Thando', 'Teller', '0339282543', 'thandot@mymail.com', 'male', '1990-08-23', 11, '6670', 01),
	('Tyler', 'May', '0674247222', 'tylermay@outlook.com', 'male', '2001-10-20', 13, '8801', 01),
	('Candace', 'Weller', '0633943386', 'wellerc@cashmail.com', 'female', '1978-07-29', 06, '9690', 03),
	('T.J', 'Maxamillion', '0887363322', 'milliontj@gmail.com', 'male', '1992-03-25', 11, '4172', 01),
	('Anneke', 'Beatrice', '0633374728', 'abeatrice@outlook.com', 'female', '1998-09-28', 12, '0337', 02),
	('Peter', 'Xalinga', '0783379281', 'xalingap@gmail.com', 'male', '2002-02-13', 03, '7130', 01),
	('Amanda', 'Peterson', '0839322713', 'petersona@justmail.com', 'female', '1993-04-03', 05, '9300', 03),
	('Caleb', 'Pringle', '0655543224', 'calebpringle@flashmail.com', 'male', '1992-09-14', 13, '2192', 01);
	
INSERT INTO contact_interest(contact_id, interest_id)
VALUES (1, 21), (1, 6), (1, 15),
(2, 5), (2, 10), (2, 13),
(3, 15), (3, 4), (3, 11),
(4, 8), (4, 14), (4, 11),
(5, 6), (5, 13), (5, 17),
(6, 2), (6, 5), (6, 12),
(7, 17), (7, 21), (7, 18),
(8, 14), (8, 11), (8, 5),
(9, 19), (9, 2), (9, 3),
(10, 2), (10, 15), (10, 5),
(11, 6), (11, 2), (11, 7),
(12, 8), (12, 8), (12, 15),
(13, 3), (13, 7), (13, 9),
(14, 9), (14, 5), (14, 7),
(15, 12), (15, 19), (15, 4),
(16, 15), (16, 20), (16, 18),
(17, 4), (17, 7), (17, 16),
(18, 2), (18, 7), (18, 20);

INSERT INTO contact_seeking(contact_id, seeking_id)
VALUES (1, 2),
	(2, 3),
	(3, 1),
	(4, 2),
	(5, 2),
	(6, 3),
	(7, 1),
	(8, 3),
	(9, 2),
	(10, 1),
	(11, 3),
	(12, 3),
	(13, 2),
	(14, 2),
	(15, 1),
	(16, 2),
	(17, 1),
	(18, 1);

SELECT 
	mc.contact_id,
	mc.last_name || ' ' || mc.first_name AS name,
	p.profession,
	zc.zip_code,
	zc.city,
	zc.province,
	status.status,
	i.interest,
	s.seeking
FROM my_contacts mc LEFT JOIN contact_interest ci
ON mc.contact_id = ci.contact_id
LEFT JOIN contact_seeking cs
ON mc.contact_id = cs.contact_id
LEFT JOIN interests i
ON i.interest_id = ci.interest_id
LEFT JOIN seeking s
ON s.seeking_id = cs.seeking_id
LEFT JOIN profession p
ON p.prof_id = mc.prof_id
LEFT JOIN zip_code zc
ON zc.zip_code = mc.zip_code
LEFT JOIN status 
ON status.status_id = mc.status_id;