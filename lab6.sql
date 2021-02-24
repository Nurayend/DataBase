CREATE DATABASE lab6;

CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(30),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY, --40,50,60,70,80
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employee(
    employee_id SMALLINT,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    middle_initial VARCHAR (1),
    manager_id SMALLINT,
    job_id SMALLINT,
    hire_date DATE,
    salary NUMERIC(7, 2),
    comission NUMERIC(7, 2),
    department_id SMALLINT
);



INSERT INTO locations (location_id, street_address, postal_code, city, state_province)
VALUES (1, 'Ayapova', '1', 'Atyrau', 'Damba'),
       (2, 'Ongarsynova', '2', 'Atyrau', 'Makhambet'),
       (3, 'Kurmangazi', '3', 'Atyrau', 'Erkinqala'),
       (4, 'Auezov', '4', 'Almaty', 'State'),
       (5, 'Mukhanov', '5', 'Almaty', 'Province');
INSERT INTO departments (department_id, department_name, budget, location_id)
VALUES (40, 'Avon', 100, 1),
       (50, 'Oriflame', 200, 2),
       (60, 'BI', 300, 3),
       (70, 'Library', 300, 4),
       (80, 'Hell', 400, 5);
INSERT INTO departments (department_id, department_name, budget, location_id) VALUES (90, 'NurOtan', 100, 5);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, salary, department_id)
VALUES (1, 'Nuray', 'Turganbaeva', 'chort', '1234', 500, 60),
       (2, 'Asem', 'Maratbek', 'oduvanchik', '1342', 500, 40),
       (3, 'Dean', 'Winchester', 'impala', '999', 700, 50),
       (4, 'Sam', 'Winchester', 'supernatural', '666', 700, 70),
       (5, 'Lucifer', 'Morningstar', 'devil', '699', 700, 80);

SELECT first_name, last_name, employees.department_id, d.department_name
FROM employees
INNER JOIN departments d on d.department_id = employees.department_id;

SELECT first_name, last_name, employees.department_id, d.department_name
FROM employees
INNER JOIN departments d on d.department_id = employees.department_id
WHERE d.department_id IN (80, 40);

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e
INNER JOIN departments d on d.department_id = e.department_id
INNER JOIN locations l on l.location_id = d.location_id;

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT  first_name, last_name
FROM employees
INNER JOIN departments d on d.department_id = employees.department_id
INNER JOIN locations l on l.location_id = d.location_id
WHERE l.city = 'Almaty';

SELECT department_name FROM departments
LEFT JOIN employees e on departments.department_id = e.department_id
WHERE e.department_id IS NULL;

SELECT last_name, first_name
FROM employees
ORDER BY last_name, first_name;


