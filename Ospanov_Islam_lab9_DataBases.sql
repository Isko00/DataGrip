CREATE DATABASE lab9;

CREATE TABLE salesman (
  salesman_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(30),
  commission REAL
);

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  cast_name VARCHAR(50),
  city VARCHAR(30),
  grade INTEGER,
  salesman_id INTEGER REFERENCES salesman
);

CREATE TABLE orders (
  ord_no SERIAL PRIMARY KEY,
  purch_amt REAL,
  ord_date DATE,
  customer_id INTEGER REFERENCES customers,
  salesman_id INTEGER REFERENCES salesman
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', null, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers(customer_id, cast_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', null, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

SELECT * FROM salesman;
SELECT * FROM customers;
SELECT * FROM orders;

DROP TABLE orders;
DROP TABLE customers;
DROP TABLE salesman;

DROP DATABASE lab9;

-- 3
CREATE VIEW v1 AS
    SELECT * FROM salesman
        WHERE city = 'New York';

SELECT * FROM v1;

DROP VIEW v1;
-- 4
CREATE VIEW v2 AS
    SELECT s.name, c.cast_name FROM orders
        join salesman s USING(salesman_id)
        join customers c USING(customer_id);

SELECT * FROM v2;

DROP VIEW v2;
-- 5
CREATE VIEW v3 AS
    SELECT max(grade) FROM customers;

SELECT * FROM v3;

DROP VIEW v3;

-- 6
CREATE VIEW v4 AS
    SELECT count(salesman_id), city FROM salesman
        WHERE city NOTNULL
        GROUP BY city;

SELECT * FROM v4;

DROP VIEW v4;

-- 7
CREATE VIEW v5 AS
    SELECT s.name FROM salesman s
        JOIN customers c USING(salesman_id)
        GROUP BY salesman_id
        HAVING count(salesman_id) > 1;

SELECT * FROM v5;

DROP VIEW v5;

-- 8
CREATE VIEW v6 AS
    SELECT name FROM salesman
        WHERE name LIKE 'Paul%';

SELECT * FROM v6;

DROP VIEW v6;

-- 9
CREATE VIEW v7 AS
    SELECT s.name FROM salesman s
        JOIN customers c USING(salesman_id)
        GROUP BY salesman_id
        HAVING count(salesman_id) > 1;

SELECT * FROM v7;

DROP VIEW v7;

-- 10
CREATE VIEW v8 AS
    SELECT name FROM salesman
    UNION
    SELECT cast_name FROM customers;

SELECT * FROM v8;

DROP VIEW v8;

-- 11
CREATE VIEW v9 AS
    SELECT name FROM salesman
        ORDER BY name;

SELECT * FROM v9;

DROP VIEW v9;

-- 12
CREATE VIEW abc AS
    SELECT name FROM salesman;

ALTER VIEW abc RENAME TO xyz;

SELECT * FROM xyz;

DROP VIEW abc;

-- 13
CREATE VIEW v10 AS
    SELECT count(salesman_id), city FROM salesman
        WHERE city NOTNULL
        GROUP BY city;

SELECT * FROM v10;

DROP VIEW v10;