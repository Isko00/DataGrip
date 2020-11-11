-- 1
CREATE DATABASE lab7;

CREATE TABLE salesmen (
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
  salesman_id INTEGER REFERENCES salesmen
);

CREATE TABLE orders (
  ord_no SERIAL PRIMARY KEY,
  purch_amt REAL,
  ord_date DATE,
  customer_id INTEGER REFERENCES customers,
  salesman_id INTEGER REFERENCES salesmen
);

INSERT INTO salesmen (salesman_id, name, city, commission) VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5007, 'Paul Adam', 'Rome', 0.13),
    (5003, 'Lauson Hen', 'San Jose', 0.12);

INSERT INTO customers (customer_id, cast_name, city, grade, salesman_id) VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3008, 'Julian Green', 'London', 300, 5002),
    (3004, 'Fabian Johnson', 'Paris', 300, 5006),
    (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
    (3003, 'Jozy Altidor', 'Moscow', 100, 5007),
    (3001, 'Brad Guzan', 'London', NULL, 5005);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3002, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001),
    (70010, 1983.43, '2012-10-10', 3004, 5006),
    (70003, 2480.4, '2012-10-10', 3009, 5003),
    (70012, 250.45, '2012-06-27', 3008, 5002),
    (70011, 75.29, '2012-08-17', 3003, 5007),
    (70013, 3045.6, '2012-04-25', 3002, 5001);

SELECT * FROM salesmen;
SELECT * FROM customers;
SELECT * FROM orders;

DROP TABLE salesmen;
DROP TABLE customers;
DROP TABLE orders;

DROP DATABASE lab7;

-- 2
SELECT ARRAY(SELECT s.name, c.cast_name, s.city FROM salesmen s
    INNER JOIN customers c USING (city));

-- 3
SELECT o.ord_no, o.purch_amt, c.cast_name, c.city FROM orders o
    LEFT JOIN customers c USING (customer_id)
    WHERE o.purch_amt > 500 AND o.purch_amt < 2000;

-- 4
SELECT c.cast_name, s.name FROM customers c
    INNER JOIN salesmen s USING (salesman_id);

-- 5
SELECT c.cast_name FROM customers c
    INNER JOIN salesmen s USING (salesman_id)
    WHERE s.commission > 0.12;

-- 6
SELECT c.cast_name, city, o.ord_no, o.ord_date, o.purch_amt FROM customers c
    LEFT JOIN orders o USING (customer_id)
    ORDER BY o.ord_date;

-- 7
SELECT s.name, count(c.cast_name) FROM salesmen s
    LEFT JOIN customers c USING(salesman_id)
    GROUP BY name
    ORDER BY count(c.cast_name);

-- task
SELECT c.cast_name FROM customers c
    LEFT JOIN orders o USING (customer_id)
    WHERE o.customer_id IS NULL;