CREATE DATABASE lab5;

CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    cust_name  character varying(255),
    city character varying(255),
    grade INTEGER,
    salesman_id INTEGER
);

CREATE TABLE orders(
    ord_no INTEGER PRIMARY KEY ,
    purch_amt REAL,
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);

CREATE TABLE salesman(
    salesman_id INTEGER ,
    name character varying(255),
    city character varying(255),
    commission REAL
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3001, 'Brad Guzan', 'London', NULL, 5005),
       (3004, 'Fabian Johns', 'Paris', 300, 5006),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3009, 'Geoff Camero', 'Berlin', 100, 5003),
       (3008, 'Julian Green', 'London', 300, 5002);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)  VALUES(3000, 'Julian Grebn', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70001, 150.5, '05/10/2012', 3005, 5002),
       (70009, 270.65, '10/09/2012', 3001, 5005),
       (70002, 65.26, '05/10/2012', 3002, 5001),
       (70004, 110.5, '17/08/2012', 3009, 5003),
       (70007, 948.5, '10/09/2012', 3005, 5002),
       (70005, 2400.6, '27/07/2012', 3007, 5001),
       (70008, 5760, '10/09/2012', 3002, 5001);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5003, 'Lauson Hen', NULL, 0.12),
       (5007, 'Paul Adam', 'Rome', 0.13);

SELECT sum(purch_amt)
FROM orders;

SELECT avg(purch_amt)
FROM orders;

SELECT count(*)
FROM customers
WHERE cust_name IS NOT NULL;

SELECT min(purch_amt)
FROM orders;

SELECT *
FROM customers
WHERE cust_name LIKE '%b%';

SELECT *
FROM orders
WHERE salesman_id IN (
    SELECT salesman_id
     FROM salesman
     WHERE city ='New York');

SELECT *
FROM customers
WHERE salesman_id IN (
    SELECT purch_amt
    FROM orders
    WHERE purch_amt > 10 );

SELECT sum(grade) FROM customers;

SELECT COALESCE(cust_name) FROM customers;

SELECT max(grade) FROM customers;

SELECT to_char(220, '999');
SELECT to_char(220.01, 'S999D99');
SELECT to_char(current_timestamp, 'HH12:MI:SS');
SELECT to_char(interval '22h 17m 25s', 'HH24:MI:SS');
SELECT to_date('17 Oct 2020', 'DD Mon YYYY');
SELECT to_number('2002,23.06', '9999G99D99');
SELECT to_timestamp('17 Oct 2020 22:32:04', 'DD Mon YYYY HH24:MI:SS');

select MIN(ord_date), MAX(ord_date)
from orders
where ord_date = max(ord_date);

select ord_no, max(ord_date) from orders
union
select ord_no, min(ord_date) from orders;
