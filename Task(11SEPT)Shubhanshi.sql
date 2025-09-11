/*
Q1: Total number of orders placed by each customer
=====================================================*/
CREATE DATABASE IF NOT EXISTS practice_db;
USE practice_db;
CREATE TABLE Orders (
    order_id INT,
    customer_id INT
);
INSERT INTO Orders VALUES
(1, 101), (2, 101), (3, 102), (4, 103), (5, 101);
-- Solution
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;


/*=====================================================
Q2: Average salary of employees in each department
=====================================================*/
CREATE TABLE Employees (
    employee_id INT,
    department_id INT,
    salary DECIMAL(10,2)
);
INSERT INTO Employees VALUES
(1, 10, 50000),
(2, 10, 60000),
(3, 20, 70000),
(4, 20, 80000),
(5, 30, 40000);
-- Solution
SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;


/*=====================================================
Q3: Total sales amount by each employee for 2024
=====================================================*/
CREATE TABLE Sales (
    employee_id INT,
    sale_date DATE,
    amount DECIMAL(10,2)
);
INSERT INTO Sales VALUES
(1, '2024-01-10', 500),
(1, '2024-02-15', 700),
(2, '2024-03-20', 800),
(2, '2023-12-25', 600);
-- Solution
SELECT employee_id, SUM(amount) AS total_sales
FROM Sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY employee_id;



/*=====================================================
Q4: Three most common order statuses with counts
=====================================================*/
CREATE TABLE Orders_Status (
    order_id INT,
    order_status VARCHAR(50)
);
INSERT INTO Orders_Status VALUES
(1, 'Shipped'),
(2, 'Pending'),
(3, 'Shipped'),
(4, 'Cancelled'),
(5, 'Shipped'),
(6, 'Pending');
-- Solution
SELECT order_status, COUNT(*) AS status_count
FROM Orders_Status
GROUP BY order_status
ORDER BY status_count DESC
LIMIT 3;


/*=====================================================
Q5: Departments where average salary > 50000
=====================================================*/
-- Using Employees table from Q2

-- Solution
SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 50000;


/*=====================================================
Q6: Maximum price of a product in each category
=====================================================*/
CREATE TABLE Products (
    product_id INT,
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO Products VALUES
(1, 'Electronics', 800.00),
(2, 'Books', 25.50),
(3, 'Electronics', 1200.00),
(4, 'Books', 50.00),
(5, 'Home', 150.75);
-- Solution
SELECT category, MAX(price) AS max_price
FROM Products
GROUP BY category;


/*=====================================================
Q7: Total marks obtained by students in each class
=====================================================*/
CREATE TABLE Students (
    student_id INT,
    class VARCHAR(20),
    marks INT
);
INSERT INTO Students VALUES
(101, '10A', 85),
(102, '10A', 92),
(103, '11B', 78),
(104, '11B', 95),
(105, '10A', 88);
-- Solution
SELECT class, SUM(marks) AS total_marks
FROM Students
GROUP BY class;


/*=====================================================
Q8: Count of employees in each department earning > 60000
=====================================================*/
-- Using Employees table from Q2

-- Solution
SELECT department_id, COUNT(*) AS employee_count
FROM Employees
WHERE salary > 60000
GROUP BY department_id;


/*=====================================================
Q9: Customers who placed more than 5 orders in 2024
=====================================================*/
CREATE TABLE Orders_Full (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);
INSERT INTO Orders_Full VALUES
(1, 10, '2024-01-15', 150.00),
(2, 10, '2024-02-20', 250.00),
(3, 20, '2024-01-10', 100.00),
(4, 10, '2024-03-05', 300.00),
(5, 10, '2024-04-10', 50.00),
(6, 30, '2023-12-25', 120.00),
(7, 10, '2024-05-15', 450.00),
(8, 20, '2024-03-12', 220.00),
(9, 10, '2024-06-01', 180.00),
(10, 20, '2024-04-18', 75.00),
(11, 10, '2024-07-07', 600.00);
-- Solution
SELECT customer_id, COUNT(order_id) AS order_count
FROM Orders_Full
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY customer_id
HAVING COUNT(order_id) > 5;



/*=====================================================
Q10: Candidates proficient in Python, Tableau, and PostgreSQL
=====================================================*/
CREATE TABLE candidates (
    candidate_id INT,
    skill VARCHAR(50)
);
INSERT INTO candidates VALUES
(123, 'Python'),
(123, 'Tableau'),
(123, 'PostgreSQL'),
(234, 'R'),
(234, 'PowerBI'),
(234, 'SQL Server'),
(345, 'Python'),
(345, 'Tableau');
-- Solution
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id;


/*=====================================================
Q11: Top three cities with highest number of completed trade orders
=====================================================*/
CREATE TABLE trades (
    order_id INT,
    user_id INT,
    quantity INT,
    status VARCHAR(50),
    date TIMESTAMP,
    price DECIMAL(10,2)
);

CREATE TABLE users (
    user_id INT,
    city VARCHAR(50),
    email VARCHAR(100),
    signup_date DATETIME
);
INSERT INTO trades VALUES
(100101, 111, 10, 'Cancelled', '2022-08-17 12:00:00', 9.80),
(100102, 111, 10, 'Completed', '2022-08-17 12:00:00', 10.00),
(100259, 148, 35, 'Completed', '2022-08-25 12:00:00', 5.10),
(100264, 148, 40, 'Completed', '2022-08-26 12:00:00', 4.80),
(100305, 300, 15, 'Completed', '2022-09-05 12:00:00', 10.00),
(100400, 178, 32, 'Completed', '2022-09-17 12:00:00', 12.00),
(100565, 265, 2, 'Completed', '2022-09-27 12:00:00', 8.70);

INSERT INTO users VALUES
(111, 'San Francisco', 'rrok10@gmail.com', '2021-08-03 12:00:00'),
(148, 'Boston', 'sailor9820@gmail.com', '2021-08-20 12:00:00'),
(178, 'San Francisco', 'harrypotterfan182@gmail.com', '2022-01-05 12:00:00'),
(265, 'Denver', 'shadower_@hotmail.com', '2022-02-26 12:00:00'),
(300, 'San Francisco', 'houstoncowboy1122@hotmail.com', '2022-06-30 12:00:00');
-- Solution
SELECT u.city, COUNT(t.order_id) AS total_orders
FROM trades t
JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3;
