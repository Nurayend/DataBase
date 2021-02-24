CREATE DATABASE lab11;

CREATE FUNCTION cubes(INOUT n NUMERIC)
AS $$
BEGIN
    n:= n * n * n;
END; $$
LANGUAGE plpgsql;

CREATE FUNCTION sumavg(
VARIADIC list NUMERIC[],
OUT total NUMERIC,
OUT average NUMERIC
)
AS $$
BEGIN
    SELECT INTO total SUM(list[i])
    FROM generate_subscripts(list, 1) g(i);

    SELECT INTO average AVG(list[i])
    FROM generate_subscripts(list, 1) g(i);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION maxi(
VARIADIC list NUMERIC[],
OUT max NUMERIC
)
AS $$
    BEGIN
    SELECT INTO max MAX(list[i])
    FROM generate_subscripts(list, 1) g(i);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION mini(
VARIADIC list NUMERIC[],
OUT min NUMERIC
)
AS $$
    BEGIN
    SELECT INTO min MIN(list[i])
    FROM generate_subscripts(list, 1) g(i);
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION counting(
VARIADIC list NUMERIC[],
OUT cnt NUMERIC
)
AS $$
    BEGIN
    SELECT INTO cnt COUNT(list[i])
    FROM generate_subscripts(list, 1) g(i);
END; $$
LANGUAGE plpgsql;

CREATE TABLE students(
    id SERIAL PRIMARY KEY ,
    name varchar(50),
    specialty varchar(50),
    birth_date date,
    address varchar(50),
    mob_number varchar(11)
);

INSERT INTO students(name, specialty, birth_date, address, mob_number)
SELECT 'Student-' || i, 'IS', '2002-12-12', 'street-'||i*2, '12345' || i
FROM generate_series(1,50) i;

SELECT * FROM students;

CREATE OR REPLACE FUNCTION tableStudent()
RETURNS TABLE(
    id INT,
    name varchar(50),
    specialty varchar(50),
    birth_date date,
    address varchar(50),
    mob_number varchar(11)
)AS
    $$
    BEGIN
        RETURN QUERY SELECT
        s.id,s.name,s.specialty,s.birth_date,s.address,s.mob_number
        FROM students s;
    END;
    $$
LANGUAGE plpgsql;

ALTER TABLE students ADD COLUMN height int DEFAULT 170;
--SELECT * FROM students;
UPDATE students SET height = 170 - 5  WHERE id > 25 and id < 50;

CREATE OR REPLACE FUNCTION tallStudent()
RETURNS TABLE(
    id INT,
    name varchar(50),
    specialty varchar(50),
    birth_date date,
    address varchar(50),
    mob_number varchar(11),
    height int
)AS
    $$
    BEGIN
        RETURN QUERY SELECT s.* FROM students s
        WHERE s.height = (SELECT max(students.height) FROM students);
    END;
    $$
LANGUAGE plpgsql;

SELECT * FROM tallStudent();

SELECT cubes(2);

SELECT sumavg(10, 48, 20);

SELECT maxi(10, 20);

SELECT mini(10, 23);

SELECT counting(10, 20, 30, 40);

SELECT * FROM tableStudent();





