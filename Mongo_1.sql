Introduction to NoSQL Database

NoSQL (Not Only SQL) refers to a category of database management systems that are non-relational in nature.

Unlike traditional Relational Databases (RDBMS), which store data in structured tables with rows and columns, NoSQL databases can store data in various flexible formats, such as key-value pairs, documents, wide-columns, or graphs.

They are designed to handle large volumes of unstructured, semi-structured, or rapidly changing data.

NoSQL databases are widely used in applications requiring high scalability, real-time processing, and distributed storage, such as big data, IoT, social networks, and e-commerce platforms.


Key Features of NoSQL Database
    Schema-less (Flexible Data Model)
        No predefined schema is required.
        Data can be stored without defining structure in advance.

    Variety of Data Models
        Supports multiple models:
            Key-Value Stores (e.g., Redis, DynamoDB)
            Document Stores (e.g., MongoDB, CouchDB)
            Column-Oriented Stores (e.g., Cassandra, HBase)
            Graph Databases (e.g., Neo4j)

    Horizontal Scalability
        Scales easily across multiple servers by adding nodes.
        Provides high availability and performance under large workloads.

    High Performance
        Optimized for fast read/write operations.
        Suitable for real-time applications.

    Distributed & Fault-Tolerant
        Data is distributed across multiple nodes.
        Provides replication and automatic recovery in case of failures.

    Handles Big Data
        Designed to manage large volumes of structured, semi-structured, and unstructured data.

    Supports CAP Theorem
        Focuses on Consistency, Availability, and Partition tolerance (usually trades strict consistency for availability and scalability).

    Open Source & Cloud Friendly
        Many NoSQL databases are open source and integrate easily with cloud platforms.


Structured vs. Semi-structured and Unstructured Data

1. Structured Data
    Data that follows a strict format, stored in rows and columns (like in relational databases).
    Structured data is highly organized data stored in a tabular form (rows and columns) where each field has a predefined data type and format. It is the traditional form of data used in Relational Database Management Systems (RDBMS).
        Characteristics:
            Organized in a tabular schema (tables, fields, data types).
            Easy to enter, query, and analyze with SQL.
            Requires predefined schema.

        Examples:
            Customer records (Name, Age, Address, Phone).
            Financial transactions.
            Inventory management data.
            Banking system (account numbers, balances, transaction history).

Student database (ID, Name, Age, Marks).
        Storage: RDBMS (e.g., MySQL, Oracle, PostgreSQL).

2. Semi-Structured Data

    Definition: Data that does not follow a strict schema but still has some organizational elements (tags, key-value pairs).
    Semi-structured data is data that does not follow a strict tabular structure but still contains tags, markers, or metadata to separate semantic elements. It has some organizational properties but lacks the rigid structure of relational databases.
        Characteristics:
            Flexible format (no rigid schema).
            Uses markers like tags or keys to separate elements.
            More difficult to analyze than structured data but easier than unstructured.

        Examples:
            JSON, XML, YAML files.
            NoSQL documents (MongoDB, CouchDB).
            Emails (headers + body text).

        Storage: NoSQL databases, object stores, document databases.

3. Unstructured Data
    Data with no predefined structure or organization, difficult to store in tables.
    Unstructured data is raw data with no predefined format or model. It does not fit neatly into rows and columns. Most of the world’s data (~80%) is unstructured.
        Characteristics:
            No schema or format.
            Hard to search and analyze with traditional tools.
            Often very large in size.

        Examples:
            Images, videos, audio files.
            Social media posts (tweets, comments).
            Sensor data, raw logs.

        Storage: Data lakes, distributed file systems (HDFS, Amazon S3), multimedia databases.

Structured = organized, easy to analyze.
Semi-structured = flexible, some structure for organization.
Unstructured = raw, hard to process but rich in insights.


Difference between RDBMS and NoSQL databases

1. RDBMS (Relational Database Management System)
    RDBMS stores data in tables (rows and columns) with a predefined schema. Relationships between tables are established using primary keys and foreign keys.
        Characteristics
            Follows ACID properties (Atomicity, Consistency, Isolation, Durability).
            Strong consistency.
            Uses SQL for querying and managing data.
            Best for structured data.
            Scaling is usually vertical (add more CPU/RAM to one server).

2. NoSQL Databases
    NoSQL (Not Only SQL) databases are non-relational and designed to handle large volumes of unstructured, semi-structured, or structured data. They provide flexibility, scalability, and high performance.
        Characteristics
            Schema-less or flexible schema.
            Follows BASE properties (Basically Available, Soft state, Eventual consistency).
            Data can be stored in Key-Value, Document, Column-Family, or Graph models.
            Supports horizontal scaling (data distributed across many servers).
            Best for big data, real-time apps, and distributed systems.

        Examples
            MongoDB (Document Store)
            Cassandra, HBase (Column Store)
            Redis, DynamoDB (Key-Value Store)
            Neo4j (Graph Database)


| Feature                | RDBMS (Relational DB)                        | NoSQL (Non-Relational DB)                        |
| ---------------------- | -------------------------------------------- | ------------------------------------------------ |
| **Data Model**         | Tables (rows & columns)                      | Key-Value, Document, Column-Family, Graph        |
| **Schema**             | Fixed, predefined schema                     | Schema-less or flexible                          |
| **Query Language**     | SQL                                          | Varies (MongoDB query language, CQL, APIs, etc.) |
| **Transactions**       | ACID (strong consistency, reliable)          | BASE (eventual consistency, highly available)    |
| **Scalability**        | Vertical (scale-up: add CPU, RAM)            | Horizontal (scale-out: add more servers)         |
| **Best for**           | Structured data, financial systems, ERP, CRM | Big data, IoT, social media, real-time analytics |
| **Data Size Handling** | Moderate to large datasets                   | Very large, distributed datasets (petabytes)     |
| **Examples**           | MySQL, Oracle, PostgreSQL, SQL Server        | MongoDB, Cassandra, Redis, Neo4j, DynamoDB       |


    RDBMS = Like a well-organized Excel sheet with strict rules.
    NoSQL = Like a flexible folder where you can keep text, images, or JSON files without strict rules.


# CAP Theorem, BASE Model

    The CAP Theorem and BASE model are fundamental concepts in the design of distributed systems, particularly NoSQL databases. They help explain the trade-offs that developers must make when building systems that need to be scalable and resilient to network failures.

        CAP Theorem

            The CAP theorem states that a distributed data system can only simultaneously guarantee two of the following three properties:

                Consistency (C): Every read operation receives the most recent write or an error. In a consistent system, all nodes have the same data at the same time.

                Availability (A): Every request receives a response, without the guarantee that it is the most recent data. The system remains operational even if some nodes fail.

                Partition Tolerance (P): The system continues to operate despite network partitions (i.e., communication failures between nodes).

        In a distributed database, when a network partition occurs, you can only provide two out of three guarantees:
            Consistency (C)
            Availability (A)
            Partition Tolerance (P)
        
        Since partition tolerance (P) is inevitable in distributed systems, you always have to choose between C or A.

        The 3 Components

            Consistency (C)
                Every node has the same data at the same time.
                Example: If you transfer $100 from your account, all branches of the bank must show the same balance immediately.

            Availability (A)
                Every request receives a response (even if its not the latest).
                Example: If you check your Instagram likes, youll always get a response, even if it might be slightly outdated.

            Partition Tolerance (P)
                System continues working despite network failures.
                Example: Even if one data center in India cant talk to the one in the US, both must continue running.

Since network partitions are inevitable in any distributed system, a developer must choose between Consistency and Availability. This leads to two main architectural patterns:

    CP (Consistent and Partition-tolerant) systems: These systems prioritize data consistency. When a partition occurs, they will stop serving requests for the affected data to prevent inconsistencies, thereby sacrificing availability.

        Example: A banking system must ensure that an account balance is always accurate across all locations. If a network partition occurs, the system might refuse a transaction request rather than risking a double-charge or incorrect balance, prioritizing consistency over availability.

    AP (Available and Partition-tolerant) systems: These systems prioritize availability. When a partition occurs, they will continue to serve requests, but they might return stale data.

        Example: A social media platform like Facebook or Twitter must remain available at all times. If a user in Europe updates their profile, a user in Asia might see the old profile for a few moments until the partition is resolved and the data is synchronized. Availability is prioritized over immediate consistency.

    CA (Consistency + Availability) : While its a theoretical possibility, a CA (Consistency + Availability) distributed system isnt practically achievable in the real world due to the CAP theorem. The theorem states that a distributed system must sacrifice either Consistency or Availability when a network partition occurs.

        Sacrifices Partition Tolerance.
        Rare in distributed systems (since partitions happen).
        Example: Traditional RDBMS (MySQL, PostgreSQL) in a single-node setup.
        Real-life example: Your company’s HR payroll system (running on one server) → always consistent & available, but if the server crashes (partition), the system goes down.
        
        Example : A single-node, non-distributed relational database like a traditional MySQL or PostgreSQL server is often cited as a conceptual example of a CA system. This is because, in a single server, there are no network partitions to worry about. The system can guarantee both consistency (all data is on one server) and availability (as long as the server is running). However, as soon as you distribute the data across multiple servers for scalability or fault tolerance, it ceases to be a true CA system and must then make a C/A trade-off in the event of a network partition.
    
    
2. BASE Model (Basically Available, Soft state, Eventually consistent)

    The BASE model is an alternative to the strict ACID model of RDBMS, tailored for distributed NoSQL systems where high availability and partition tolerance are more important than immediate consistency.
    
        The BASE model is a set of principles that aligns with the "AP" side of the CAP theorem and is often used by NoSQL databases. BASE is an acronym that stands for:
        
            Basically Available: The system is guaranteed to be available and will respond to every request, even if some parts of the system are down.

            Soft state: The state of the system can change over time, even without new input. This is because consistency is not guaranteed and data might be in an inconsistent or "soft" state as it propagates through the system.

            Eventually consistent: The system will eventually become consistent once the network partition is resolved and the data has been replicated across all nodes.

            Example: In an e-commerce platform, adding an item to your cart might not be immediately visible to all users (e.g., in a "recently purchased" feed), but the data will eventually become synchronized. This model allows the system to remain available for transactions, even with temporary data inconsistencies.
        
    
BASE Properties
    Basically Available (BA)
        The system guarantees availability.
        Even if some nodes are down, the system responds.
        Example: On Flipkart, product searches always return results even if one server is slow/unavailable.

    Soft State (S)
        The state of the system may change over time, even without new input.
        Example: In Twitter, your feed may look different each time as replicas update asynchronously.

    Eventually Consistent (E)
        Data may not be consistent at all times, but will become consistent eventually.
        Example: When you change your WhatsApp profile picture, some friends see the old picture for a few seconds until all servers are updated.

            
        | Feature          | **ACID (SQL Databases)**  | **BASE (NoSQL Databases)**   |
        | ---------------- | ------------------------- | ---------------------------- |
        | **Consistency**  | Immediate & strong        | Eventual (may take time)     |
        | **Availability** | Lower (prioritizes rules) | Higher (always responds)     |
        | **Use Case**     | Banking, ticket booking   | Social media, e-commerce     |
        | **Examples**     | Oracle, MySQL, PostgreSQL | Cassandra, DynamoDB, MongoDB |

    
Real-Time Scenarios
    Banking System (ACID, CP System)
            You withdraw ₹10,000.
            The system must immediately reflect this change across all branches.
            If theres a network partition, your transaction may be blocked until all nodes sync.
            ✅ Prioritizes Consistency over Availability.

    E-Commerce Shopping Cart (BASE, AP System)
            You add a phone to your Amazon cart.
            The system accepts immediately (always available).
            But on your mobile app, you may still see the cart empty for a few seconds until replicas sync.
            ✅ Prioritizes Availability and Partition Tolerance, while eventually becoming consistent.

    Social Media Likes (BASE, AP System)
            You like a post on Instagram.
            Your friend in another country might not see the like instantly.
            After a few seconds, when all replicas sync, your like shows up.
            ✅ Eventual consistency works fine here, since strict consistency isnt critical.

---------------------------------
Understanding the Storage Architecture
    NoSQL databases use different storage architectures depending on their category:
    Categories of NoSQL Databases: Key-Value Store, Document Store, Column-Oriented, Graph

1. Key-Value Store
        Definition
            The simplest type of NoSQL database.
            Data is stored as a key (unique identifier) and a value (data object).
            Works like a dictionary / hash map.

        Features
            Very fast read/write performance.
            Schema-less → values can be strings, JSON, binary data, etc.
            Great for caching and quick lookups.

        Examples
            Redis
            Amazon DynamoDB
            Riak

        Real-Time Use Cases
            Session management in web apps (store login sessions).
            Shopping cart data in e-commerce.
            Caching user preferences or recommendations.

2. Document Store
        Definition
            Stores data in documents (usually JSON, BSON, or XML).
            Each document is self-contained and schema-free.
            Ideal for semi-structured data.

        Features
            Flexible schema → documents in the same collection may have different fields.
            Supports indexing and complex queries.
            Great for hierarchical and nested data.

        Examples
            MongoDB
            CouchDB
            Firebase Firestore

        Real-Time Use Cases
            User profiles (each user can have different attributes).
            Content management systems (articles, blogs, product catalogs).
            Mobile apps (flexible and fast backend).

3. Column-Oriented (Wide-Column Store)
        Definition
            Stores data in columns instead of rows.
            Organizes data into column families for fast access.
            Best for big data and analytics.

        Features
            Handles huge volumes of data.
            Efficient for range queries and time-series data.
            Horizontal scalability (across many servers).

        Examples
            Apache Cassandra
            HBase
            ScyllaDB

        Real-Time Use Cases
            IoT sensor data (storing time-series readings).
            Recommendation engines (Netflix suggestions).
            Data analytics (large-scale reporting, log storage).

4. Graph Database
        Definition
            Focuses on relationships between data.
            Data stored as:
                Nodes → entities (e.g., user, product).
                Edges → relationships (e.g., friend-of, purchased).
                Properties → attributes of nodes/edges.

        Features
            Great for relationship-heavy queries.
            Uses graph traversal instead of complex SQL joins.
            Real-time insights into connections.

        Examples
            Neo4j
            Amazon Neptune
            OrientDB

        Real-Time Use Cases
            Social networks (friends, followers).
            Fraud detection (unusual transaction patterns).
            Recommendation systems (“users who bought this also bought…”).

        | Category            | Data Format       | Best For                   | Examples                    |
        | ------------------- | ----------------- | -------------------------- | --------------------------- |
        | **Key-Value Store** | Key + Value       | Caching, session storage   | Redis, DynamoDB, Riak       |
        | **Document Store**  | JSON / BSON Docs  | Flexible schema apps       | MongoDB, CouchDB, Firestore |
        | **Column-Oriented** | Columns, families | Big Data, time-series      | Cassandra, HBase, ScyllaDB  |
        | **Graph Database**  | Nodes + Edges     | Relationship-heavy queries | Neo4j, Amazon Neptune       |

    Key-Value → Like a dictionary (word = key, meaning = value).
    Document Store → Like a folder of JSON files, each file can look different.
    Column-Oriented → Like an Excel sheet optimized by columns, not rows.
    Graph → Like a mind map showing relationships.

---------------------
4. Working with Column-Oriented Databases
        Concept: Instead of storing data row by row, they store it column by column.
        Why? Efficient for queries on large datasets (analytics, time-series).

    Storage Layout:
        Data is grouped into column families.
        Each row can have variable columns (sparse data).

    Example (Cassandra-like table):
    | UserID | Name  | Email                                   | Phone   |
    | ------ | ----- | --------------------------------------- | ------- |
    | 1      | Alice | [alice@mail.com](mailto:alice@mail.com) | 999-111 |
    | 2      | Bob   | [bob@mail.com](mailto:bob@mail.com)     | NULL    |

In Cassandra, columns are stored together, so querying all emails is very fast.

Use Cases:
    IoT sensor data.
    Logging & monitoring systems.
    Data warehouses (analytics).
    
----------------------------
5. Document Store Internals
        Concept: Stores data in documents (JSON, BSON, or XML).
        Structure:
            A collection = group of documents.
            A document = key-value pairs, nested structures allowed.
            Internals (MongoDB example):

You insert JSON:
    { "name": "Alice", "age": 25 }
MongoDB converts it into BSON:
    { "name": String("Alice"), "age": Int32(25) }

----------------------------------
    --RDBMS & MongoDB analogies: relations/tables => collections; tuples/records => documents
    --RDBMS vs MongoDB Analogies

    | RDBMS Concept        | MongoDB Equivalent**              | Explanation**                                                                                            |
    | ---------------------| --------------------------------- | -------------------------------------------------------------------------------------------------------- |
    | Database             | Database                          | A container of collections (MongoDB) or tables (RDBMS).                                                  |
    | Table (Relation)     | Collection                        | Both hold groups of records/documents.                                                                   |
    | Row / Tuple / Record | Document                          | Each row in RDBMS = one JSON-like document in MongoDB.                                                   |
    | Column / Attribute   | Field                             | Each column in RDBMS = a field (key-value) in MongoDB.                                                   |
    | Primary Key          | _id field                         | MongoDB automatically creates a unique _id field for each document (like primary key).                   |
    | Schema               | Dynamic Schema                    | RDBMS has fixed schema; MongoDB is schema-less (documents in same collection can have different fields). |
    | JOINs                | Embedded documents / $lookup**    | MongoDB avoids joins by nesting documents, but supports $lookup for joining collections.                 |


In RDBMS (SQL  Table format)

    Table: Students

    | StudentID | Name  | Age | Email                                   |
    | --------- | ----- | --- | --------------------------------------- |
    | 101       | Alice | 21  | [alice@mail.com](mailto:alice@mail.com) |
    | 102       | Bob   | 22  | [bob@mail.com](mailto:bob@mail.com)     |


In MongoDB (JSON Documents inside Collection)
    Collection: Students

    { "_id": 101, "Name": "Alice", "Age": 21, "Email": "alice@mail.com" }
    { "_id": 102, "Name": "Bob", "Age": 22, "Email": "bob@mail.com" }


    Key Differences to Notice
        MongoDB uses documents (JSON) instead of rows.
        Collections are schema-less (one student doc could have an extra "Phone" field, while others dont).
        Relationships in RDBMS (via foreign keys) are often modeled in MongoDB as embedded documents or references.

    RDBMS = An Excel spreadsheet (rows & columns).
    MongoDB = A folder of JSON files (each file can look slightly different).