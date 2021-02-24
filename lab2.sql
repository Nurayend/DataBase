create database laboratory_work2;

create table division(
    id serial,
    name varchar(50),
    district_id int,
    population int
);

INSERT INTO division (name, district_id, population) VALUES ('Europe', 1, 1700000);

INSERT INTO division (name) VALUES ('Asia');

INSERT INTO division (district_id) VALUES (NULL);

INSERT INTO division (name, district_id, population) VALUES ('Australia', 3, 12345),
                                                            ('North America', 4, 456789),
                                                            ('South America', 5, 1000);

ALTER TABLE division
ALTER COLUMN name SET DEFAULT 'Earth';

INSERT INTO division (name) VALUES (DEFAULT);

INSERT INTO division (name, district_id, population) VALUES (DEFAULT, DEFAULT, DEFAULT);

CREATE TABLE division_new (LIKE division);

INSERT INTO division_new SELECT * FROM division;

UPDATE division_new
SET district_id = 1
WHERE district_id IS NULL;

ALTER TABLE division_new
ADD COLUMN new_population int;

UPDATE division_new
SET new_population = population*1.35
WHERE new_population IS NULL;

DELETE FROM division_new
    WHERE name like('A%');

DELETE FROM division_new
WHERE population < 100000;