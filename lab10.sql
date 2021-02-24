CREATE DATABASE lab10;

CREATE TABLE reviewer(
    reviewer_ID INT PRIMARY KEY,
    name varchar(50)
);

CREATE TABLE movie(
    movie_ID INT PRIMARY KEY,
    title varchar(50),
    year INT,
    director varchar(50)
);

CREATE TABLE rating(
    reviewer_ID INT REFERENCES reviewer(reviewer_ID),
    movie_ID INT REFERENCES movie(movie_ID),
    stars INT,
    ratingDate date
);

CREATE TABLE salesmen(
    salesman_id int PRIMARY KEY,
    name varchar(50),
    city varchar(50),
    commission float
);

CREATE TABLE customers(
    customer_id int PRIMARY KEY ,
    cust_name varchar(50),
    city varchar(50),
    grade int,
    salesman_id int REFERENCES salesmen(salesman_id)
);

CREATE TABLE orders(
    ord_no int PRIMARY KEY,
    purch_amt float,
    ord_date date,
    customer_id int REFERENCES customers(customer_id),
    salesman_id int REFERENCES salesmen(salesman_id)
);

INSERT INTO reviewer
VALUES (201,'Sarah Martinez'),
       (202,'Daniel Lewis'),
       (203,'Brittany Harris'),
       (204,'Mike Anderson'),
       (205,'Chris Jackson'),
       (206,'Elizabeth Thomas'),
       (207,'James Cameron'),
       (208,'Ashley White');

INSERT INTO movie
VALUES (101,'Gone with the Wind',1939,'Victor Fleming'),
       (102,'Star Wars',1977,'George Lucas'),
       (103,'The Soune the Music',1965,'Robert Wise'),
       (104,'E.T.',1982,'Steven Spielberg'),
       (105,'Titanic',1997,'James Cameron'),
       (106,'Snow White',1937,null),
       (107,'Avatar',2009,'James Cameron'),
       (108,'Raiders of the Lost Ark',1981,'Steven Spielberg');

INSERT INTO rating
VALUES (201,101,2,'2011-01-22'),
       (201,101,4,'2011-01-27'),
       (202,106,4,null),
       (203,103,2,'2011-01-20'),
       (203,108,4,'2011-01-12'),
       (203,108,2,'2011-01-30'),
       (204,101,3,'2011-01-09'),
       (205,103,3,'2011-01-27'),
       (205,104,2,'2011-01-22');

INSERT INTO salesmen
VALUES (5001,'James Hoog','New York', 0.15),
       (5002,'Nail Knite','Paris', 0.13),
       (5005,'Pit Alex','London', 0.11),
       (5006,'Mc Lyon','Paris', 0.14),
       (5003,'Lauson Hen',null, 0.12),
       (5007,'Paul Adam','Rome', 0.13);

INSERT INTO customers
VALUES (3002,'Nick Rimando','New York',100,5001),
       (3005,'Graham Zusi','California',200,5002),
       (3001,'Brad Guzan','London',null,5005),
       (3004,'Fabian Johns','Paris',300,5006),
       (3007,'Brad Davis','New York',200,5001),
       (3009,'Geoff Camero','Berlin',100,5003),
       (3008,'Julian Green','London',300,5002);

INSERT INTO orders
VALUES (70001,150.5,'2012-10-05',3005,5002),
       (70009,270.65,'2012-09-10',3001,5005),
       (70002,65.26,'2012-10-05',3002,5001),
       (70004,110.5,'2012-08-17',3009,5003),
       (70007,948.5,'2012-09-10',3005,5002),
       (70005,2400.6,'2012-07-27',3007,5001),
       (70008,5760,'2012-09-10',3002,5001);

CREATE ROLE junior_dev LOGIN;
ALTER ROLE junior_dev PASSWORD 'n123';
SELECT * FROM pg_roles;
SELECT * FROM orders;

CREATE OR REPLACE VIEW order_salesman_customer_name AS
SELECT o.*, s.name, c.cust_name FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
INNER JOIN salesmen s ON s.salesman_id = o.salesman_id;

SELECT * FROM order_salesman_customer_name;

GRANT ALL PRIVILEGES ON order_salesman_customer_name TO junior_dev;

SELECT * FROM rating;

SELECT * FROM order_salesman_customer_name;

CREATE VIEW customers_highest_grade AS
SELECT * FROM customers
WHERE grade = (SELECT max(grade) FROM customers);

SELECT * FROM customers_highest_grade;

GRANT SELECT ON customers_highest_grade TO junior_dev;

CREATE ROLE intern LOGIN;

GRANT junior_dev TO intern;

SELECT * FROM pg_roles;

CREATE OR REPLACE VIEW all_years_rating_star_4_5_and_sorted_inc AS
SELECT m.year,m.title,r.stars  FROM movie m
INNER JOIN rating r ON m.movie_id = r.movie_id and r.stars BETWEEN 4 and 5
ORDER BY r.stars ASC;
SELECT * FROM all_years_rating_star_4_5_and_sorted_inc;

CREATE ROLE with_login LOGIN CREATEROLE ;
SELECT * FROM pg_roles;

GRANT postgres to with_login;
SELECT * FROM pg_roles;
ALTER ROLE with_login SUPERUSER CREATEROLE CREATEDB REPLICATION ;

CREATE ROLE student PASSWORD 'not_Simple_Passwod' VALID UNTIL '2021-01-01';
CREATE ROLE admin CREATEDB CREATEROLE ;
SELECT * FROM pg_roles ORDER BY rolname;

ALTER ROLE student WITH PASSWORD 'Simple_Password';
ALTER ROLE student WITH PASSWORD NULL;

SELECT (ratingDate ||' '|| stars) as name  FROM rating WHERE ratingDate > '2011-01-22';

