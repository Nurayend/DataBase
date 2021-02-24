CREATE DATABASE lab8;

CREATE TABLE countries(
    countrie_id SERIAL PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER
);

INSERT INTO countries (name) VALUES ('Kz'),
                                    ('America'),
                                    ('China'),
                                    ('South Korea'),
                                    ('Russian'),
                                    ('Germany'),
                                    ('France'),
                                    ('Canada'),
                                    ('Argentina'),
                                    ('Austria'),
                                    ('Brazil'),
                                    ('Chile'),
                                    ('Egypt'),
                                    ('Greece');

INSERT INTO departments (department_name, budget)
VALUES ('Avon', 100),
       ('Oriflame', 200),
       ('BI', 300),
       ('Library', 300),
       ('Hell', 400),
       ('School', 500),
       ('Microsoft', 600),
       ('Apple', 700),
       ('Samsung', 800),
       ('Cola', 900),
       ('Ikea', 700),
       ('Factory', 600),
       ('Clothes', 500);

INSERT INTO employees (first_name, last_name, salary, department_id)
VALUES ('Nuray', 'Turganbaeva', 500, 1),
       ('Asem', 'Maratbek', 500, 2),
       ('Dean', 'Winchester', 700, 3),
       ('Sam', 'Winchester', 700, 4),
       ('Lucifer', 'Morningstar', 700, 5),
       ('Castiel', 'Winchester', 10, 6),
       ('Mina', 'Moon', 900, 7),
       ('John', 'Cook', 700, 8),
       ('Kim', 'Lo', 900, 9),
       ('Nick', 'Gomez', 800, 10),
       ('Nur', 'Li', 700, 11),
       ('Nina', 'Tre', 600, 12);

SELECT *
FROM countries
WHERE name = 'Kz';

EXPLAIN SELECT *
FROM countries
WHERE name = 'Kz';
--Seq Scan on countries  (cost=0.00..1.18 rows=1 width=82)
--Filter: ((name)::text = 'Kz'::text)

CREATE INDEX ix_countries_name
ON countries(name);
--Seq Scan on countries  (cost=0.00..1.12 rows=1 width=82)
--Filter: ((name)::text = 'Kz'::text)

SELECT *
FROM employees
WHERE first_name = 'Castiel' AND last_name = 'Winchester';

EXPLAIN SELECT *
FROM employees
WHERE first_name = 'Castiel' AND last_name = 'Winchester';
--Seq Scan on employees  (cost=0.00..1.18 rows=1 width=248)

CREATE INDEX ix_employees_names
ON employees(first_name, last_name);
--Seq Scan on employees  (cost=0.00..1.11 rows=1 width=248)

SELECT *
FROM employees
WHERE salary < 1000 AND salary > 400;

EXPLAIN SELECT *
FROM employees
WHERE salary < 1000 AND salary > 400;
--Seq Scan on employees  (cost=0.00..1.18 rows=1 width=248)

CREATE UNIQUE INDEX ix_employees_salary
ON employees(salary);
--Seq Scan on employees  (cost=0.00..1.13 rows=1 width=248)

SELECT *
FROM employees
WHERE substring(first_name
FROM 1 for 4) = 'Cast';

EXPLAIN SELECT *
FROM employees
WHERE substring(first_name
FROM 1 for 4) = 'Cast';
--Seq Scan on employees  (cost=0.00..1.18 rows=1 width=248)

CREATE INDEX ix_employees_firstname
ON employees(substring(first_name from 1 for 4));
--Seq Scan on employees  (cost=0.00..1.11 rows=1 width=248)

SELECT *
FROM employees e
    JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > 50 AND e.salary < 600;

EXPLAIN SELECT *
FROM employees e
    JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > 50 AND e.salary < 600;
/*Hash Join  (cost=1.20..2.39 rows=1 width=374)
  Hash Cond: (d.department_id = e.department_id)
  ->  Seq Scan on departments d  (cost=0.00..1.16 rows=4 width=126)
        Filter: (budget > 50)
  ->  Hash  (cost=1.15..1.15 rows=4 width=248)
        ->  Seq Scan on employees e  (cost=0.00..1.15 rows=4 width=248)
              Filter: (salary < 600)
*/

CREATE INDEX ix_join_salary
ON employees USING btree(salary);
/*Hash Join  (cost=1.20..2.24 rows=1 width=374)
  Hash Cond: (d.department_id = e.department_id)
  ->  Seq Scan on departments d  (cost=0.00..1.16 rows=4 width=126)
        Filter: (budget > 50)
  ->  Hash  (cost=1.15..1.08 rows=4 width=248)
        ->  Seq Scan on employees e  (cost=0.00..1.12 rows=4 width=248)
              Filter: (salary < 600)
*/

SELECT last_name
FROM employees;

EXPLAIN SELECT last_name
FROM employees;
--Seq Scan on employees  (cost=0.00..1.12 rows=12 width=118)

CREATE INDEX lastname
    ON employees USING BTREE(last_name);
--Seq Scan on employees  (cost=0.00..1.03 rows=12 width=118)

SELECT department_name
FROM departments;

EXPLAIN SELECT department_name
FROM departments;
--Seq Scan on departments  (cost=0.00..1.34 rows=13 width=118)

CREATE INDEX dep_name
    ON departments USING HASH (department_name);
--Seq Scan on departments  (cost=0.00..1.13 rows=13 width=118)

SELECT *
FROM countries;

EXPLAIN SELECT *
FROM countries;
--Seq Scan on countries  (cost=0.00..1.14 rows=14 width=82)

CREATE UNIQUE INDEX to_countries ON countries (countrie_id, name);
--Seq Scan on countries  (cost=0.00..1.02 rows=14 width=82)
