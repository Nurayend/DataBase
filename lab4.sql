CREATE DATABASE laboratory_work_4;
CREATE TABLE Warehouses(
    code integer,
    location character varying(255),
    capacity integer
);

CREATE TABLE Packs(
    code character(4),
    contents character varying(255),
    value real,
    warehouse integer
);

INSERT INTO Warehouses
    VALUES(1,'Chicago',3),
          (2,'Chicago',4),
          (3,'New York',7),
          (4,'Los Angeles',2),
           (5,'San Francisco',8);

INSERT INTO Packs
    VALUES ('0MN7', 'Rocks', 180, 3),
           ('4H8P', 'Rocks', 250, 1),
           ('4КЕ3', 'Scissors', 190, 4),
           ('7G3H', 'Rocks', 200, 1),
           ('8JN6', 'Papers', 75, 1),
           ('8Y6U', 'Papers', 50, 3),
           ('9J6F', 'Papers', 175, 2),
           ('LLO8', 'Rocks', 140, 4),
           ('POH6', 'Scissors', 125, 1),
           ('POH6', 'Scissors', 150, 2),
           ('TU55', 'Papers', 90, 5);

SELECT * FROM Packs;

SELECT * FROM Packs WHERE value > 180 ;

SELECT DISTINCT (contents) FROM Packs;

SELECT warehouse , count(*)
FROM Packs
GROUP BY warehouse;

SELECT warehouse , count(*)
FROM Packs
GROUP BY warehouse
HAVING warehouse > 2;

INSERT INTO Warehouses
    VALUES(6,'Texas',5);

SELECT * FROM Warehouses;

INSERT INTO Packs
    VALUES ('H5RT', 'Papers', 350, 2);

UPDATE Packs SET value = value*0.82
WHERE value=
            (SELECT value FROM Packs
            ORDER BY value ASC
            OFFSET 2 LIMIT 1) ;


SELECT * FROM Packs;

DELETE FROM Packs WHERE value > 150;

DELETE
FROM Packs
WHERE warehouse = 3 OR warehouse = 4;

--Case,Coalesce, IN, NOT IN, exists, any, some, all

SELECT location
FROM Warehouses
WHERE capacity = ANY (SELECT capacity FROM Warehouses WHERE capacity > 4);

SELECT location
FROM Warehouses
WHERE capacity = ALL (SELECT capacity FROM Warehouses WHERE capacity > 4);

SELECT
   CASE
      WHEN MIN(value) <= 0 THEN 0
      WHEN MAX(value) >= 100 THEN 1
   END
FROM Packs;

SELECT code, contents,
COALESCE(code, contents) AS FirstNotNull
FROM Packs;

SELECT *
FROM Packs
WHERE contents IN('Rocks', 'Papers');







