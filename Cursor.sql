Cursors in Stored Procedures 
A cursor is a control structure that enables row-by-row processing of a result set. 
When writing stored procedures, you typically use a cursor in three main steps:
Declare, Open, and Fetch, and finally Close.

A database cursor is a control structure that enables traversal 
over the records in a database. It acts as a pointer to a 
specific row within a result set, allowing you to process 
data one row at a time instead of all at once. 
Cursors are typically used in stored procedures, functions, 
and triggers to handle row-by-row logic.

    DECLARE CURSOR: This statement defines the cursor and associates it with a SELECT query.
    OPEN CURSOR: This statement executes the query and populates the result set.
    FETCH: This statement retrieves a single row from the result set into local variables.
    CLOSE CURSOR: This statement releases the resources associated with the cursor.

-- declare a cursor
DECLARE cursor_name CURSOR FOR 
SELECT column1, column2 
FROM your_table 
WHERE your_condition;

-- open the cursor
OPEN cursor_name;

FETCH cursor_name INTO variable1, variable2;
-- process the data


-- close the cursor
CLOSE cursor_name;


Example Use Case:
Imagine you have a table of employees and need to calculate and
update a bonus for each one. The bonus amount is based on various 
factors, like a different commission rate for each department,
and you need to log the result of each calculation. This kind 
of row-by-row processing is a perfect use case for a cursor.

DELIMITER $$

CREATE PROCEDURE CalculateAndLogBonuses()
BEGIN
    -- 1. Declare variables to hold the data from each row
    DECLARE employee_id INT;
    DECLARE employee_salary DECIMAL(10, 2);
    DECLARE done INT DEFAULT 0;

    -- 2. Declare the cursor
    DECLARE employee_cursor CURSOR FOR
        SELECT id, salary
        FROM employees
        WHERE department = 'Sales';

    -- Declare continue handler for 'NOT FOUND' (end of data)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 3. Open the cursor
    OPEN employee_cursor;

    -- Start the loop
    read_loop: LOOP
        -- 4. Fetch the next row into variables
        FETCH employee_cursor INTO employee_id, employee_salary;

        -- Exit the loop if no more rows are found
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Process the data (e.g., calculate a bonus and update)
        UPDATE employees
        SET bonus = employee_salary * 0.15
        WHERE id = employee_id;

        -- You can also log this action here
        -- INSERT INTO logs (message) VALUES (CONCAT('Updated bonus for employee ID: ', employee_id));

    END LOOP;

    -- 5. Close the cursor
    CLOSE employee_cursor;

END$$

DELIMITER ;

-- To run the procedure:
-- CALL CalculateAndLogBonuses();


Migrating Data Between Tables
This procedure uses a cursor to read data from an old 
products table and insert it into a new, more normalized 
new_products table. This is a common task during database 
schema migrations.

DELIMITER $$

CREATE PROCEDURE MigrateProductData()
BEGIN
    DECLARE old_product_id INT;
    DECLARE old_product_name VARCHAR(255);
    DECLARE old_price DECIMAL(10, 2);
    DECLARE done INT DEFAULT 0;

    -- Declare cursor for the old products table
    DECLARE product_cursor CURSOR FOR
        SELECT id, name, price
        FROM products;

    -- Declare handler for end of data
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN product_cursor;

    read_loop: LOOP
        FETCH product_cursor INTO old_product_id, old_product_name, old_price;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert the data into the new table
        INSERT INTO new_products (product_id, product_name, unit_price)
        VALUES (old_product_id, old_product_name, old_price);

    END LOOP;

    CLOSE product_cursor;
    
    SELECT 'Product migration complete.' AS Message;

END$$

DELIMITER ;


# Example 2: Sending Personalized Notifications
In this example, a stored procedure uses a cursor to
 retrieve each users email and generate a personalized message.
  While this is a simplified example, in a real-world scenario,
   the loop could contain logic to call an external API to send
    emails or push notifications.

DELIMITER $$

CREATE PROCEDURE SendEmailNotifications()
BEGIN
    DECLARE user_email VARCHAR(255);
    DECLARE user_name VARCHAR(100);
    DECLARE message_content TEXT;
    DECLARE done INT DEFAULT 0;

    -- Declare cursor to get user emails and names
    DECLARE user_cursor CURSOR FOR
        SELECT email, name
        FROM users
        WHERE is_subscribed = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN user_cursor;

    read_loop: LOOP
        FETCH user_cursor INTO user_email, user_name;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Construct a personalized message (this part would be more complex in reality)
        SET message_content = CONCAT('Hello ', user_name, ', your weekly report is ready. Please log in to view it.');
        
        -- In a real application, you would add logic here to send the email
        -- e.g., INSERT into an email queue table or call a function to send it.
        SELECT CONCAT('Sending to ', user_email, ': ', message_content) AS 'Debug_Output';

    END LOOP;

    CLOSE user_cursor;

    SELECT 'All notifications processed.' AS 'Status';

END$$

DELIMITER ;

This procedure demonstrates the row-by-row processing 
nature of cursors, where each row is handled individually
to perform a specific, often personalized, action.


Types of Cursors in MySQL

MySQL cursors are all a specific type, so the distinctions you asked about are not directly implemented with different keywords. 
MySQL only supports non-scrollable, asensitive, 
and read-only cursors.

Read-Only Cursor
A read-only cursor is a cursor that cannot be used to modify the underlying data.
 You can only use it to fetch data, not to perform positioned UPDATE or DELETE 
 statements. This type of cursor is often a performance optimization because the 
 database doesnt need to maintain locks on the rows for potential modification, 
 allowing for less stringent locking.    
Asensitive Cursor

DECLARE ro_cursor CURSOR FOR
    SELECT order_id, customer_name FROM orders FOR READ ONLY;
OPEN ro_cursor;

The FOR READ ONLY clause explicitly declares the cursor as read-only. 
Attempting to use a POSITIONED UPDATE or DELETE statement with this cursor
 will result in an error.


/*
An asensitive cursor doesn't guarantee sensitivity to changes in the 
underlying data. This means the database may or may not create a temporary
copy of the data when the cursor is opened. 
The behavior depends on the database engine's optimization.
*/

DECLARE asens_cursor ASENSITIVE CURSOR FOR
    SELECT emp_id, emp_name FROM employees WHERE dept_id = 101;
OPEN asens_cursor;

In this example, the asens_cursor is declared as ASENSITIVE. 
The database might create a temporary copy of the data, 
so it wont see any changes to the employees table, 
or it might work on the live data, showing all committed changes. 
The behavior is left to the databases discretion.

Insensitive Cursor

An insensitive cursor creates a temporary, static copy of the result set. 
It is "insensitive" to any changes made to the base tables after the cursor is 
opened. This provides a consistent view of the data, but it may not be up-to-date..

DECLARE insens_cursor INSENSITIVE CURSOR FOR
    SELECT product_name, price FROM products WHERE stock > 0;
OPEN insens_cursor;

Once insens_cursor is opened, a snapshot of the products table is created. 
If another transaction updates a products price or adds a new product, 
the changes will not be reflected in the cursors result set..

Non-Scrollable Cursor
A non-scrollable cursor is a forward-only cursor. It can only move sequentially 
from the beginning to the end of the result set. You cannot move backward, 
skip rows, or jump to a specific row. This is the simplest and most efficient 
type of cursor for tasks that require only a single, sequential pass through the data.

DECLARE fwd_cursor CURSOR FOR
    SELECT emp_name FROM employees ORDER BY hire_date;
OPEN fwd_cursor;
FETCH NEXT FROM fwd_cursor INTO @emp_name;
-- You can only FETCH NEXT from here.
-- FETCH PRIOR or FETCH FIRST/LAST is not allowed.

In this example, the fwd_cursor can only be advanced using FETCH NEXT. It cannot be moved backward with FETCH PRIOR or positioned at a different location with FETCH ABSOLUTE.