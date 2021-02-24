CREATE TABLE highscooler(
    id INTEGER ,
    name VARCHAR(255),
    grade INTEGER
);

CREATE TABLE friends(
    id1 INTEGER ,
    id2 INTEGER
);

CREATE TABLE likes(
    id1 INTEGER ,
    id2 INTEGER
);

insert into highscooler(id, name, grade)
values (1510, 'Jordan', 9),
       (1689, 'Gabriel', 9),
       (1381, 'Tiffany', 9),
       (1709, 'Cassandra', 9),
       (1101, 'Haley', 10),
       (1782, 'Andrew', 10),
       (1468, 'Kris', 10),
       (1641, 'Britany', 10),
       (1247, 'Alexis', 11),
       (1316, 'Austin', 11),
       (1911, 'Gabriel', 11),
       (1501, 'Jessica', 11),
       (1304, 'Jordan', 12),
       (1025, 'John', 12),
       (1934, 'Kyle', 12),
       (1661, 'Logan', 12);

insert into friends(id1, id2)
values (1510,1381),
       (1510,1689),
       (1689,1709),
       (1381, 1247),
       (1709,1381),
       (1689,1782),
       (1782,1468),
       (1782,1316),
       (1782,1304),
       (1468, 1101),
       (1468, 1641),
       (1101, 1641),
       (1247, 1911);

insert into likes(id1, id2)
VALUES (1689,1709),
       (1709,1689),
       (1782,1709),
       (1911,1247),
       (1247,1468),
       (1641,1468),
       (1316,1304),
       (1501,1934),
       (1934,1501),
       (1025,1101);

SELECT stud1.name
FROM highscooler stud1
INNER JOIN friends f ON stud1.id = f.id1
INNER JOIN highscooler stud2 ON stud2.ID = f.id2
WHERE stud2.name = 'Gabriel';

SELECT stud1.name, stud1.grade, stud1.name, stud1.grade
FROM highscooler stud1
INNER JOIN likes l ON stud1.id = l.ID1
INNER JOIN highscooler stud2 ON stud2.ID = l.ID2
WHERE (stud1.grade - stud2.grade) >= 2;

SELECT name, grade
FROM highscooler
INNER JOIN likes ON highscooler.id = likes.id2
GROUP BY id2, highscooler.name, highscooler.grade
HAVING COUNT(*) > 1;

SELECT name, grade
FROM highscooler stud1
WHERE id NOT IN (
  SELECT id1
  FROM friends, highscooler stud2
  WHERE stud1.id = friends.id1 AND stud2.ID = friends.id2 AND stud1.grade <> stud2.grade
)
ORDER BY grade, name;

SELECT stud1.name, stud1.grade, stud2.name, stud2.grade
FROM highscooler stud1, highscooler stud2, likes l1, likes l2
WHERE (stud1.id = L1.id1 AND stud2.id = l1.id2)
  AND (stud2.id = L2.id1 AND stud1.id = L2.id2)
  AND stud1.name < stud2.name
ORDER BY stud1.name, stud2.name;

