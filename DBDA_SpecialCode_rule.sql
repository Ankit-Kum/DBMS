1. What is a File System?

    A File System (FS) is a method or structure that an Operating System (OS) uses to:

        Store,
        Organize,
        Access, and
        Manage files and data on a storage device (like HDD, SSD, USB, or CD/DVD).

    Without a file system, data would just be stored in raw blocks on the disk, making it impossible for humans or applications to identify, retrieve, or modify specific files.


Functions of a File System

    Organization → Stores data as files and directories (not raw blocks).
    Naming → Gives files unique names (e.g., data.csv).
    Access Control → Allows read, write, execute permissions for users.
    Storage Management → Tracks free/used disk space.
    Metadata Handling → Stores details like file size, type, timestamps.
    Fault Tolerance → Some FS (NTFS, ext4) use journaling to recover after crashes.

Why Do We Need a File System?

        Human-Readable Organization
                Without FS → storage would just look like raw 0s and 1s.
                With FS → we see named files and folders, making it user-friendly.

        Efficient storage → Prevents wasted space and manages fragmentation.
        Easy retrieval → You search my_resume.pdf, not disk block #452.
        Security → Restricts unauthorized access (permissions, ACLs).
        Reliability → Protects against corruption and supports recovery.
        Multi-user support → Ensures safe concurrent file access.

Examples of File Systems
    FAT32 → USB drives, older Windows.
    NTFS → Modern Windows (security + journaling).
    ext3/ext4 → Linux (robust journaling).
    APFS → Apple macOS, iOS.







Codd's 12 rules, including Rule 0, are a set of principles that define what is required for a database management system to be considered truly relational. 
They were developed by Edgar F. Codd to set a high standard for relational database products.

Rule 0: The Foundation Rule
    Principle: A system claiming to be a relational database management system (RDBMS) must be 
    able to manage the database entirely through its relational capabilities. 
    This means it must use the relational model and its defined languages to handle all data operations.

Rule 1: The Information Rule
    Principle: All information in the database, including metadata, must be represented by values in tables.
    Example: A customer's name, their order history, and even the table's structure (its column names and data types) are all stored as values within tables in the database.

Rule 2: The Guaranteed Access Rule
    Principle: Every piece of data in the database must be logically accessible using a combination of the table name, primary key value, and column name. No reliance on physical addresses or pointers.
    Example: To find a customer's phone number, you use a query like SELECT phone_number FROM customers WHERE customer_id = '123'. You dont need to know its physical location on the disk.

Rule 3: Systematic Treatment of NULL Values
    Principle: Null values, representing missing or inapplicable information, must be supported and handled consistently and uniformly by the system.
    Example: In a Customers table, if a customer hasnt provided their email, the email column will have a NULL value. When you query for all customers with an email, the system correctly excludes those with a NULL value.

Rule 4: Dynamic Online Catalog based on the Relational Model
    Principle: The databases description (metadata) must be stored in an online catalog accessible using the same relational language as the user data.
    Example: A database administrator can run an SQL query like SELECT column_name FROM information_schema.columns WHERE table_name = 'customers' to view the columns of the customers table.

Rule 5: The Comprehensive Data Sub-language Rule
    Principle: The RDBMS must support at least one comprehensive language that can be used for defining, manipulating, and controlling data, and this language must be expressible as a string of characters.
    Example: SQL (Structured Query Language) is the most prominent example, supporting operations like CREATE TABLE, INSERT, UPDATE, DELETE, and SELECT.

Rule 6: The View Updating Rule
    Principle: All views that are theoretically updatable must also be updatable by the system.
    Example: If a view is created from a single table (e.g., CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active'), the system should allow you to UPDATE or DELETE rows through that view.

Rule 7: High-level Insert, Update, and Delete
    Principle: The RDBMS must support high-level relational operations (e.g., set-at-a-time operations) for inserting, updating, and deleting data, not just row-by-row processing.
    Example: Using a single SQL statement, you can update the salary of an entire department: UPDATE employees SET salary = salary * 1.10 WHERE department = 'Sales'.

Rule 8: Physical Data Independence
    Principle: Changes to the physical storage of data should not affect application programs.
    Example: If a database administrator moves a table's data from one hard drive to another or changes the indexing, an application program that queries the data should continue to work without any modifications.

Rule 9: Logical Data Independence
    Principle: Changes to the logical structure of the database should not require changes to the application programs.
    Example: If a full_name column is split into first_name and last_name, the application can still access the full name using a view that joins the two new columns, and the application's code remains unchanged.

Rule 10: Integrity Independence
    Principle: Integrity constraints (like primary keys and foreign keys) must be defined in the relational language and stored in the catalog, not in the application code. The database system must enforce them.
    Example: A foreign key constraint between an Orders table and a Customers table ensures that an order cannot be created for a non-existent customer. This rule is enforced by the database itself, not by the application.

Rule 11: Distribution Independence
    Principle: The end-user should not have to know if the data is distributed across multiple locations.
    Example: A user in New York queries a Products table, and the system transparently fetches some data from a server in London and some from a server in Tokyo, presenting it as if it's all in one place.

Rule 12: The Non-subversion Rule
    Principle: If the system provides a low-level interface (e.g., for record-at-a-time access), that interface must not be able to bypass the integrity constraints defined in the relational language.
    Example: An administrator using a low-level tool to directly modify a record cannot bypass a constraint that prevents them from entering a duplicate customer ID, as the RDBMS's integrity rules must still be enforced.

-------------------------------

Database Storage Structure, 
    specifically Table Space, Control File, and Data File. 
    These are fundamental concepts in databases like Oracle, MySQL, PostgreSQL

A database is stored on disk using a logical structure (tables, indexes, views, etc.) 
and a physical structure (files on the operating system).

1. Tablespace
        A logical storage unit in a database.
        It groups related data files together for easier management.
        Contains all schema objects: tables, indexes, views, procedures.

    Characteristics
        A database must have at least one tablespace (default/system tablespace).
        Can contain multiple data files.
        Makes it easier to allocate, manage, and back up data storage.

    Example
        In Oracle: USERS, SYSTEM, TEMP, UNDO are common tablespaces.
        In MySQL (InnoDB): tablespaces store data/indexes.

    Think of it as a folder that organizes related data files.

2. Control File
    A small binary file that stores metadata about the database.

    Contains:
        Database name & creation time
        Locations of data files & redo log files
        Checkpoint info & backup info

    Critical for database startup (without it, DB can’t open).
    Usually multiple copies exist for safety.

    Think of it as the database’s “map/index card” that tells where everything is.

3. Data File

    The physical files on disk that store actual data.
    Each tablespace consists of one or more data files.
    Stores tables, indexes, and records in database blocks.
    Examples: .dbf (Oracle), .ibd (MySQL), .mdf (SQL Server).

    Think of it as the actual bookshelf where the data (books) are kept.

---------------------

Introduction to Data Collection

Data collection is the process of gathering, measuring, and analyzing information from various sources to answer questions, 
make decisions, or support research.

    It is the first step in the data analysis process.
    Ensures that data is accurate, complete, and reliable for informed decision-making.

Purpose of Data Collection

    Decision Making → Provides insights for business, research, or policy-making.
    Problem Solving → Identifies trends, gaps, and areas for improvement.
    Monitoring & Evaluation → Tracks progress or performance over time.
    Research & Development → Supports scientific studies and experiments.

Types of Data

    Qualitative Data – Non-numerical, descriptive information.

        Example: Opinions, interviews, reviews, observations.

    Quantitative Data – Numerical, measurable information.

        Example: Sales numbers, temperature readings, survey ratings.

Methods of Data Collection

    Primary Data Collection – Data collected first-hand by the researcher.

        Examples: Surveys, interviews, experiments, observations.

    Secondary Data Collection – Data collected from existing sources.

        Examples: Books, journals, government reports, online databases.

Characteristics of Good Data Collection

    Accuracy → Correct and precise data.
    Reliability → Consistent over time and across sources.
    Completeness → All required data is collected.
    Timeliness → Data is collected in time for decision-making.
    Relevance → Data directly addresses the research problem.

Importance of Data Collection

    Supports evidence-based decisions in business, healthcare, science, and education.
    Helps in identifying patterns, trends, and correlations.
    Reduces risks and uncertainties in planning and strategy.
    Provides a foundation for statistical analysis and predictive modeling.

Real-World Examples

    Business: Collecting customer feedback through surveys to improve products.
    Healthcare: Gathering patient data for treatment outcomes or epidemiology studies.
    Government: Census data collection for policy-making and resource allocation.
    Research: Experiment data in labs or field studies.

-----------------------------

The tools and how data can be gathered in a systematic fashion

Systematic Data Collection

Collecting data systematically ensures that the data is accurate, reliable, and consistent.
    It involves planning, selecting methods, using tools, and recording information in an organized way.

Steps for Systematic Data Collection

    Define Objectives
        Clearly identify what you want to find out.
        Example: Measure customer satisfaction or track temperature changes.

    Determine Data Type
        Quantitative → Numbers, counts, measurements.
        Qualitative → Opinions, descriptions, behaviors.

    Select Collection Method
        Choose appropriate methods (survey, observation, experiment, secondary sources).

    Design Tools/Instrument
        Questionnaires, interview guides, sensors, checklists, forms, or software.

    Sampling Plan
        Decide who/what to collect data from (population or sample).
        Example: 500 customers from 10 stores.

    Data Collection
        Collect information accurately and ethically.
        Ensure proper storage and labeling.

    Data Verification
        Check for errors, missing values, and inconsistencies.

    Data Storage
        Store in spreadsheets, databases, or data management systems.

Tools for Data Collection
| **Tool/Instrument**          | **Description / Use**                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| **Questionnaires / Surveys** | Structured or semi-structured questions for a group of respondents.                   |
| **Interviews**               | Face-to-face, telephonic, or online discussions for qualitative insights.             |
| **Observation Sheets**       | Record behaviors, events, or processes directly.                                      |
| **Experiments / Sensors**    | Measure variables under controlled conditions (temperature, pressure, usage).         |
| **Forms & Checklists**       | Track data systematically for tasks, inspections, or events.                          |
| **Secondary Data Sources**   | Use existing data like government reports, journals, company records.                 |
| **Digital Tools & Software** | Google Forms, SurveyMonkey, Microsoft Excel, Python scripts, SQL databases, BI tools. |


Systematic Techniques

    Structured Approach
        Follow a predefined format for every data point.
        Example: All survey responses use the same scale (1–5).

    Sampling Techniques
        Random Sampling → every member has equal chance.
        Stratified Sampling → divide population into strata and sample proportionally.
        Cluster Sampling → sample entire groups or clusters.

    Pilot Testing
        Test the collection method/tool on a small group before full deployment.
        Helps identify flaws and improve accuracy.

    Data Logging and Recording
        Maintain logs or digital records with time, date, and source.
        Example: Excel sheets, databases, cloud storage.

    Validation and Cleaning
        Ensure collected data is consistent, complete, and error-free.
        Remove duplicates, correct errors, standardize formats.

Real-World Examples

    Business: Collect customer feedback using online forms, in-store surveys, and loyalty card data.
    Healthcare: Gather patient vitals through sensors, EHR (Electronic Health Records), and lab tests.
    Research: Collect field data via questionnaires, interviews, or observational logs.
    IoT / Smart Systems: Sensors systematically collect temperature, humidity, and usage data continuously.