CREATE DATABASE laboratory_work3;

SELECT name FROM employees;

SELECT DISTINCT lastname
FROM employees;

SELECT * FROM employees
WHERE lastname = 'Smith';

SELECT * FROM employees
WHERE lastname = 'Smith' OR lastname = 'Doe';

SELECT * FROM departments
WHERE code = 59;

SELECT * FROM departments
WHERE code = 77 OR code = 14;

SELECT * FROM employees
WHERE city = 'Almaty';

SELECT SUM(budget)
FROM departments;

SELECT department, count(*)
FROM employees GROUP BY department;

SELECT department, count(department)
FROM employees GROUP BY department
HAVING count(department) > 2;

SELECT name, budget FROM departments
WHERE budget = (SELECT MAX(budget)
FROM departments
WHERE budget < (SELECT MAX(budget)
FROM departments));

SELECT name, lastname
FROM employees
WHERE department=
      (SELECT code FROM departments
      WHERE budget IN (SELECT max(budget) FROM departments))
   OR department=
      (SELECT code FROM departments
      WHERE budget IN (SELECT min(budget) FROM departments));

SELECT name
FROM employees
WHERE city = 'Astana'
UNION ALL SELECT name
FROM customers
WHERE city = 'Astana';

SELECT * FROM departments
WHERE budget > 55000 ORDER BY budget ASC, code DESC;

UPDATE departments
    SET  budget = budget*0.9
WHERE budget = (SELECT min(budget) FROM departments);

UPDATE employees
    SET department =
        (SELECT code FROM departments
            WHERE name = 'IT')
WHERE department =
      (SELECT code FROM departments
          WHERE name = 'Reasearch');

DELETE FROM departments
WHERE name = 'IT';

DELETE FROM employees;

SELECT code, name FROM departments
WHERE budget = (SELECT MAX(budget)
FROM departments
WHERE budget < (SELECT MAX(budget)
FROM departments));

UPDATE departments
    SET  budget = budget*0.85
WHERE budget = (SELECT min(budget) FROM departments);

SELECT department, count(department)
FROM employees GROUP BY department
HAVING count(department) > 2;



