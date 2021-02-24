CREATE DATABASE lab7;

CREATE TABLE salesmen(
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    comission REAL
);

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesmen
);

CREATE TABLE orders(
    ord_no SERIAL PRIMARY KEY,
    purch_amt REAL,
    ord_date DATE,
    customer_id INTEGER REFERENCES customers,
    salesman_id INTEGER REFERENCES salesmen
);

INSERT INTO salesmen (salesman_id, name, city, comission) VALUES (5001, 'James Hoog', 'New York', 0.15),
                                                                 (5002, 'Nail Knite', 'Paris', 0.13),
                                                                 (5005, 'Pit Alex', 'London', 0.11),
                                                                 (5006, 'Mc Lyon', 'Paris', 0.14),
                                                                 (5007, 'Paul Adam', 'Rome', 0.13),
                                                                 (5003, 'Lauson Hen', 'San Jose', 0.12);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
                                                                                (3007, 'Brad Davis', 'New York', 200, 5001),
                                                                                (3005, 'Braham Zusi', 'California', 200, 5002),
                                                                                (3008, 'Julian Green', 'London', 300, 5002),
                                                                                (3004, 'Fabian Jhonson', 'Paris', 300, 5006),
                                                                                (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
                                                                                (3003, 'Jozy Altidor', 'Moscow', 200, 5007),
                                                                                (3001, 'Brad Guzan', 'London', NULL, 5005);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70001, 150.5, '05/10/2012', 3005, 5002),
                                                                                  (70009, 270.65, '10/09/2012', 3001, 5005),
                                                                                  (70002, 65.26, '05/10/2012', 3002, 5001),
                                                                                  (70004, 110.5, '17/08/2012', 3009, 5003),
                                                                                  (70007, 948.5, '10/09/2012', 3005, 5002),
                                                                                  (70005, 2400.6, '27/07/2012', 3007, 5001),
                                                                                  (70008, 5760, '10/09/2012', 3002, 5001),
                                                                                  (70010, 1983.43, '10/10/2012', 3004, 5006),
                                                                                  (70003, 2480.4, '10/10/2012', 3009, 5003),
                                                                                  (70012, 250.45, '27/06/2012', 3008, 5002),
                                                                                  (7011, 75.29, '17/08/2012', 3003, 5007),
                                                                                  (70013, 3045.6, '25/04/2012', 3002, 5001);

SELECT salesmen.name, c.cust_name, salesmen.city
FROM salesmen
INNER JOIN customers c on salesmen.city = c.city;

SELECT orders.ord_no, orders.purch_amt, c.cust_name, c.city
FROM orders
INNER JOIN customers c on c.customer_id = orders.customer_id
WHERE orders.purch_amt > 500 AND orders.purch_amt < 2000;

SELECT salesmen.name, c.cust_name
FROM salesmen
INNER JOIN customers c on salesmen.salesman_id = c.salesman_id;

SELECT customers.cust_name
FROM customers
INNER JOIN salesmen s on s.salesman_id = customers.salesman_id
WHERE s.comission > 0.12;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM customers c
INNER JOIN orders o on c.customer_id = o.customer_id
ORDER BY o.ord_date ASC;

SELECT name
FROM salesmen
INNER JOIN customers c on salesmen.salesman_id = c.salesman_id
ORDER BY name ASC;

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES (4000, 'Moon', 'Tokyo', NULL, 5003);
SELECT c.cust_name, c.city
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

