-- ==========================
-- Q1: Customer Loyalty Program
-- ==========================
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    total_purchases DECIMAL(10,2),
    loyalty_points INT DEFAULT 0
);

INSERT INTO customers VALUES
(1, 'Alice', 250.00, 0),
(2, 'Bob', 120.00, 0),
(3, 'Charlie', 580.00, 0);

DELIMITER //
CREATE PROCEDURE UpdateLoyaltyPoints()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE c_id INT;
    DECLARE c_total DECIMAL(10,2);
    DECLARE cur CURSOR FOR SELECT customer_id, total_purchases FROM customers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO c_id, c_total;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        UPDATE customers
        SET loyalty_points = FLOOR(c_total / 100)
        WHERE customer_id = c_id;
    END LOOP;
    CLOSE cur;
END//
DELIMITER ;

-- ==========================
-- Q2: Raise Salaries for 3 Lowest Paid Employees
-- ==========================
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees VALUES
(1, 'David', 30000),
(2, 'Eva', 25000),
(3, 'Frank', 28000),
(4, 'Grace', 40000),
(5, 'Hank', 35000);

DELIMITER //
CREATE PROCEDURE RaiseLowestSalaries()
BEGIN
    DECLARE counter INT DEFAULT 0;
    WHILE counter < 3 DO
        UPDATE employees
        SET salary = salary * 1.05
        WHERE emp_id = (
            SELECT emp_id FROM employees ORDER BY salary ASC LIMIT 1
        );
        SET counter = counter + 1;
    END WHILE;
END//
DELIMITER ;

-- CALL RaiseLowestSalaries();
-- SELECT * FROM employees;


-- ==========================
-- Q3: AFTER INSERT Trigger (Orders – Inventory Update)
-- ==========================
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock_quantity INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity_ordered INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products VALUES
(1, 'Laptop', 50),
(2, 'Mouse', 100);

DELIMITER //
CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity_ordered
    WHERE product_id = NEW.product_id;
END//
DELIMITER ;

-- ==========================
-- Q4: BEFORE INSERT Trigger (Price Validation)
-- ==========================
ALTER TABLE products ADD price DECIMAL(10,2) DEFAULT 0;

DELIMITER //
CREATE TRIGGER ValidatePriceBeforeInsert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SET NEW.price = 0;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Negative price detected, set to 0';
    END IF;
END//
DELIMITER ;

-- INSERT INTO products(product_id, product_name, stock_quantity, price) VALUES (3, 'Keyboard', 20, -100);
-- SELECT * FROM products;


-- ==========================
-- Q5: Function Calculate Area
-- ==========================
DELIMITER //
CREATE FUNCTION calculate_area(length DECIMAL(10,2), width DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN length * width;
END//
DELIMITER ;


-- ==========================
-- Q6: Function is_even
-- ==========================
DELIMITER //
CREATE FUNCTION is_even(num INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    RETURN IF(num % 2 = 0, 'Even', 'Odd');
END//
DELIMITER ;


-- SELF-PLACED: GetReorderStatus Function
-- ==========================
DROP FUNCTION IF EXISTS GetReorderStatus;
DELIMITER //
CREATE FUNCTION GetReorderStatus(current_stock INT, reorder_threshold INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE status_text VARCHAR(10);
    IF current_stock <= reorder_threshold THEN
        SET status_text = 'REORDER';
    ELSE
        SET status_text = 'OK';
    END IF;
    RETURN status_text;
END//
DELIMITER ;

-- SELECT product_name, stock_quantity, GetReorderStatus(stock_quantity, 50) AS reorder_status FROM products;


-- ==========================
-- SELF-PLACED: CalculateBonus Function
-- ==========================
DROP FUNCTION IF EXISTS CalculateBonus;
DELIMITER //
CREATE FUNCTION CalculateBonus(emp_salary DECIMAL(10,2), years_of_service INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus_rate DECIMAL(5,2);
    DECLARE bonus_amount DECIMAL(10,2);
    IF years_of_service > 15 THEN
        SET bonus_rate = 0.15;
    ELSE
        SET bonus_rate = years_of_service / 100;
    END IF;
    SET bonus_amount = emp_salary * bonus_rate;
    RETURN bonus_amount;
END//
DELIMITER ;

