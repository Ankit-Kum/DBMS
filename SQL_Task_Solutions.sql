

-- Part 1: Employee Salary Analysis

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(50)
);
CREATE TABLE employees (
employee_id INT PRIMARY KEY,
name VARCHAR(100),
salary INT,
department_id INT,
manager_id INT,
hire_date DATE,
FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Marketing');
INSERT INTO employees VALUES
(1, 'Emma Thompson', 3800, 1, 6, '2018-05-14'),
(2, 'Daniel Rodriguez', 2230, 1, 7, '2019-07-01'),
(3, 'Olivia Smith', 2000, 1, 8, '2020-03-22'),
(4, 'John Smith', 7500, 2, NULL, '2015-04-12'),
(5, 'Jane Doe', 6400, 2, 4, '2017-09-10'),
(6, 'Michael Brown', 5000, 3, 4, '2016-01-25'),
(7, 'Sophia Johnson', 6100, 3, 6, '2021-11-19'),
(8, 'Liam Wilson', 4500, 4, 6, '2019-12-03');

-- Q1: Employees with salary > average of their department

SELECT e.name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id
);

-- Q2: Departments with ≥1 employee earning > 60,000

SELECT DISTINCT d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 60000;

-- Q3: Employees managed by 'John Smith'

SELECT e.name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE m.name = 'John Smith';

-- Q4: Top 3 highest-paid employees

SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Q5: Employees with same job title as Jane Doe

ALTER TABLE employees ADD job_title VARCHAR(50);
UPDATE employees SET job_title = 'HR Manager' WHERE name = 'Jane Doe';
UPDATE employees SET job_title = 'HR Manager' WHERE name = 'John Smith';
UPDATE employees SET job_title = 'Developer' WHERE name IN ('Emma
Thompson','Daniel Rodriguez','Olivia Smith');
UPDATE employees SET job_title = 'Sales Executive' WHERE name = 'Michael
Brown';
UPDATE employees SET job_title = 'Sales Executive' WHERE name = 'Sophia
Johnson';
UPDATE employees SET job_title = 'Marketing Lead' WHERE name = 'Liam
Wilson';
SELECT name
FROM employees
WHERE job_title = (
SELECT job_title
FROM employees
WHERE name = 'Jane Doe'
);

-- Q6: Employees hired before company’s average hire date

SELECT name, hire_date
FROM employees
WHERE hire_date < (
SELECT AVG(hire_date)
FROM employees
);

-- Part 2: Views

-- Q1: View of employees earning > company average

CREATE VIEW high_salary_employees AS
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
SELECT * FROM high_salary_employees;

-- Q2: View for each department’s highest-paid employee

CREATE VIEW highest_paid_department AS
SELECT e.*
FROM employees e
WHERE e.salary = (
SELECT MAX(salary)
FROM employees
WHERE department_id = e.department_id
);
SELECT name
FROM highest_paid_department
WHERE department_id = (SELECT department_id FROM departments WHERE
department_name = 'IT');

-- Q3: View for Sales & Marketing employees → find average salary

CREATE VIEW sales_marketing_employees AS
SELECT *
FROM employees
WHERE department_id IN (
SELECT department_id FROM departments WHERE department_name IN
('Sales','Marketing')
);
SELECT AVG(salary) AS avg_salary
FROM sales_marketing_employees;

-- Part 3: Second Highest Salary

SELECT DISTINCT salary AS second_highest_salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Part 4: Activation Rate
CREATE TABLE emails (
email_id INT PRIMARY KEY,
user_id INT,
signup_date DATETIME
);
CREATE TABLE texts (
text_id INT PRIMARY KEY,
email_id INT,
signup_action VARCHAR(20)
);
INSERT INTO emails VALUES
(125, 7771, '2022-06-14 00:00:00'),
(236, 6950, '2022-07-01 00:00:00'),
(433, 1052, '2022-07-09 00:00:00');
INSERT INTO texts VALUES
(6878, 125, 'Confirmed'),
(6920, 236, 'Not Confirmed'),
(6994, 236, 'Confirmed');
SELECT ROUND(
CAST(COUNT(DISTINCT CASE WHEN t.signup_action = 'Confirmed' THEN
e.email_id END) AS DECIMAL)
/ COUNT(DISTINCT e.email_id), 2) AS confirm_rate
FROM emails e
LEFT JOIN texts t ON e.email_id = t.email_id;
