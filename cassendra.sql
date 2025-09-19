 Introduction to Cassendra

 Apache Cassandra is an open-source, distributed NoSQL database designed to handle large volumes of data across many servers without a single point of failure. It was originally developed at Facebook and later open-sourced under the Apache Software Foundation.

 Apache Cassandra is a distributed, wide-column NoSQL database designed to provide:

    Linear scalability  performance grows as new nodes are added.
    Fault tolerance  no single point of failure.
    Decentralization  every node is equal (peer-to-peer architecture).
    High availability  always accessible even during node failures.

t was created by Facebook in 2008 for their Inbox Search feature and became an Apache top-level project in 2010.

Cassandras data model is a wide-column store, which can be thought of as a hybrid of key-value and tabular database systems. Data is organized into keyspaces (similar to a relational database) which contain tables. These tables have a flexible schema and are optimized for fast write and read operations. Cassandra Query Language (CQL), which is similar to SQL, is used to interact with the database.

Comparison between Cassendra and MongoDB

| Feature             | **Cassandra**                                         | **MongoDB**                                        |
| ------------------- | ----------------------------------------------------- | -------------------------------------------------- |
| **Type**            | Wide-column NoSQL                                     | Document-oriented NoSQL                            |
| **Architecture**    | Decentralized, peer-to-peer                           | Master-slave (replica sets) or sharded cluster     |
| **Scalability**     | Easy horizontal scaling                               | Horizontal via sharding, vertical scaling possible |
| **Consistency**     | Tunable (ONE, QUORUM, ALL)                            | Strong on primary, eventual on secondaries         |
| **Best For**        | High write throughput, distributed systems, logs, IoT | Flexible documents, rich queries, read-heavy apps  |
| **Query Language**  | CQL (SQL-like, limited)                               | MQL (rich queries, aggregation)                    |
| **Fault Tolerance** | High; no single point of failure                      | Replica sets; primary election on failure          |
| **Schema**          | Query-driven, semi-flexible                           | Fully flexible, schema-less                        |
| **Performance**     | Optimized for writes                                  | Optimized for reads, moderate writes               |


Cassandra Architecture

Cassandra was designed to handle big data workloads across multiple nodes without a single point of failure. It has a peer-to-peer distributed system across its nodes, and data is distributed among all the nodes in a cluster.

    In Cassandra, each node is independent and at the same time interconnected to other nodes. All the nodes in a cluster play the same role.
    Every node in a cluster can accept read and write requests, regardless of where the data is actually located in the cluster.
    In the case of failure of one node, Read/Write requests can be served from other nodes in the network.

Data Replication in Cassandra
In Cassandra, nodes in a cluster act as replicas for a given piece of data. If some of the nodes are responded with an out-of-date value, Cassandra will return the most recent value to the client. After returning the most recent value, Cassandra performs a read repair in the background to update the stale values.

Components of Cassandra
The main components of Cassandra are:

Node: A Cassandra node is a place where data is stored.
Data center: Data center is a collection of related nodes.
Cluster: A cluster is a component which contains one or more data centers.
Commit log: In Cassandra, the commit log is a crash-recovery mechanism. Every write operation is written to the commit log.
Mem-table: A mem-table is a memory-resident data structure. After commit log, the data will be written to the mem-table. Sometimes, for a single-column family, there will be multiple mem-tables.
SSTable: It is a disk file to which the data is flushed from the mem-table when its contents reach a threshold value.
Bloom filter: These are nothing but quick, nondeterministic, algorithms for testing whether an element is a member of a set. It is a special kind of cache. Bloom filters are accessed after every query.

Cassandra Query Language
Cassandra Query Language (CQL) is used to access Cassandra through its nodes. CQL treats the database (Keyspace) as a container of tables. Programmers use cqlsh: a prompt to work with CQL or separate application language drivers.

The client can approach any of the nodes for their read-write operations. That node (coordinator) plays a proxy between the client and the nodes holding the data.


Cassandra Data Model

Cassandra is a wide-column store. Unlike relational databases, it does not have fixed rows/columns.

Key Concepts:

Keyspace → top-level namespace (like a database in RDBMS).
Table → contains rows and columns.
Row → identified by a primary key.
Primary Key = Partition Key + Clustering Columns
Partition Key decides which node stores the data.
Clustering Columns define sort order within a partition.


-- Create a keyspace
CREATE KEYSPACE myapp
WITH replication = {'class':'SimpleStrategy', 'replication_factor':2};

-- Use the keyspace
USE myapp;

-- Create a table
CREATE TABLE users (
   user_id UUID PRIMARY KEY,
   name TEXT,
   email TEXT,
   signup_date TIMESTAMP
);

-- Insert data
INSERT INTO users (user_id, name, email, signup_date)
VALUES (uuid(), 'Alice', 'alice@example.com', toTimestamp(now()));

-- Query data
SELECT * FROM users;

--------------------------------------

CREATE KEYSPACE ecommerce
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE ecommerce;

CREATE TABLE orders (
   order_id UUID,
   customer_id UUID,
   order_date TIMESTAMP,
   amount DECIMAL,
   PRIMARY KEY (customer_id, order_date)
);


Cassandra Create Keyspace
What is Keyspace?
A keyspace is an object that is used to hold column families, user defined types. A keyspace is like RDBMS database which contains column families, indexes, user defined types, data center awareness, strategy used in keyspace, replication factor, etc.

In Cassandra, "Create Keyspace" command is used to create keyspace.

CREATE KEYSPACE <identifier> WITH <properties>   
Create keyspace KeyspaceName with replicaton={'class':strategy name,   'replication_factor': No of replications on different nodes}

Different components of Cassandra Keyspace
Strategy: There are two types of strategy declaration in Cassandra syntax:

    Simple Strategy: Simple strategy is used in the case of one data center. In this strategy, the first replica is placed on the selected node and the remaining nodes are placed in clockwise direction in the ring without considering rack or node location.
    Network Topology Strategy: This strategy is used in the case of more than one data centers. In this strategy, you have to provide replication factor for each data center separately.
Replication Factor: Replication factor is the number of replicas of data placed on different nodes. More than two replication factor are good to attain no single point of failure. So, 3 is good replication factor.

CREATE KEYSPACE Cassandra1  
WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};   

Verification:
To check whether the keyspace is created or not, use the "DESCRIBE" command. By using this command you can see all the keyspaces that are created.

DESCRIBE Cassandra1

Using a Keyspace
To use the created keyspace, you have to use the USE command.

USE <identifier>  
USE Cassandra1

-- Alter Keyspace
ALTER KEYSPACE <identifier> WITH <properties>   

ALTER KEYSPACE "KeySpace Name"  
WITH replication = {'class': 'Strategy name', 'replication_factor' : 'No.Of  replicas'};  

ALTER KEYSPACE javatpoint  
WITH replication = {'class':'NetworkTopologyStrategy', 'replication_factor' : 1};   


DROP  keyspace KeyspaceName ;  
DROP  keyspace Cassandra1


--Create keyspace:
CREATE KEYSPACE school WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE school;

--Create table:
CREATE TABLE students (roll_no int PRIMARY KEY, name text, age int, marks int);

--Alter table:
ALTER TABLE students ADD email text;

--Insert and test queries:
INSERT INTO students (roll_no, name, age, email) VALUES (1, 'Alice', 20, 'alice@example.com');
SELECT * FROM students;

--Create index:
CREATE INDEX student_email_index ON students (email);

--Query using index:
SELECT * FROM students WHERE email = 'alice@example.com';

--Truncate table:
TRUNCATE students;

--Drop index & table:
DROP INDEX student_email_index;
DROP TABLE students;

Cassandra table operations are similar to RDBMS but simpler and more restrictive (because Cassandra prioritizes performance & scalability over strict schema features).

You design tables around queries in Cassandra, unlike RDBMS where normalization and joins are common.



----
-- Create keyspace
CREATE KEYSPACE school WITH replication = {'class':'SimpleStrategy','replication_factor':1};
USE school;

-- Create table
CREATE TABLE students (
    roll_no int PRIMARY KEY,
    name text,
    age int,
    email text
);

-- Insert rows
INSERT INTO students (roll_no, name, age, email) VALUES (1, 'Alice', 20, 'alice@example.com');
INSERT INTO students (roll_no, name, age, email) VALUES (2, 'Bob', 22, 'bob@example.com');

-- Read all rows
SELECT * FROM students;

-- Read specific columns
SELECT name, age FROM students;

-- Read with condition (only on primary key or indexed column)
SELECT * FROM students WHERE roll_no = 1;

-- Update age for a student
UPDATE students SET age = 21 WHERE roll_no = 1;

-- Update multiple columns
UPDATE students SET age = 23, email = 'bob_new@example.com' WHERE roll_no = 2;


-- Delete only the email of Alice
DELETE email FROM students WHERE roll_no = 1;

-- Delete Alice’s entire row
DELETE FROM students WHERE roll_no = 1;


--------------
CREATE TABLE orders (
    customer_id int,
    order_id int,
    product text,
    amount decimal,
    PRIMARY KEY (customer_id, order_id)  -- customer_id = partition key, order_id = clustering
);

-- Insert
INSERT INTO orders (customer_id, order_id, product, amount)
VALUES (101, 1, 'Laptop', 750.00);

INSERT INTO orders (customer_id, order_id, product, amount)
VALUES (101, 2, 'Phone', 500.00);

-- Query by partition + clustering
SELECT * FROM orders WHERE customer_id = 101 AND order_id = 2;

-- Add index on product
CREATE INDEX product_index ON orders (product);

-- Now you can query by product
SELECT * FROM orders WHERE product = 'Laptop';

--WHERE with ALLOW FILTERING
If you query on a column that is neither PK nor indexed, you must use ALLOW FILTERING.

SELECT * FROM orders WHERE amount > 600 ALLOW FILTERING;

--a) Update by Primary Key
UPDATE students 
SET age = 21, email = 'alice_new@example.com'
WHERE roll_no = 1;

--b) Update with Composite Key
UPDATE orders 
SET amount = 800.00
WHERE customer_id = 101 AND order_id = 1;

DELETE email FROM students WHERE roll_no = 1;
DELETE FROM students WHERE roll_no = 2;
DELETE FROM orders WHERE customer_id = 101 AND order_id = 2;


-- CQL Data Types

Cassandra Query Language (CQL) supports a variety of built-in datatypes similar to SQL but adapted for distributed storage.

Basic Types
    ascii → ASCII character string
    text → UTF-8 encoded string (preferred over varchar)
    varchar → Same as text (alias)
    int → 32-bit integer
    bigint → 64-bit integer
    varint → Arbitrary precision integer
    float → 32-bit floating point
    double → 64-bit floating point
    decimal → Variable precision decimal
    boolean → True/False

Date & Time Types
    timestamp → Date + time (in milliseconds since epoch)
    date → Only date (YYYY-MM-DD)
    time → Only time (HH:MM:SS)
    timeuuid → UUID that includes timestamp ordering
    uuid → Universally Unique Identifier

Other Types
    blob → Arbitrary bytes (binary data, images, files)
    inet → IP address (IPv4 or IPv6)
    counter → Special type for increment/decrement operations

2. CQL Collections
--Collections allow storing multiple values in a single column.

Types of Collections
-- List → Ordered collection (allows duplicates).

CREATE TABLE users (
    id int PRIMARY KEY,
    name text,
    phones list<text>
);

INSERT INTO users (id, name, phones)
VALUES (1, 'Alice', ['12345','67890']);

UPDATE users SET phones = phones + ['11111'] WHERE id = 1;

-- Set → Unordered collection (no duplicates).

CREATE TABLE courses (
    id int PRIMARY KEY,
    name text,
    tags set<text>
);

INSERT INTO courses (id, name, tags)
VALUES (1, 'Cassandra Basics', {'NoSQL','Database','BigData'});

UPDATE courses SET tags = tags + {'Distributed'} WHERE id = 1;

--Map → Key-value pairs (like dictionary).
CREATE TABLE products (
    id int PRIMARY KEY,
    name text,
    specs map<text, text>
);

INSERT INTO products (id, name, specs)
VALUES (1, 'Laptop', {'RAM':'16GB', 'CPU':'i7', 'Storage':'512GB'});

UPDATE products SET specs['GPU'] = 'NVIDIA' WHERE id = 1;


3. User Defined Types (UDTs)
--Cassandra allows you to define your own custom datatypes.
CREATE TYPE type_name (
   field1 datatype,
   field2 datatype,
   ...
);

-- Create a user defined type
CREATE TYPE address (
    street text,
    city text,
    zip int
);

-- Use it in a table
CREATE TABLE customers (
    id int PRIMARY KEY,
    name text,
    location frozen<address>
);

-- Insert data with UDT
INSERT INTO customers (id, name, location)
VALUES (1, 'Bob', {street:'1st Ave', city:'New York', zip:10001});

-- Use frozen<UDT> if you want the whole UDT treated as a single unit (required when inside collections).
-- Without frozen, Cassandra can update individual fields of the UDT.

    CQL Data Types → Built-in types (text, int, uuid, timestamp, blob, etc.)
    CQL Collections → list, set, map (to store multiple values in one column).
    User Defined Types (UDT) → Custom data structures that combine multiple fields into one column.

-- data driven decision

A data-driven decision is a decision that is made based on data analysis and interpretation, rather than intuition, personal experience, or guesswork.

In other words, instead of relying on opinions, assumptions, or “gut feelings,” organizations or individuals use quantitative and qualitative data to guide their choices.
Key Points

    Evidence-Based
        Decisions are backed by measurable facts and statistics.
        Example: A company analyzing sales data before launching a new product.

    Objective & Accurate
        Reduces bias and subjectivity.
        Helps identify trends, patterns, and correlations.

    Continuous Improvement
        Allows for tracking results and adjusting strategies over time.
        Example: A/B testing in marketing to see which version performs better.

| Scenario        | Data-Driven Decision Example                                                  |
| --------------- | ----------------------------------------------------------------------------- |
| Marketing       | Increase ad spend on campaigns with higher ROI based on analytics.            |
| E-commerce      | Stock more inventory for products with higher demand according to sales data. |
| Healthcare      | Choose treatments for patients based on success rates from clinical data.     |
| Human Resources | Promote employees based on performance metrics instead of favoritism.         |


What Makes a Decision Data-Driven?

A decision becomes data-driven when it satisfies these criteria:
    Collected Data: Use internal (sales, HR, customer feedback) or external data (market trends, competitor analysis).
    Analyzed Insight: Apply statistical analysis, machine learning, or business intelligence to extract actionable insights.
    Measured Outcomes: Track performance metrics to evaluate if the decision had the desired effect.
    Continuous Iteration: Decisions are refined over time using updated data.

Types of Data Used
Data can be quantitative or qualitative:

| Type         | Description                  | Example                                    |
| ------------ | ---------------------------- | ------------------------------------------ |
| Quantitative | Numeric, measurable data     | Sales figures, website traffic, revenue    |
| Qualitative  | Descriptive, subjective data | Customer reviews, surveys, interviews      |
| Structured   | Organized data in databases  | Employee records, product SKUs             |
| Unstructured | Raw, unorganized data        | Social media posts, call center recordings |

3. Process of Data-Driven Decision Making

    Define Objectives – What problem or goal are you trying to solve?
    Collect Data – Gather relevant data from reliable sources.
    Analyze Data – Use tools like Excel, Tableau, Power BI, or Python for analysis.
    Interpret Insights – Identify patterns, correlations, and trends.
    Make Decision – Use insights to choose the best course of action.
    Measure Results – Track KPIs to see if the decision was effective.

Tools for Data-Driven Decisions

    Analytics Tools: Tableau, Power BI, Google Analytics
    Database Systems: SQL, NoSQL (like Cassandra, MongoDB)
    Programming & AI: Python (pandas, NumPy), R
    Visualization: Dashboards, charts, heatmaps

Real-World Examples
    Retail:
        Amazon uses purchase history and browsing data to recommend products.
        Walmart analyzes foot traffic and sales to optimize inventory levels.

    Marketing:
        Companies run A/B tests to see which ad campaigns convert better.
        Social media analytics guide content strategies.

    Healthcare:
        Hospitals analyze patient records to predict disease outbreaks.
        Treatment plans are optimized based on historical success data.

    Finance:
        Banks use transaction and credit history data to approve loans.
        Fraud detection systems flag unusual transactions in real-time.




# Enterprise Data Management (EDM)

Enterprise Data Management is the process, policies, and technologies used by organizations to manage, integrate, secure, and maintain their data across the enterprise.
It ensures that data is accurate, consistent, available, and governed properly.

Key Goals of EDM:

Ensure data quality and reliability across departments.
Make data accessible and usable for decision-making.
Support regulatory compliance and governance.
Enable data integration across systems and applications.


Components of EDM:

    Data Governance – Policies, standards, and ownership of data.
    Data Architecture – How data flows and is stored across systems.
    Master Data Management (MDM) – Ensures a single source of truth.
    Data Quality Management – Validates accuracy, completeness, and consistency.
    Metadata Management – Maintains information about data (data about data).


-- 2. Data Preparation
Data preparation is the process of collecting, cleaning, transforming, and structuring raw data into a usable format for analysis, reporting, or business intelligence.
Steps in Data Preparation:

    Data Collection – Gather data from multiple sources (databases, CSV files, IoT devices, etc.).
    Data Profiling – Examine data to understand structure, distribution, and quality.
    Data Cleaning – Correct or remove errors, inconsistencies, and duplicates.
    Data Transformation – Convert data into required formats or structures (e.g., normalize, aggregate).
    Data Integration – Combine data from different sources into a unified dataset.
    Data Validation – Ensure data is accurate and meets business rules.

-- 3. Data Cleaning
Data cleaning is the process of identifying and correcting errors or inconsistencies in the data to improve its quality and usability.

Common Data Issues:

    Missing values – Empty fields in datasets.
    Duplicates – Same data recorded multiple times.
    Incorrect data – Typos, wrong formats, or invalid values.
    Inconsistent data – Different formats for the same type of data (e.g., date formats).
    Outliers – Values that are unrealistic or unusual compared to the rest of the dataset.


Data Cleaning Techniques:

Handling Missing Values:
    Remove rows with missing data.
    Fill missing values with mean/median/mode or default values.

Removing Duplicates:
    Identify duplicate rows and remove them.

Correcting Errors:
    Standardize formats (e.g., phone numbers, dates).
    Correct spelling mistakes.

Consistency Checks:
    Ensure related fields match (e.g., state and zip code).

Outlier Detection & Treatment:
    Identify unusual values using statistical methods.
    Decide whether to remove, correct, or keep them based on context.


Benefits of Data Cleaning

    Ensures accurate insights for decision-making.
    Improves data consistency across the organization.
    Reduces errors in reporting and analytics.
    Saves time and effort for data scientists and analysts.


-- 1. Create employees table
CREATE TABLE employees (
    emp_id int PRIMARY KEY,
    emp_name text,
    salary decimal,
    commission decimal
);

-- 2. Create index on commission
CREATE INDEX commission_index ON employees (commission);

-- 3. Insert new employee
INSERT INTO employees (emp_id, emp_name, salary, commission)
VALUES (3, 'Nick', 15000, 0);

-- 4. Update salary where commission = 0
UPDATE employees SET salary = 20000 WHERE commission = 0;

-- 5. Update salary for emp_id = 3
UPDATE employees SET salary = 18000 WHERE emp_id = 3;

-- 6. Update name to uppercase for emp_id = 3
UPDATE employees SET emp_name = 'NICK' WHERE emp_id = 3;

-- 7. Create teachers table (with collection)
CREATE TABLE teachers (
    teacher_id int PRIMARY KEY,
    teacher_name text,
    subjects set<text>
);
INSERT INTO teachers (teacher_id, teacher_name, subjects)
VALUES (1, 'Mr. Smith', {'Math','Science'});

-- 8. Create books table (with collection)
CREATE TABLE books (
    book_id int PRIMARY KEY,
    title text,
    authors list<text>
);
INSERT INTO books (book_id, title, authors)
VALUES (1, 'Cassandra Basics', ['Alice','Bob']);
