create table movies(
    id serial,
    title varchar(255) NOT NULL UNIQUE,
    rating integer,
    genre varchar(50) NOT NULL,
    PRIMARY KEY (id)
);

create table theatres(
    id serial,
    name varchar(255) NOT NULL UNIQUE,
    size integer NOT NULL,
    city varchar(50) NOT NULL,
    PRIMARY KEY (id),
    CHECK (size>3)
);

INSERT INTO movies
                VALUES (1, 'Citizen Cane', 5, 'Drama'),
                       (2, 'Singin', 8, 'Comedy'),
                       (3, 'Wizard', 2, 'Fantasy'),
                       (4, 'Quiet', NULL, 'Comedy');
INSERT INTO movies VALUES (5, 'Sod', NULL, 'Fantasy');

INSERT INTO theatres
                VALUES (1, 'Esentai', 15, 'Almaty'),
                       (2, 'Star', 7, 'Almaty'),
                       (3, 'RT', 9, 'Shymkent');

SELECT * FROM movies
WHERE rating IS NOT NULL;

SELECT * FROM movies
WHERE genre IN('Comedy', 'Fantasy') AND rating IS NOT NULL;

SELECT *
  FROM theatres
WHERE size IS NOT NULL
 ORDER BY size DESC
 LIMIT 3;

SELECT *
  FROM movies
WHERE rating IS NOT NULL
 ORDER BY rating DESC
 LIMIT 1 OFFSET 2;

SELECT DISTINCT name FROM theatres;

CREATE TABLE movietheaters(
    theater_id serial NOT NULL,
    movie_id serial NOT NULL,
    rating int,
    FOREIGN KEY (theater_id) REFERENCES theatres(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    PRIMARY KEY (theater_id, movie_id)
);
insert into movietheaters(theater_id, movie_id, rating)
values (1, 1, 5),
       (2, 1, 9),
       (3, 1, 8),
       (3, 2, 0);
UPDATE movies SET rating = 1
WHERE rating IS NULL;
select * from movietheaters;
SELECT * FROM movies WHERE rating = 1;

SELECT * FROM movies WHERE title like 'S%o_';

SELECT avg(size)
FROM theatres;

SELECT upper(title), substring(title, 4), length(title) FROM movies;

SELECT id, count(id)
FROM theatres
GROUP BY id
HAVING count(id)>2;

SELECT * FROM movies
WHERE id in
(SELECT movie_id FROM movietheaters
GROUP BY movie_id HAVING count(movie_id)>2);

SELECT * FROM movies
WHERE EXISTS (SELECT * FROM theatres
WHERE  movies.id = theatres.id
GROUP BY movies.id HAVING count(*)>2);

SELECT * FROM movies
WHERE EXISTS(SELECT * FROM theatres WHERE movies.id = id OFFSET 1);

SELECT id
  FROM movies
EXCEPT
SELECT id
  FROM theatres;