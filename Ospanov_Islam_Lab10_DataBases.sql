-- 1
CREATE DATABASE lab10;

CREATE TABLE reviewer(
    rID INT PRIMARY KEY ,
    name varchar(50)
);

CREATE TABLE movie(
    mID INT PRIMARY KEY ,
    title varchar(50),
    year INT,
    director varchar(50)
);

CREATE TABLE rating(
    rID INT REFERENCES reviewer(rid),
    mID INT REFERENCES movie(mID),
    stars INT,
    ratingDate date
);

CREATE TABLE salesmen(
    salesman_id int PRIMARY KEY ,
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
    ord_no int PRIMARY KEY ,
    purch_amt float,
    ord_date date,
    customer_id int REFERENCES customers(customer_id),
    salesman_id int REFERENCES salesmen(salesman_id)
);

INSERT INTO reviewer (rID, name) VALUES
        (201,'Sarah Martinez'),
       (202,'Daniel Lewis'),
       (203,'Brittany Harris'),
       (204,'Mike Anderson'),
       (205,'Chris Jackson'),
       (206,'Elizabeth Thomas'),
       (207,'James Cameron'),
       (208,'Ashley White');

INSERT INTO movie (mID, title, year, director) VALUES
        (101,'Gone with the Wind',1939,'Victor Fleming'),
       (102,'Star Wars',1977,'George Lucas'),
       (103,'The Soune the Music',1965,'Robert Wise'),
       (104,'E.T.',1982,'Steven Spielberg'),
       (105,'Titanic',1997,'James Cameron'),
       (106,'Snow White',1937,null),
       (107,'Avatar',2009,'James Cameron'),
       (108,'Raiders of the Lost Ark',1981,'Steven Spielberg');

INSERT INTO rating (rID, mID, stars, ratingDate) VALUES
        (201,101,2,'2011-01-22'),
       (201,101,4,'2011-01-27'),
       (202,106,4,null),
       (203,103,2,'2011-01-20'),
       (203,108,4,'2011-01-12'),
       (203,108,2,'2011-01-30'),
       (204,101,3,'2011-01-09'),
       (205,103,3,'2011-01-27'),
       (205,104,2,'2011-01-22');

INSERT INTO salesmen (salesman_id, name, city, commission) VALUES
        (5001,'James Hoog','New York', 0.15),
       (5002,'Nail Knite','Paris', 0.13),
       (5005,'Pit Alex','London', 0.11),
       (5006,'Mc Lyon','Paris', 0.14),
       (5003,'Lauson Hen',null, 0.12),
       (5007,'Paul Adam','Rome', 0.13);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES
        (3002,'Nick Rimando','New York',100,5001),
       (3005,'Graham Zusi','California',200,5002),
       (3001,'Brad Guzan','London',null,5005),
       (3004,'Fabian Johns','Paris',300,5006),
       (3007,'Brad Davis','New York',200,5001),
       (3009,'Geoff Camero','Berlin',100,5003),
       (3008,'Julian Green','London',300,5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
        (70001,150.5,'2012-10-05',3005,5002),
       (70009,270.65,'2012-09-10',3001,5005),
       (70002,65.26,'2012-10-05',3002,5001),
       (70004,110.5,'2012-08-17',3009,5003),
       (70007,948.5,'2012-09-10',3005,5002),
       (70005,2400.6,'2012-07-27',3007,5001),
       (70008,5760,'2012-09-10',3002,5001);

SELECT * FROM salesmen;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM reviewer;
SELECT * FROM movie;
SELECT * FROM rating;

DROP TABLE reviewer;
DROP TABLE movie;
DROP TABLE rating;
DROP TABLE orders;
DROP TABLE customers;
DROP TABLE salesmen;

DROP DATABASE lab10;

-- 2
CREATE ROLE junior_dev LOGIN;

ALTER ROLE junior_dev WITH PASSWORD '123';

SELECT * FROM pg_roles ORDER BY rolname;

REVOKE ALL
ON DATABASE lab10
FROM junior_dev;

DROP ROLE junior_dev;

-- 3
CREATE VIEW v1 AS
    SELECT o.ord_no, s.name, c.cust_name FROM orders o
        join salesmen s USING(salesman_id)
        join customers c USING(customer_id);

SELECT * FROM v1;

ALTER ROLE junior_dev SUPERUSER CREATEROLE CREATEDB REPLICATION;

DROP VIEW v1;

-- 4
CREATE VIEW v2 AS
    SELECT * FROM customers
    WHERE grade =
        (SELECT MAX (grade) FROM customers);

GRANT SELECT ON v2 TO junior_dev;

SELECT * FROM pg_roles ORDER BY rolname;

SELECT * FROM v2;

DROP VIEW v2;

-- 5
CREATE ROLE intern LOGIN;

ALTER ROLE intern WITH PASSWORD '123';

GRANT junior_dev TO intern WITH ADMIN OPTION ;

SELECT * FROM pg_roles ORDER BY rolname;

REVOKE ALL
ON ALL TABLES
IN SCHEMA "public"
FROM intern;

DROP ROLE intern;

-- 6
CREATE VIEW v3 AS
    SELECT DISTINCT m.year FROM movie m
    INNER JOIN rating r USING(mID)
    WHERE r.stars IN (4, 5)
    ORDER BY m.year;

SELECT * FROM v3;

DROP VIEW v3;

-- 7
CREATE ROLE main_role LOGIN CREATEROLE;

ALTER ROLE main_role WITH PASSWORD ' ';
-- 8
GRANT pg_signal_backend TO main_role;

SELECT * FROM pg_roles ORDER BY rolname;

REVOKE ALL
ON ALL TABLES
IN SCHEMA "public"
FROM main_role;

DROP ROLE main_role;

-- 9
CREATE ROLE student PASSWORD 'qwerty123' VALID UNTIL '2021-01-01' LOGIN ;

REVOKE ALL
ON ALL TABLES
IN SCHEMA "public"
FROM student;

DROP ROLE student;

CREATE ROLE admin CREATEDB CREATEROLE ;

SELECT * FROM pg_roles ORDER BY rolname;

-- 10
ALTER ROLE student WITH PASSWORD 'password';

ALTER ROLE student WITH PASSWORD NULL ;