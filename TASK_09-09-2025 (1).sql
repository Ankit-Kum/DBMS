
-- Q1: Create Student Table
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age BETWEEN 18 AND 30),
    City VARCHAR(50) DEFAULT 'Delhi'
);

-- Insert sample valid students
INSERT INTO Students (StudentID, Name, Age, City) VALUES (1, 'Rohit', 22, DEFAULT);
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Priya', 25);
INSERT INTO Students (StudentID, Name, Age, City) VALUES (3, 'Amit', 19, 'Lucknow');

-- Q2: Insert Data with Default (already shown in valid inserts above)
INSERT INTO Students (StudentID, Name, Age) VALUES (4, 'Neha', 23);

-- Q3: Create Employee Table with Salary Validation
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 5000),
    Department VARCHAR(50) DEFAULT 'HR'
);

-- Insert sample valid employees
INSERT INTO Employees (EmpID, EmpName, Salary) VALUES (1, 'Anita', 6000);
INSERT INTO Employees (EmpID, EmpName, Salary, Department) VALUES (2, 'Rakesh', 8000, 'Finance');
INSERT INTO Employees (EmpID, EmpName, Salary) VALUES (3, 'Sunita', 7500);

-- Q4: Insert Invalid Salary (will fail)
INSERT INTO Employees (EmpID, EmpName, Salary) VALUES (4, 'TestFail', 4000);

-- Q5: Product Table with Stock Constraint
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) DEFAULT 100,
    Stock INT CHECK (Stock >= 0)
);

-- Insert sample valid products
INSERT INTO Products (ProductID, ProductName, Stock) VALUES (1, 'Pen', 50);
INSERT INTO Products (ProductID, ProductName, Price, Stock) VALUES (2, 'Notebook', 150, 30);
INSERT INTO Products (ProductID, ProductName, Stock) VALUES (3, 'Eraser', 20);

-- Q6: Insert with Constraint Violation (will fail)
INSERT INTO Products (ProductID, ProductName, Stock) VALUES (4, 'InvalidItem', -10);

-- Q7: Update Products with Default Price where NULL
UPDATE Products SET Price = 100 WHERE Price IS NULL;

-- Q8: Delete Student with Age 25
DELETE FROM Students WHERE Age = 25;

-- Q9: Update Violating CHECK Constraint (will fail)
UPDATE Employees SET Salary = 2000 WHERE EmpID = 1;

-- Q10: Insert Into NOT NULL Column (will fail)
INSERT INTO Students (StudentID, Age) VALUES (5, 21);

-- Q11: Set Employee Department to Default
UPDATE Employees SET Department = DEFAULT;

-- Q12: Delete All Products with Default Price
DELETE FROM Products WHERE Price = 100;

-- Q13: Create Orders Table with Multi-Column CHECK
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    Discount DECIMAL(10,2),
    CustomerName VARCHAR(50) NOT NULL,
    CHECK (Discount < Amount)
);

-- Insert sample valid orders
INSERT INTO Orders (OrderID, Amount, Discount, CustomerName) VALUES (1, 500, 50, 'Rahul');
INSERT INTO Orders (OrderID, Amount, Discount, CustomerName) VALUES (2, 1000, 200, 'Seema');
INSERT INTO Orders (OrderID, Amount, Discount, CustomerName) VALUES (3, 750, 100, 'Manish');
