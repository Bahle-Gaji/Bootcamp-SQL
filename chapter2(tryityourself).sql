SELECT first_name, last_name, school
FROM teachers
ORDER BY school ASC, last_name ASC;


SELECT first_name, salary
FROM teachers
WHERE first_name LIKE 'S%' AND salary > 40000;

SELECT first_name, last_name, hire_date, salary
FROM teachers
WHERE hire_date > '2010-01-01'
ORDER BY salary DESC;