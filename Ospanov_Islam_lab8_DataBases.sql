CREATE DATABASE lab8;

CREATE TABLE departments
    AS SELECT id,
          10 * (3 + round(random() * 5)) AS department_id,
          round(random() * 1000) AS budget
    FROM generate_Series(1,10000) id;

CREATE TABLE customers
    AS SELECT id,
          substr(md5(random()::text), 0, 7) AS name,
          substr(md5(random()::text), 0, 7) AS city,
          10 * (3 + round(random() * 5)) AS department_id
    FROM generate_Series(1,10000) id;

SELECT * FROM customers;
SELECT * FROM departments;

DROP TABLE customers, departments;

DROP DATABASE lab8;

-- 1
CREATE INDEX idx_customers_city
    ON customers USING HASH (city);

EXPLAIN ANALYSE SELECT * FROM customers
    WHERE city = 'd9f3ea';

DROP INDEX idx_customers_city;

-- 2
CREATE INDEX idx_customers_name_and_city
    ON customers (name, city);

EXPLAIN ANALYSE SELECT * FROM customers
    WHERE name = '91bd5d'
          AND city = 'a59aa8';

DROP INDEX idx_customers_name_and_city;

-- 3
CREATE UNIQUE INDEX idx_customers_id
    ON customers (id);

EXPLAIN ANALYSE SELECT * FROM customers
    WHERE id < 3000
          AND id > 2000;

DROP INDEX idx_customers_id;

-- 4
CREATE INDEX idx_customers_substr_name
    ON customers (substring(name from 1 for 4));

EXPLAIN ANALYSE SELECT * FROM customers
    WHERE substring(name from 1 for 4) = 'abcd';

DROP INDEX idx_customers_substr_name;

-- 5
CREATE INDEX idx_customers_department_id_hash
    ON customers USING hash (department_id);

CREATE INDEX idx_customers_id
    ON customers (id);

CREATE INDEX idx_departments_budget
    ON departments (budget);

EXPLAIN ANALYSE SELECT * FROM customers c
    JOIN departments d USING (department_id)
    WHERE c.id > 100 AND d.budget < 500;

DROP INDEX idx_customers_id, idx_departments_budget, idx_customers_department_id_hash;

-- 6
ALTER TABLE customers
    ADD COLUMN points point;

EXPLAIN ANALYZE SELECT * FROM customers
    WHERE points IS NULL;

CREATE INDEX idx_customers_points_rtree
    ON customers USING gist (points);

DROP INDEX idx_customers_points_rtree;

-- 7
CREATE INDEX idx_customers_city_hash
    ON customers USING HASH (city);

EXPLAIN ANALYSE SELECT * FROM customers
    WHERE city = 'd9f3ea';

DROP INDEX idx_customers_city_hash;

-- 8
CREATE UNIQUE INDEX idx_customers_id
    ON customers (id);

EXPLAIN SELECT * FROM customers
    WHERE id < 3007
          AND id > 2002;

DROP INDEX idx_customers_id;

-- check
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'customers';