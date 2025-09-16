
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Products VALUES
(101, 'Laptop', 75000, 5),
(102, 'Phone', 35000, 10),
(103, 'Headphones', 2000, 0);

INSERT INTO Employees VALUES
(1, 'Alice', 60000),
(2, 'Bob', 90000),
(3, 'Charlie', 35000);

INSERT INTO Customers VALUES
(201, 'Rahul'),
(202, 'Sneha');

DELIMITER //
CREATE PROCEDURE SumAndProduct(IN a INT, IN b INT, OUT s INT, OUT p INT)
BEGIN
    SET s = a + b;
    SET p = a * b;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetProductInfo(IN pid INT, OUT pname VARCHAR(50), OUT pprice DECIMAL(10,2))
BEGIN
    SELECT product_name, price
    INTO pname, pprice
    FROM Products
    WHERE product_id = pid;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PromoteEmployee(IN eid INT, IN percent DECIMAL(5,2), OUT old_salary DECIMAL(10,2), OUT new_salary DECIMAL(10,2))
BEGIN
    SELECT salary INTO old_salary FROM Employees WHERE emp_id = eid;
    SET new_salary = old_salary + (old_salary * percent / 100);
    UPDATE Employees SET salary = new_salary WHERE emp_id = eid;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PlaceOrder(IN cid INT, IN amt DECIMAL(10,2), OUT oid INT)
BEGIN
    INSERT INTO Orders(customer_id, order_amount) VALUES (cid, amt);
    SET oid = LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CheckAge(IN age INT, OUT result VARCHAR(20))
BEGIN
    IF age >= 18 THEN
        SET result = 'Adult';
    ELSE
        SET result = 'Not an Adult';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ClassifySalary(IN eid INT, OUT category VARCHAR(20))
BEGIN
    DECLARE sal DECIMAL(10,2);
    SELECT salary INTO sal FROM Employees WHERE emp_id = eid;

    CASE
        WHEN sal > 80000 THEN SET category = 'High Salary';
        WHEN sal >= 40000 THEN SET category = 'Medium Salary';
        ELSE SET category = 'Low Salary';
    END CASE;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CheckStock(IN pid INT, OUT status VARCHAR(20))
BEGIN
    DECLARE st INT;
    SELECT stock INTO st FROM Products WHERE product_id = pid;

    IF st > 0 THEN
        SET status = 'In Stock';
    ELSE
        SET status = 'Out of Stock';
    END IF;
END //
DELIMITER ;
