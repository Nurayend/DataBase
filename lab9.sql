CREATE DATABASE lab9;

CREATE TABLE customers(
 customer_id INT,
 cust_name VARCHAR(255),
 city VARCHAR(255),
 grade INT,
 salesman_id INT
);

CREATE TABLE orders(
 ord_no INT,
 purch_amt REAL,
 ord_date VARCHAR(255),
 customer_id INT,
 salesman_id INT
);

CREATE TABLE salesmans(
    salesman_id INT,
    name VARCHAR(255),
    city VARCHAR(255),
    commission REAL
);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id)  VALUES (3002, 'Nick Rimando', 'New York', 100, 5001);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3001, 'Brad Guzan', 'London', null, 5005);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3004, 'Fabian Johns', 'Paris', 300, 5006);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3009, 'Geoff Camero', 'Berlin', 100, 5003);
INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70001, 150.5, '2012-10-05', 3005, 5002);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70009, 270.65, '2012-09-10', 3001, 5005);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70002, 65.26, '2012-10-05', 3002, 5001);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70004, 110.5, '2012-08-17', 3009, 5003);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70007, 948.5, '2012-09-10', 3005, 5002);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70005, 2400.6, '2012-07-27', 3007, 5001);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70008, 5760, '2012-09-10', 3002, 5001);

INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5001, 'James Hoog', 'New York', 0.15);
INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5002, 'Nail Knite', 'Paris', 0.13);
INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5005, 'Pit Alex', 'London', 0.11);
INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5006, 'Mc Lyon', 'Paris', 0.14);
INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5003, 'Lauson Hen', null, 0.12);
INSERT INTO salesmans(salesman_id, name, city, commission) VALUES (5007, 'Paul Adam', 'Rome', 0.13);

CREATE VIEW salesmans_in_New_York AS
    SELECT * FROM salesmans
    WHERE city = 'New York';
SELECT * FROM salesmans_in_New_York;

CREATE VIEW orders_with_salesman_and_customer AS
    SELECT o.ord_no, c.cust_name, s.name FROM orders o, customers c, salesmans s
    WHERE o.salesman_id = s.salesman_id AND o.customer_id = c.customer_id;
SELECT * FROM orders_with_salesman_and_customer;

CREATE VIEW  highest_grade_of_customers AS
    SELECT * FROM customers
    WHERE grade = (SELECT max(grade) FROM customers);
SELECT * FROM highest_grade_of_customers;

CREATE VIEW numberofsalesmans AS
    SELECT city, count(name)
    FROM salesmans
    GROUP BY city;
SELECT * FROM numberofsalesmans;

CREATE VIEW numberofcust AS
    SELECT s.name
    FROM salesmans s
    WHERE (SELECT count(*) FROM customers c WHERE c.salesman_id = s.salesman_id) > 1;
SELECT * FROM numberofcust;

CREATE VIEW custname AS
    SELECT * FROM customers
    WHERE cust_name LIKE 'B%';
SELECT * FROM custname;

CREATE VIEW withjoin AS
    SELECT s.name, c.cust_name, s.city
    FROM customers c
    INNER JOIN salesmans s ON c.city = s.city;
SELECT * FROM withjoin;

CREATE VIEW withunion AS
    SELECT city FROM salesmans
    UNION
    SELECT city FROM customers;
SELECT * FROM withunion;

CREATE VIEW withorderby AS
    SELECT * FROM salesmans
    ORDER BY city;
SELECT * FROM withorderby;

CREATE VIEW orddate AS
    SELECT ord_date FROM orders;
ALTER VIEW orddate
    RENAME TO orders_date;

SELECT s.name, s.city, c.cust_name
FROM salesmans s
LEFT JOIN customers c ON s.salesman_id = c.salesman_id
ORDER BY s.salesman_id;

CREATE VIEW withgroupbys AS
    SELECT COUNT(cust_name), city
    FROM customers
    GROUP BY city;
SELECT * FROM withgroupby;