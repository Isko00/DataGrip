-- 1
create database laboratory_work2;

-- 2
CREATE TABLE environs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    district_id INT,
    population  INT
);

-- 3
INSERT INTO environs (name, district_id, population)
    VALUES ('Almaty environ', 5, 2059200);

-- 4
INSERT INTO environs (name)
    VALUES ('Shymkent environ');

-- 5
INSERT INTO environs (district_id)
    VALUES (NULL);

-- 6
INSERT INTO environs (name, district_id, population)
    VALUES ('Kyzylorda environ', 11, 799533),
        ('Akmola environ', 3, 715000),
        ('Pavlodar environ', 14, 754739);

-- 7
ALTER TABLE environs
    ALTER COLUMN name SET DEFAULT 'Earth';

-- 8
INSERT INTO environs (name)
    VALUES (DEFAULT);

-- 9
INSERT INTO environs (name, district_id, population)
    VALUES (DEFAULT,DEFAULT,DEFAULT);

-- 10
CREATE TABLE environs_new (LIKE environs);

-- 11
INSERT INTO environs_new
    SELECT * FROM environs;

-- 12
UPDATE environs_new
    SET district_id = 1
        WHERE district_id IS NULL;

-- 13
ALTER TABLE environs_new
    ADD COLUMN New_Population int;
-- noinspection SqlWithoutWhere

UPDATE environs_new
    SET  New_Population = population * 1.4;

-- 14
DELETE FROM environs_new
    WHERE population < 100000;

-- additional
DROP DATABASE laboratory_work2;
DROP TABLE environs_new;
DROP TABLE environs;