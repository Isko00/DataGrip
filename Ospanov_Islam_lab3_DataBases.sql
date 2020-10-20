create database laboratory_work3;

CREATE TABLE departments (
  code INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  budget DECIMAL NOT NULL
);

CREATE TABLE employees (
  ssn INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  lastname VARCHAR(255) NOT NULL ,
  department INTEGER NOT NULL ,
  city VARCHAR(255),
  FOREIGN KEY (department) REFERENCES departments(code)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  lastname VARCHAR(255) NOT NULL ,
  city VARCHAR(255)
);

INSERT INTO departments(code,name,budget) VALUES(14,'IT',65000);
INSERT INTO departments(code,name,budget) VALUES(37,'Accounting',15000);
INSERT INTO departments(code,name,budget) VALUES(59,'Human Resources',240000);
INSERT INTO departments(code,name,budget) VALUES(77,'Research',55000);
INSERT INTO departments(code,name,budget) VALUES(45,'Management',155000);
INSERT INTO departments(code,name,budget) VALUES(11,'Sales',85000);

INSERT INTO employees(ssn,name,lastname,department, city) VALUES('123234877','Michael','Rogers',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('152934485','Anand','Manikutty',14, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('222364883','Carol','Smith',37, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('326587417','Joe','Stevens',37, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332154719','Mary-Anne','Foster',14, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332569843','George','ODonnell',77, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('546523478','John','Doe',59, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('631231482','David','Smith',77, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('654873219','Zacary','Efron',59, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('745685214','Eric','Goldsmith',59, 'Atyrau');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657245','Elizabeth','Doe',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657246','Kumar','Swamy',14, 'Almaty');



INSERT INTO customers(name,lastname, city) VALUES('John','Wills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Garry','Foster', 'London');
INSERT INTO customers(name,lastname, city) VALUES('Amanda','Hills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('George','Doe', 'Tokyo');
INSERT INTO customers(name,lastname, city) VALUES('David','Little', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Shawn','Efron', 'Astana');
INSERT INTO customers(name,lastname, city) VALUES('Eric','Gomez', 'Shymkent');
INSERT INTO customers(name,lastname, city) VALUES('Elizabeth','Tailor', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Julia','Adams', 'Astana');

-- Practical part

select * from departments;
select * from employees;
select * from customers;

DROP TABLE departments, employees, customers;
DROP DATABASE laboratory_work3;

-- task1
SELECT code, name FROM departments
    ORDER BY budget DESC OFFSET 1 LIMIT 1;

-- task2
UPDATE departments
    SET budget = budget * 0.85
    WHERE budget
        = (SELECT MIN(budget) FROM departments)
    RETURNING *;

-- 3
select name from employees;

-- 4
select distinct lastname from employees;

-- 5
SELECT * FROM employees
    where lastname = 'Smith';

-- 6
SELECT * FROM employees
    where lastname = 'Smith'
        or lastname = 'Doe';

-- 7
SELECT * FROM employees
    where department = 59;

-- 8
SELECT * FROM employees
    where department = 14
        or department = 77;

-- 8.5
SELECT * FROM employees
    where city = 'Almaty';

-- 9
SELECT SUM (budget) AS sum
    FROM departments;

-- 10
SELECT department,
	COUNT (department)
    FROM employees
        GROUP BY department;

-- 11
SELECT department,
	    COUNT (department)
    FROM employees
    GROUP BY department
    HAVING COUNT (department) > 2;

-- 12
SELECT name FROM departments
    ORDER BY budget DESC OFFSET 1 LIMIT 1;

-- 13
SELECT name, lastname FROM employees
WHERE department = (
       SELECT code FROM departments
            ORDER BY budget DESC LIMIT 1)
    OR department = (
       SELECT code FROM departments
            ORDER BY budget LIMIT 1);

-- 14
SELECT employees.name
    FROM employees
    WHERE employees.city = 'Astana'
UNION ALL
SELECT customers.name
    FROM customers
    WHERE customers.city = 'Astana';

-- 15
SELECT * from departments
    WHERE budget > 55000
    ORDER BY budget,
             code DESC;

-- 16
UPDATE departments
    SET budget = budget * 0.82
    WHERE budget = (SELECT MIN (budget) FROM departments);

-- 17
UPDATE employees
    SET department =
        (SELECT code FROM departments
            WHERE name = 'IT')
    WHERE department =
        (SELECT code FROM departments
            WHERE name = 'Research');

-- 18
DELETE FROM employees
    WHERE department =
        (SELECT code FROM departments
            WHERE name = 'IT');

-- 19
-- noinspection SqlWithoutWhere

DELETE FROM employees;