-- 1
CREATE DATABASE laboratory_work5;

-- 2
CREATE TABLE salesmen (
     salesman_id INTEGER PRIMARY KEY,
     name VARCHAR(255),
     city VARCHAR(255),
     commisison FLOAT);

CREATE TABLE customers (
     customer_id INTEGER PRIMARY KEY ,
     cust_name VARCHAR(100),
     city VARCHAR(255),
     grade INTEGER,
     salesman_id INTEGER,
     FOREIGN KEY (salesman_id) REFERENCES salesmen(salesman_id));

CREATE TABLE orders (
     ord_no INTEGER,
     purch_amt FLOAT,
     ord_date DATE,
     customer_id INTEGER,
     salesman_id INTEGER,
     FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

INSERT INTO salesmen(salesman_id, name, city, commisison)
     VALUES (5001, 'James Hoog', 'New York', 0.15 ),
            (5002, 'Nail Knite', 'Paris',0.13 ),
            (5005, 'Pit Alex', 'London', 0.11),
            (5006, 'Mc Lyon','Paris', 0.14),
            (5003, 'Lauson Hen', NULL, 0.12),
            (5007, 'Psul Adam','Rome', 0.13);

INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id)
     VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
            (3005, 'Graham Zusi', 'California', 200, 5002),
            (3001, 'Brad Guzan', 'London', NULL, 5005),
            (3004, 'Fabian Johns', 'Paris', 300, 5006),
            (3007, 'Brad Davis', 'New York', 200, 5001),
            (3009, 'Geoff Camero', 'Berlin', 100, 5003),
            (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id)
     VALUES (70009, 270.65, '2012-09-10', 3001, 5005),
            (70002, 65.26, '2012-10-05',3002, 5001),
            (70004, 110.5, '2012-08-17', 3009, 5003),
            (70007, 948.5, '2012-09-10', 3005, 5002),
            (70005, 2400.6, '2012-07-27', 3007, 5001),
            (70008, 5760, '2012-09-10', 3002, 5001);

-- 3
SELECT sum(purch_amt) FROM orders;

-- 4
SELECT avg(purch_amt) FROM orders;

-- 5
SELECT  count(cust_name) FROM customers WHERE cust_name IS NOT NULL;

-- 6
SELECT min(purch_amt) FROM orders;

-- 7
SELECT * FROM salesmen  WHERE name LIKE '%b %';

-- 8
SELECT * FROM orders
    WHERE customer_id IN (
        SELECT customer_id FROM customers
            WHERE city = 'New York');

-- 9
SELECT * FROM customers
    WHERE customer_id IN (
        SELECT customer_id FROM orders
            WHERE purch_amt > 10);
-- 10
SELECT sum(grade) FROM customers;

-- 11
SELECT * FROM customers
    WHERE cust_name IS NOT NULL;

-- 12
SELECT max(grade) FROM customers;

DROP TABLE customers, salesmen, orders;