-- 1
create database laboratory_work4;

-- 2
CREATE TABLE Warehouses (
  code INTEGER PRIMARY KEY,
  location VARCHAR(255) NOT NULL ,
  capacity INTEGER NOT NULL
);

CREATE TABLE Packs (
  code CHARACTER(4) PRIMARY KEY,
  contents VARCHAR(255) NOT NULL ,
  value REAL,
  warehouse INTEGER NOT NULL
);

-- 3
INSERT INTO Packs(code,contents,value,warehouse)
    VALUES('0MN7','Rocks',180,3),
            ('4H8P','Rocks',250,1),
            ('4RT3','Scissors',190,4),
            ('7G3H','Rocks',200,1),
            ('8JN6','Papers',75,1),
            ('8Y6U','Papers',50,3),
            ('9J6F','Papers',175,2),
            ('LL08','Rocks',140,4),
            ('P0H6','Scissors',125,1),
            ('P2T6','Scissors',150,2),
            ('TU55','Papers',90,5);

INSERT INTO Warehouses(code,location,capacity)
    VALUES(1,'Chicago', 3),
            (2,'Chicago', 4),
            (3,'New York', 7),
            (4,'Los Angeles', 2),
            (5,'San Francisco', 8);

-- 4
SELECT * FROM Packs;

-- 5
SELECT * FROM Packs
    WHERE value > 180;

-- 6
SELECT DISTINCT (contents) * FROM Packs;

-- 7
SELECT DISTINCT warehouse, count(warehouse) FROM Packs
    GROUP BY warehouse
    ORDER BY warehouse;

-- 8
SELECT DISTINCT warehouse, count(warehouse) FROM Packs
    GROUP BY warehouse
    HAVING count(warehouse) > 2
    ORDER BY warehouse;

-- 9
INSERT INTO Warehouses(code,location,capacity) VALUES(6,'Texas', 5);

-- 10
INSERT INTO Packs(code,contents,value,warehouse) VALUES('H5RT','Papers',350,2);

-- 11
UPDATE Packs
    SET value = value * 0.82
    WHERE value = (
       SELECT value FROM Packs
            ORDER BY value DESC LIMIT 1 OFFSET 2);

-- 12
DELETE FROM Packs
    WHERE value < 150;

-- 13
DELETE FROM Packs
    WHERE warehouse IN (
        SELECT code from Warehouses WHERE location = 'Chicago');

-- task

-- ANY
SELECT warehouse FROM Packs
    WHERE warehouse = ANY(
        SELECT code from Warehouses
            WHERE code IN (4, 5)
        );

-- ALL
SELECT warehouse FROM Packs
    WHERE warehouse <> ALL(
        SELECT capacity FROM Warehouses);

-- SOME

SELECT warehouse FROM Packs
    WHERE LEFT(code, 1) = SOME(SELECT CAST (code AS char) from Warehouses);

-- IN
SELECT code from Packs
    WHERE LEFT(code, 1) IN (SELECT LEFT(contents, 1) from Packs);

-- NOT IN

SELECT warehouse FROM Packs
    WHERE warehouse NOT IN (
        SELECT CHAR_LENGTH(contents) - 5 from Packs);

-- CASE

SELECT warehouse,
    CASE warehouse
           WHEN 1 THEN 'One'
           WHEN 2 THEN 'Two'
           WHEN 3 THEN 'Three'
           WHEN 4 THEN 'Four'
           WHEN 5 THEN 'Five'
       END byWords
    FROM Packs;

-- COALESCE
INSERT INTO Packs(code,contents,warehouse) VALUES('7G2I','COALESCE',2);

SELECT code, COALESCE(value,-1) AS value FROM Packs;

-- STRING FUNCTIONS
SELECT REPEAT(code, 2),
       REVERSE(code),
       LEFT(code, 2) from Packs;

-- EXISTS
SELECT * FROM Packs
    WHERE EXISTS (SELECT * FROM Packs WHERE value = 250);

SELECT COUNT(*) AS "Packs amount" FROM Packs;



SELECT * FROM Packs;
SELECT * FROM Warehouses;
DROP TABLE Packs;
DROP TABLE Warehouses;
DROP DATABASE laboratory_work4;