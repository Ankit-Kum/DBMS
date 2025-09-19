# window functions 

SQL window functions perform calculations across a set of table rows related 
to the current row. They are distinct from standard aggregate functions 
(like SUM() or AVG()) because they dont collapse the rows into a single output row.
Instead, they produce a result for each row in the original dataset, making 
them ideal for tasks like calculating running totals, rankings, or 
moving averages.

window_function_name(expression) OVER ( 
   [partition_defintion]
   [order_definition]
   [frame_definition]
)

GROUP BY
The GROUP BY clause is for summarizing data. It aggregates rows into a single 
row for each group,making individual details invisible.

Window Function
A window function performs a calculation over a set of rows without collapsing 
them. It adds a new column to each row, allowing you to see both the 
original details and the aggregated result simultaneously.

CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales;

SELECT 
    SUM(sale)
FROM
    sales;


The GROUP BY clause allows you to apply aggregate functions to a subset of rows. 
For example, you may want to calculate the total sales by fiscal years:

SELECT fiscal_year, SUM(sale) FROM sales GROUP BY fiscal_year;

In both examples, the aggregate functions reduce the number of rows returned by the query.

Like the aggregate functions with the GROUP BY clause, window functions 
also operate on a subset of rows 
but they do not reduce the number of rows returned by the query.

SELECT 
    fiscal_year, 
    sales_employee,
    sale,
    SUM(sale) OVER (PARTITION BY fiscal_year) total_sales
FROM
    sales;

Step-by-Step Comparison

Step	            GROUP BY	                                            Window Function
1. Action	        Groups rows and collapses them.	                        Maintains all original rows.
2. Calculation	    Performs an aggregate calculation on each group.	    Performs a calculation over a defined window of rows.
3. Output	        Reduces the number of rows.	                            Does not reduce the number of rows; adds a new column.
4. Use Case	        Summaries and reports.	                                Rankings, running totals, and comparisons.

CREATE TABLE IF NOT EXISTS sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);
 
INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
 
SELECT * FROM sales;

RANK() OVER (
    PARTITION BY <expression>[{,<expression>...}]
    ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)

-- RANK() function to rank the sales employees by sales amount every year:
SELECT
    sales_employee,
    fiscal_year,
    sale,
    RANK() OVER (PARTITION BY
                     fiscal_year
                 ORDER BY
                     sale DESC
                ) sales_rank
FROM
    sales;


-ROW_NUMBER Function
-- OW_NUMBER() function to assign a sequential number to each row from the products table:
SELECT 
  ROW_NUMBER() OVER (
    ORDER BY productName
  ) row_num, 
  productName, 
  msrp 
FROM 
  products 
ORDER BY 
  productName;

-- Removing duplicate rows
CREATE TABLE t (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);

INSERT INTO t(name) 
VALUES('A'),
      ('B'),
      ('B'),
      ('C'),
      ('C'),
      ('C'),
      ('D');
SELECT * FROM t;

SELECT 
  id, 
  name, 
  ROW_NUMBER() OVER (
    PARTITION BY name
    ORDER BY id
  ) AS row_num 
FROM 
  t;

CREATE TABLE employee_sales (
    employee_id INT,
    department VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);

INSERT INTO employee_sales (employee_id, department, sale_date, sales_amount) VALUES
(101, 'Marketing', '2024-01-05', 1500.00),
(102, 'Clothing', '2024-01-06', 750.00),
(101, 'Marketing', '2024-01-07', 2200.00),
(103, 'Books', '2024-01-08', 300.00),
(102, 'Clothing', '2024-01-09', 1200.00),
(101, 'Marketing', '2024-01-10', 900.00);

-- The GROUP BY clause is used to aggregate and summarize data. We will use it to find the total sales for each department.
SELECT
    department,
    SUM(sales_amount) AS total_department_sales
FROM
    employee_sales
GROUP BY
    department;

Explanation:

GROUP BY department tells the database to combine all rows that have the same value in the department column.
SUM(sales_amount) then calculates the total sum of the sales_amount for each of these combined groups.
The output shows only the summary data (department and total sales). You lose the detail of individual transactions.

Result:
| department | total_department_sales |
|--------------|------------------------|
| Electronics  | 4600.00                |
| Clothing     | 1950.00                |
| Books        | 300.00                 |

/*
A window function is used to add context to each row without collapsing them. 
We will use a window function to calculate the running total of sales for each 
employee, ordered by the sale_date.
*/
SELECT
    employee_id,
    department,
    sale_date,
    sales_amount,
    SUM(sales_amount) OVER (PARTITION BY employee_id ORDER BY sale_date) AS running_total
FROM
    employee_sales;

SUM(sales_amount) OVER (...) specifies that SUM() is a window function.
PARTITION BY employee_id divides the data into separate groups for each employee. The running total calculation will restart for each employee.
ORDER BY sale_date sorts the transactions within each employees partition, which is essential for calculating a running total.
The output retains all original rows and adds a new column, running_total, showing the cumulative sales for that employee up to that point.

Result:
| employee_id | department  | sale_date  | sales_amount | running_total |
|-------------|-------------|------------|--------------|---------------|
| 101         | Electronics | 2024-01-05 | 1500.00      | 1500.00       |
| 101         | Electronics | 2024-01-07 | 2200.00      | 3700.00       |
| 101         | Electronics | 2024-01-10 | 900.00       | 4600.00       |
| 102         | Clothing    | 2024-01-06 | 750.00       | 750.00        |
| 102         | Clothing    | 2024-01-09 | 1200.00      | 1950.00       |
| 103         | Books       | 2024-01-08 | 300.00       | 300.00        |

The GROUP BY query produced a summary report with only 3 rows, collapsing the details of individual sales to show the total sales per department. The window function query, on the other hand, produced 6 rows, the same number as the original table, with each row now having the added context of that employees running_total of sales.

CREATE TABLE student_scores (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(50),
    score INT
);

INSERT INTO student_scores (student_id, student_name, subject, score) VALUES
(101, 'Alice', 'Math', 95),
(102, 'Bob', 'Math', 88),
(103, 'Charlie', 'Science', 98),
(104, 'David', 'Science', 91),
(105, 'Eva', 'Math', 95),
(106, 'Frank', 'Science', 98);

Apply the RANK() Window Function

SELECT
    student_name,
    subject,
    score,
    RANK() OVER (PARTITION BY subject ORDER BY score DESC) AS subject_rank
FROM
    student_scores;


FIRST_VALUE Function
FIRST_VALUE (expression) OVER (
   [partition_clause]
   [order_clause]
   [frame_clause]
)

The FIRST_VALUE() is a window function that allows you to select the first row of a window frame, partition, or result set.

CREATE TABLE overtime (
    employee_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hours INT NOT NULL,
    PRIMARY KEY (employee_name , department)
);
INSERT INTO overtime(employee_name, department, hours)
VALUES('Diane Murphy','Accounting',37),
('Mary Patterson','Accounting',74),
('Jeff Firrelli','Accounting',40),
('William Patterson','Finance',58),
('Gerard Bondur','Finance',47),
('Anthony Bow','Finance',66),
('Leslie Jennings','IT',90),
('Leslie Thompson','IT',88),
('Julie Firrelli','Sales',81),
('Steve Patterson','Sales',29),
('Foon Yue Tseng','Sales',65),
('George Vanauf','Marketing',89),
('Loui Bondur','Marketing',49),
('Gerard Hernandez','Marketing',66),
('Pamela Castillo','SCM',96),
('Larry Bott','SCM',100),
('Barry Jones','SCM',65);


The following statement gets the employee’s name, overtime, and the employee who has the least overtime:
SELECT
    employee_name,
    hours,
    FIRST_VALUE(employee_name) OVER (
        ORDER BY hours
    ) least_over_time
FROM
    overtime;

The following statement finds the employee who has the least overtime in every department:

SELECT
    employee_name,
    department,
    hours,
    FIRST_VALUE(employee_name) OVER (
        PARTITION BY department
        ORDER BY hours
    ) least_over_time
FROM
    overtime;

Rule of Thumb

Can you live without the individual rows? If the answer is "yes," use GROUP BY. 
For example, "What is the total salary per department?" 
The individual salaries are not needed in the final report.

Do you need to see the individual rows AND a calculation based on a group? 
If the answer is "yes," use a window function. 
For example, "Show each employee's salary and their salary's rank within their department." 
You need to see both the individual salary and the group-based rank.