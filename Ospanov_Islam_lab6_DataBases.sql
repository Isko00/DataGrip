-- 1
create database lab6;

-- 2
CREATE TABLE locations (
  location_id SERIAL PRIMARY KEY,
  street_address VARCHAR(25),
  postal_code VARCHAR(12),
  city VARCHAR(30),
  state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

-- 3
INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
    ('Abai','QWERASDFZXCV', 'Almaty', 'Zhambyl'),
    ('Peace','TYUIGHJKBNMZ', 'Shymkent', 'Turkestan'),
    ('Astana','REWQFDSAVCXZ', 'Nursultan', 'Akmola'),
    ('Konayev','QAZWSXEDCRFV', 'Kyzylorda', 'Kyzylorda'),
    ('Askarov','POIULKJHMNBV', 'Shymkent', 'Turkestan');

INSERT INTO departments (department_id, department_name, budget, location_id) VALUES
    (40, 'first', 15000, 1),
    (50, 'second', 2300, 3),
    (60, 'third', 54200, 1),
    (70, 'forth', 12340, 4),
    (80, 'fifth', 990, 5);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
    ('Islam','Ospanov', 'Ospanov_I@kbtu.kz', '87476792855', 54200, 60),
    ('Vlad','Lee', 'Li_V@kbtu.kz', '87476230142', 90, 80),
    ('Aba','Makhmut', 'Makhmut_A@kbtu.kz', '87475361093', 300, 50),
    ('Alish','Kambar', 'Kambar_A@kbtu.kz', '87479302501', 1500, 40),
    ('Aldyar','Adelov', 'Adelov_A@kbtu.kz', '87452602938', 900, null);

SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM employees;

DROP TABLE employees;
DROP TABLE departments;
DROP TABLE locations;

DROP DATABASE lab6;

-- 4
SELECT first_name, last_name, e.department_id, d.department_name FROM employees e
    INNER JOIN departments d USING (department_id);

-- 5
SELECT first_name, last_name, e.department_id, d.department_name FROM employees e
    INNER JOIN departments d USING (department_id)
    WHERE e.department_id IN (40, 80);

-- 6
SELECT first_name, last_name, e.department_id, l.city, l.state_province FROM employees e
    INNER JOIN departments d USING (department_id)
    INNER JOIN locations l USING (location_id);

-- 7
SELECT DISTINCT d.department_id FROM employees e
    RIGHT JOIN departments d USING(department_id)
    ORDER BY d.department_id;

-- 8
SELECT first_name, last_name, COALESCE(e.department_id, 0) AS department_id,
            COALESCE(d.department_name, 'no name') AS department_name FROM employees e
    LEFT JOIN departments d USING (department_id);

-- 9
SELECT first_name, last_name FROM employees e
    INNER JOIN departments d USING (department_id)
    INNER JOIN locations l USING (location_id)
    WHERE l.city = 'Almaty';
