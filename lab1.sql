create database lab1;
create table organisers(
    num serial,
    first_name varchar(50),
    last_name varchar(50),
    middle_name varchar(50),
    birth_date date
);
INSERT INTO organisers(first_name, last_name, middle_name, birth_date)  VALUES ('Nuray', 'Turganbaeva', 'Garifolla', '04/08/2002');
--DELETE FROM organisers
    --WHERE num = 1;

ALTER TABLE organisers
ADD admin_group integer;

ALTER TABLE organisers
ADD salary integer;

ALTER TABLE organisers DROP COLUMN place_of_birth;

ALTER TABLE organisers
ADD  place_of_birth varchar(50) DEFAULT 'Nur-sultan';

ALTER TABLE organisers
ALTER COLUMN admin_group TYPE boolean USING admin_group :: boolean;

ALTER TABLE organisers
ALTER COLUMN admin_group SET DEFAULT FALSE;

ALTER TABLE organisers
ALTER COLUMN salary SET DEFAULT 100000;

ALTER TABLE organisers
ADD PRIMARY KEY (num);

create table jobs(
    num serial,
    name varchar (50),
    jobs_num int,
    description varchar (50)
);

DROP TABLE organisers;
DROP DATABASE lab1;