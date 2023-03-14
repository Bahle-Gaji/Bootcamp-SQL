DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Overtime_hours;

CREATE TABLE Department (
	depart_id bigint CONSTRAINT depart_id_key PRIMARY KEY,
	depart_name varchar(50),
	depart_city varchar(50)
);

CREATE TABLE Roles (
	role_id bigint CONSTRAINT role_id_key PRIMARY KEY,
	role varchar(20)
);

CREATE TABLE Salaries (
	salary_id bigint CONSTRAINT salary_id_key PRIMARY KEY,
	salary_pa numeric
);

CREATE TABLE Overtime_hours (
	overtime_id bigint CONSTRAINT overtime_id_key PRIMARY KEY,
	overtime_hours numeric
);

CREATE TABLE Employees (
	emp_id bigint,
	first_name varchar(50),
	surname varchar(50),
	gender varchar(6),
	address varchar(50),
	email varchar(30) UNIQUE ,
	depart_id bigint REFERENCES Department(depart_id),
	role_id bigint REFERENCES Roles (role_id),
	salary_id bigint REFERENCES Salaries (salary_id),
	overtime_id bigint REFERENCES Overtime_hours (overtime_id)
);


SELECT * FROM Employees;
SELECT * FROM Department;
SELECT * FROM Roles;
SELECT * FROM Salaries;
SELECT * FROM Overtime_hours;

INSERT INTO Department
VALUES (101,'Marketing', 'Cape Town'),
(102, 'Finance', 'Johannesburg'),
(103, 'Human Resources', 'Durban'),
(104, 'Customer Service', 'Stellenbosch'),
(105, 'Sales', 'Bloemfontein'),
(106, 'IT', 'Kimberly');

INSERT INTO Roles
VALUES (01, 'Head of Department'),
(02, 'Supervisor'),
(03, 'Employee');


INSERT INTO Salaries
VALUES (01, 500000),
(02, 430000),
(03, 350000),
(04, 300000);

INSERT INTO Overtime_hours
VALUES (01, 72),
(02, 60),
(03, 48),
(04, 36),
(05, 0);
	
INSERT INTO Employees
VALUES (201, 'James', 'May', 'Male', '34 Elliot Street', 'jamesmay@gmail.com', 102, 02, 02, 04),
(202, 'Delores', 'Delorian', 'Female', '436 Jumbo Blvd', 'ddelorian@gmail.com', 105, 01, 01, 02),
(203, 'Richard', 'Clarkson', 'Male', '778 Topgear Street', 'richman@outlook.com', 103, null, null, 04),
(204, 'Melody', 'Jackson', 'Female', '32 Edgar Lane', 'mjackson@gmail.com', 106, 03, 03, 03),
(205, 'Roman', 'Edge', 'Male', '443 Wrestlers Crest', 'edgeman03@gmail.com', 102, 01, 01, null),
(206, 'Meagan', 'Moodley', 'Female', '79 Jumbo Junction', 'meaganmoodley@apple.com', 101, 01, 01, 05),
(207, 'Liam', 'Bellamy', 'Male', '45 Blackwood Road', 'bellamyl@apple.com', null, 02, 02, 05),
(208, 'Ty', 'Reddy', 'Male', '83323 Candy Forrest Lane', 'tyreddy@outlook.com', 104, 03, 03, 01);




SELECT d.depart_name, r.role, s.salary_pa, o.overtime_hours
FROM Employees e LEFT JOIN Department d
ON e.depart_id = d.depart_id
LEFT JOIN Roles r
ON e.role_id = r.role_id
LEFT JOIN Salaries s
ON e.salary_id = s.salary_id
LEFT JOIN Overtime_hours o
ON e.overtime_id = o.overtime_id;
