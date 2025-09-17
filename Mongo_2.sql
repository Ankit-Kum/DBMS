Introduction to NoSQL Databases

    Databases can be divided in 3 types:

        RDBMS (Relational Database Management System)
        OLAP (Online Analytical Processing)
        NoSQL (recently developed database)

NoSQL Database
    NoSQL Database is used to refer a non-SQL or non relational database.

    It provides a mechanism for storage and retrieval of data other than tabular relations model used in relational databases. NoSQL database doesnt use tables for storing data. It is generally used to store big data and real-time web applications.

MongoDB is a document-oriented database. It uses the concept of the document to store data, which is more flexible than the row concept in the relational database management system (RDBMS).
A document allows you to represent complex hierarchical relationships with a single record.
MongoDB doesnt require predefined schemas that allow you to add to or remove fields from documents more quickly.



/*
MongoDB is a NoSQL database that stores data in flexible, JSON-like documents. Unlike traditional relational databases that use tables, rows, and columns, MongoDB uses collections (similar to tables) and documents (similar to rows). This document-oriented approach is well-suited for handling unstructured or semi-structured data and offers high scalability and flexibility.
*/
A NoSQL database is a database that provides a 
mechanism for storing and retrieving data that is 
modeled in ways other than the tabular relations 
used in traditional relational databases (SQL). 
NoSQL, which stands for "not only SQL," is a 
category of databases designed to handle modern 
application needs like massive volumes of data, 
real-time analytics, and flexible schema.

Unlike relational databases that store data in a fixed, predefined tabular format, NoSQL databases use flexible data models. This makes them ideal for handling unstructured and semi-structured data, which is common in web applications, social media, and the Internet of Things (IoT).

The most common types of NoSQL databases are:

    Document databases: Store data in flexible, JSON-like documents. (e.g., MongoDB, CouchDB)

    Key-value databases: The simplest form, they store data as a collection of key-value pairs. (e.g., Redis, Amazon DynamoDB)

    Wide-column stores: Store data in columns rather than rows, allowing for efficient querying of specific columns. (e.g., Apache Cassandra, HBase)

    Graph databases: Use nodes and edges to represent and store data, which is great for visualizing and querying relationships. (e.g., Neo4j)

Key Concepts 
    Database:   A physical container for collections. 
                A single MongoDB server can host multiple databases.
    Collection: A group of documents. 
                Its the equivalent of a table in a relational database. Collections do not enforce a schema, 
                so documents within the same collection can have different fields.
    Document:   A set of key-value pairs, 
                which is the basic unit of data in MongoDB. Documents are similar to rows or records in a relational database, 
                but they can contain nested fields and arrays.

Features of NoSQL Databases 

    NoSQL databases are popular for their features that address the limitations of traditional relational databases in a distributed computing environment.

    Flexible Schema: NoSQL databases dont require a rigid, predefined schema. This means you can store documents with different structures in the same collection. This flexibility is perfect for agile development and for applications where data models evolve rapidly.

    Horizontal Scalability: While relational databases typically scale vertically (adding more power to a single server), NoSQL databases scale horizontally by distributing the data across multiple servers (or "nodes"). This makes it easy and cost-effective to handle massive amounts of data and high user traffic.

    High Performance: By relaxing some of the data consistency rules and avoiding complex joins, NoSQL databases are optimized for fast read and write operations, which is crucial for real-time applications and big data processing.

    High Availability: Many NoSQL databases are designed with a distributed architecture and automatic data replication across nodes. This means there is no single point of failure; if one server goes down, the database remains available.

    Developer-Friendly: NoSQL databases are often designed to work seamlessly with modern programming languages and frameworks. Their flexible data models, such as JSON-like documents, align well with the data structures used in application code, simplifying the development process.



# mongo shell
The mongo shell is an interactive JavaScript interface to MongoDB. The mongo shell allows you to manage data in MongoDB as well as carry out administrative tasks.

mongosh

show dbs: Lists all databases on the server.

use <database_name>: Switches to a specified database. If the database doesnt exist, MongoDB creates it when you first save data to it.

db: Shows the name of the current database.

show collections: Lists all collections in the current database.

db.<collection_name>.insertOne(<document>): Inserts a single document into a collection.

db.<collection_name>.find(): Retrieves all documents from a collection.

db.<collection_name>.updateOne(<query>, <update>): Updates a single document that matches the query.

db.<collection_name>.deleteOne(<query>): Deletes a single document that matches the query.

-- you can use the shows dbs command to list all the databases on the server:

test> show dbs
admin        41 kB
config     73.7 kB
local      81.9 kB

-- command switches the current database to the bookdb database:

test> use bookdb
            switched to db bookdb

The mongo shell now assigns bookdb to the db variable:

> db
bookdb

Now, you can access the books collection from the bookstore database via the db variable like this:

> db.books
bookstore.books


# Data Types

Null

{ 
   "isbn": null 
}

Boolean

{ 
   "best_seller": true 
}

Number -- By default, the mongo shell uses the 64-bit floating-point numbers. For example:

{ 
    "price": 9.95, 
    "pages": 851 
}

-- The NumberInt and NumberLong classes represent 4-byte and 8-byte integers respectively. For example:
{
   "year": NumberInt("2020"),
   "words": NumberLong("95403")
}

String

{
   "title": "MongDB Data Types"
}

Date -- The date type stores dates as 64-bit integers that represents milliseconds since the Unix epoch (January 1, 1970). 
-- It does not store the time zone. For example:

{
    "updated_at":  new Date()
}

Object ID 

in MongoDB, every document has an "_id" key. 
The value of the "_id" key can be any type. 
However, it defaults to an ObjectId.

--The ObjectId class is the default type for "_id". 
--It is used to generate unique values globally across servers

The ObjectId uses 12 bytes for storage, The 12-byte ObjectId value consists of:

    A 4-byte timestamp value that represents the ObjectId‘s generated time measured in seconds since the Unix epoch.
    A 5-byte random value.
    A 3-byte increment counter, initialized to a random value.

-- db.createCollection(name, options)
    /* Name: is a string type, specifies the name of the collection to be created.
    Options: is a document type, specifies the memory size and indexing of the collection. It is an optional parameter.
    Following is the list of options that can be used. 
    db.createCollection("SSSIT")
    show collections
    */

# MongoDB insertOne

-- The insertOne() method allows you to insert a single document into a collection.

db.collection.insertOne(
   <document>,
   { writeConcern: <document>}
)


mongosh bookdb

db.books.insertOne({ 
    title: 'insertOne',
    isbn: '0-7617-6154-3'
});

To select the document that you have inserted, you can use the find() method like this:

db.books.find()

-- Insert a document with an _id field example

db.books.insertOne({
   _id: 1,
   title: "Mastering Big Data",
   isbn: "0-9270-4986-4"
});

-- nsert another document whose _id field already exists into the books collection:

db.books.insertOne({
   _id: 1,
   title: "Developers",
   isbn: "0-4925-3790-9"
});

Since the _id: 1 already exists, MongoDB threw the following exception:

# MongoDB insertMany() method

db.collection.insertMany(
   [document1, document2, ...],
   {
      writeConcern: <document>,
      ordered: <boolean>
   }
)

The writeConcern specifies the write concern. If you omit it, the insertMany() method will use the default write concern.
The ordered is a boolean value that determines whether MongoDB should perform an ordered or unordered insert.
When the ordered is set to true, the insertMany() method inserts documents in order. This is also the default option.
If the ordered is set to false, MongoDB may reorder the documents before inserts to increase performance.

mongosh bookdb

db.books.insertMany([
   { title:  "NoSQL Distilled", isbn: "0-4696-7030-4"},
   { title:  "NoSQL ", isbn: "0-4086-6859-8"},
   { title:  "NoSQL Database", isbn: "0-2504-6932-4"},
]);

mongosh products

db.products.insertMany([
  { name: "Laptop", brand: "HP", price: 1200 },
  { name: "Mouse", brand: "Logitech", price: 25 },
  { name: "Keyboard", brand: "Razer", price: 100 }
])

--if an error occurred when inserting the "Mouse" document, the "Keyboard" would not be inserted

Insert with ordered: false:

db.products.insertMany(
  [
    { name: "Monitor", brand: "Dell", price: 300 },
    { name: "Headphones", brand: "Sony", price: 150 }
  ],
  { ordered: false }
)

-- To retrieve the inserted documents, you use the find() method like this:

db.books.find()

-- Using MongoDB insertMany() method to insert multiple documents with _id fields

db.books.insertMany([
   { _id: 1, title:  "SQL Basics", isbn: "0-7925-6962-8"},
   { _id: 2, title:  "SQL Advanced", isbn: "0-1184-7778-1"}
]);

db.books.insertMany([
   { _id: 2, title:  "SQL Performance Tuning", isbn: "0-6799-2974-6"},
   { _id: 3, title:  "SQL Index", isbn: "0-5097-1723-3"}
]); -- error

-- Unordered insert example
db.books.insertMany(
   [{ _id: 3, title:  "SQL Performance Tuning", isbn: "0-6799-2974-6"},
   { _id: 3, title:  "SQL Trees", isbn: "0-6998-1556-8"},
   { _id: 4, title:  "SQL Graph", isbn: "0-6426-4996-0"},
   { _id: 5, title:  "NoSQL Pros", isbn: "0-9602-9886-X"}], 
   { ordered: false }
);

In this example, the _id: 3 is duplicated, MongoDB threw an error.

Since this example used the unordered insert, the operation continued to insert the documents with _id 4 and 5 into the books collection.

The following statement retrieves the inserted documents:

db.books.find()

# MongoDB findOne() method

The findOne() returns a single document from a collection that satisfies the specified condition.

The findOne() method has the following syntax:

db.collection.findOne(query, projection)

    The query is a document that specifies the selection criteria.
    The projection is a document that specifies the fields in the matching document that you want to return.

If you omit the query, the findOne() returns the first document in the collection according to the natural order which is the order of documents on the disk.
If you dont pass the projection argument, then findOne() will include all fields in the matching documents.

db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])

db.products.findOne()
-- db.products.findOne({})  --same

--MongoDB findOne() method with a filter
db.products.findOne({_id:2})

-- Using MongoDB findOne() method to select some fields
--  find the document with _id 5. And it returns only the _id and name fields of the matching document:

db.products.findOne({_id: 5}, {name: 1})

-- To completely remove it from the returned document, you need to explicitly specify _id:0 in the projection document like this:

db.products.findOne({ _id: 5 }, {name: 1, _id: 0})

# MongoDB find() method

db.collection.find(query, projection)

1) query
The query is a document that specifies the criteria for selecting documents from the collection. If you omit the query or pass an empty document({}), the find() returns a cursor that returns all documents in the collection.

2) projection
The projection is a document that specifies the fields in the matching documents to return. If you omit the projection argument, the find() method returns all fields in the matching documents.

db.books.insertMany([
	{ "_id" : 1, "title" : "Unlocking Android", "isbn" : "1933988673", "categories" : [ "Open Source", "Mobile" ] },
	{ "_id" : 2, "title" : "Android in Action, Second Edition", "isbn" : "1935182722", "categories" : [ "Java" ] },
	{ "_id" : 3, "title" : "Specification by Example", "isbn" : "1617290084", "categories" : [ "Software Engineering" ] },
	{ "_id" : 4, "title" : "Flex 3 in Action", "isbn" : "1933988746", "categories" : [ "Internet" ] },
	{ "_id" : 5, "title" : "Flex 4 in Action", "isbn" : "1935182420", "categories" : [ "Internet" ] },
	{ "_id" : 6, "title" : "Collective Intelligence in Action", "isbn" : "1933988312", "categories" : [ "Internet" ] },
	{ "_id" : 7, "title" : "Zend Framework in Action", "isbn" : "1933988320", "categories" : [ "Web Development" ] },
	{ "_id" : 8, "title" : "Flex on Java", "isbn" : "1933988797", "categories" : [ "Internet" ] },
	{ "_id" : 9, "title" : "Griffon in Action", "isbn" : "1935182234", "categories" : [ "Java" ] },
	{ "_id" : 10, "title" : "OSGi in Depth", "isbn" : "193518217X", "categories" : [ "Java" ] },
	{ "_id" : 11, "title" : "Flexible Rails", "isbn" : "1933988509", "categories" : [ "Web Development" ] },
	{ "_id" : 13, "title" : "Hello! Flex 4", "isbn" : "1933988762", "categories" : [ "Internet" ] },
	{ "_id" : 14, "title" : "Coffeehouse", "isbn" : "1884777384", "categories" : [ "Miscellaneous" ] },
	{ "_id" : 15, "title" : "Team Foundation Server 2008 in Action", "isbn" : "1933988592", "categories" : [ "Microsoft .NET" ] },
	{ "_id" : 16, "title" : "Brownfield Application Development in .NET", "isbn" : "1933988711", "categories" : [ "Microsoft" ] },
	{ "_id" : 17, "title" : "MongoDB in Action", "isbn" : "1935182870", "categories" : [ "Next Generation Databases" ] },
	{ "_id" : 18, "title" : "Distributed Application Development with PowerBuilder 6.0", "isbn" : "1884777686", "categories" : [ "PowerBuilder" ] },
	{ "_id" : 19, "title" : "Jaguar Development with PowerBuilder 7", "isbn" : "1884777864", "categories" : [ "PowerBuilder", "Client-Server" ] },
	{ "_id" : 20, "title" : "Taming Jaguar", "isbn" : "1884777686", "categories" : [ "PowerBuilder" ] },
	{ "_id" : 21, "title" : "3D User Interfaces with Java 3D", "isbn" : "1884777902", "categories" : [ "Java", "Computer Graphics" ] },
	{ "_id" : 22, "title" : "Hibernate in Action", "isbn" : "193239415X", "categories" : [ "Java" ] },
	{ "_id" : 23, "title" : "Hibernate in Action (Chinese Edition)", "categories" : [ "Java" ] },
	{ "_id" : 24, "title" : "Java Persistence with Hibernate", "isbn" : "1932394885", "categories" : [ "Java" ] },
	{ "_id" : 25, "title" : "JSTL in Action", "isbn" : "1930110529", "categories" : [ "Internet" ] },
	{ "_id" : 26, "title" : "iBATIS in Action", "isbn" : "1932394826", "categories" : [ "Web Development" ] },
	{ "_id" : 27, "title" : "Designing Hard Software", "isbn" : "133046192", "categories" : [ "Object-Oriented Programming", "S" ] },
	{ "_id" : 28, "title" : "Hibernate Search in Action", "isbn" : "1933988649", "categories" : [ "Java" ] },
	{ "_id" : 29, "title" : "jQuery in Action", "isbn" : "1933988355", "categories" : [ "Web Development" ] },
	{ "_id" : 30, "title" : "jQuery in Action, Second Edition", "isbn" : "1935182323", "categories" : [ "Java" ] }
]);

-- MongoDB find() method to retrieve all documents from a collection

db.books.find()
-- the statement returns the first 20 documents with all available fields in the matching documents.
-- press enter, you’ll see the next 20 documents.
db.books.find({_id: 10})
-- The statement returns the document whose _id is 10. Since it doesn’t have the projection argument, the returned document includes all available fields:

--Using MongoDB find() method to return selected fields

db.books.find({ categories: 'Java'}, { title: 1,isbn: 1})

-- To remove the _id field from the matching documents, you need to explicitly specify _id: 0 in the projection argument like this:
db.books.find({ categories: 'Java'}, { title: 1,isbn: 1,_id: 0})

# Introduction to the MongoDB projection

In MongoDB, projection simply means selecting fields to return from a query.

By default, the find() and findOne() methods return all fields in matching documents. 
Most of the time you don’t need data from all the fields.


{ <field>: value, ...}

If the value is 1 or true, the <field> is included in the matching documents. 
In case the value is 0 or false, it is suppressed from the returned documents.

If the projection document is empty {}, all the available fields will be included in the returned documents.

--To specify a field in an embedded document, you use the following dot notation:

{ "<embeddedDocument>.<field>": value, ... }

# projection examples

db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256],"inventory":[{ qty: 1200,"warehouse": "San Jose"}]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512],"inventory":[{ qty: 300,"warehouse": "San Francisco"}]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128],"inventory":[{ qty: 400,"warehouse": "San Jose"},{ qty: 200,"warehouse": "San Francisco"}]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024],"inventory":[{ qty: 1200,"warehouse": "San Mateo"}]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])

--1) Returning all fields in matching documents

-- the following query returns all fields from all documents in the products collection where the price is 899:

db.products.find({price: 899});

-- 2) Returning specified fields including the _id field

If you specify the fields in the projection document, the find() method will return only these fields including the _id field by default.
-- The following example returns all documents from the products collection. However, its result includes only the name, price, and _id field in the matching documents:
db.products.find({}, {
    name: 1,
    price: 1
});

--To suppress the _id field, you need to explicitly specify it in the projection document like this:
db.products.find({}, {
    name: 1,
    price: 1
,
    _id: 0
});

3) Returning all fields except for some fields

-- If the number of fields to return is many, you can use the projection document to exclude other fields instead.

-- The following example returns all fields of the document _id 1 except for releaseDate, spec, and storage fields:

db.products.find({_id:1}, {
    releaseDate: 0,
    spec: 0,
    storage: 0
})

4) Returning fields in embedded documents

-- The following example returns the name, price, and _id fields of document _id 1. It also returns the screen field on the spec embedded document:
db.products.find({_id:1}, {
    name: 1,
    price: 1,
    "spec.screen": 1
})

-- MongoDB 4.4 and later allows you to specify embedded fields using the nested form like this:

db.products.find({_id:1}, {
    name: 1,
    price: 1,
    spec : { screen: 1 }
})

5) Projecting fields on embedded documents in an array
The following example specifies a projection that returns:
    the _id field (by default)
    The name field
    And qty field in the documents embedded in the inventory array.

db.products.find({}, {
    name: 1,
    "inventory.qty": 1
});

# Comparison Query Operators

-- MongoDB $eq operator

-- The $eq operator is a comparison query operator that allows you to match documents where the value of a field equals a specified value.

{ <field>: { $eq: <value> } }

db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])

1) Using $eq operator to check if a field equals a specified value

db.products.find({
    price: {
        $eq: 899
    }
}, {
    name: 1,
    price: 1
})

The query is equivalent to the following:
/*db.products.find({
    price: 899
}, {
    name: 1,
    price: 1
})*/

2) Using the $eq operator to check if a field in an embedded document equals a value
The following example uses the $eq operator to search for documents where the value of the ram field in the spec document equals 4:

db.products.find({
    "spec.ram": {
        $eq: 4
    }
}, {
    name: 1,
    "spec.ram": 1
})

It is equivalent to the following:

/*db.products.find({
    "spec.ram": 4

}, {
    name: 1,
    "spec.ram": 1
})*/

3) Using $eq operator to check if an array element equals a value

db.products.find({
    color: {
        $eq: "black"
    }
}, {
    name: 1,
    color: 1
})

4) Using $eq operator to check if a field equals a date

--The following example uses the $eq operator to select documents in the widget collection with the published date is 2020-05-14:

db.products.find({
    releaseDate: {
        $eq: new ISODate("2020-05-14")
    }
}, {
    name: 1,
    releaseDate: 1
})

# MongoDB $lt -- a field is less than (<) a specified value.

db.products.find({
    price: {
        $lt: 799
    }
}, {
    name: 1,
    price: 1
})

# $lte operator -- equal to ( <= ) a specified value.

db.products.drop();
db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ]);


 db.products.find({
    price: {
        $lte: 799
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $gt operator 

db.products.find({
    price: {
        $gt: 699
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $gte operator --  greater than 

db.products.find({
    price: {
        $gte: 799
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $ne operator -- not equal to

db.products.find({
    price: {
        $ne: 899
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $in operator

db.products.find({
    price: {
        $in: [699, 799]
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $nin operator -- (Not In)

db.products.find({
    price: {
        $nin: [699, 799]
    }
}, {
    name: 1,
    price: 1
})

# Logical Query Operators
 -- MongoDB $and operator
 $and :[{expression1}, {expression2},...]

 db.products.insertMany([
	{ "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate" : ISODate("2011-05-14T00:00:00Z"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 }, "color" : [ "white", "black" ], "storage" : [ 64, 128, 256 ] },
	{ "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate" : ISODate("2011-09-01T00:00:00Z"), "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 }, "color" : [ "white", "black", "purple" ], "storage" : [ 128, 256, 512 ] },
	{ "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate" : ISODate("2015-01-14T00:00:00Z"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 }, "color" : [ "blue" ], "storage" : [ 16, 64, 128 ] },
	{ "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate" : ISODate("2020-05-14T00:00:00Z"), "spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 }, "color" : [ "white", "orange", "gold", "gray" ], "storage" : [ 128, 256, 1024 ] },
	{ "_id" : 5, "name" : "SmartPhone", "price" : 599, "releaseDate" : ISODate("2022-09-14T00:00:00Z"), "spec" : { "ram" : 4, "screen" : 9.7, "cpu" : 1.66 }, "color" : [ "white", "orange", "gold", "gray" ], "storage" : [ 128, 256 ] },
	{ "_id" : 6, "name" : "xWidget", "spec" : { "ram" : 64, "screen" : 9.7, "cpu" : 3.66 }, "color" : [ "black" ], "storage" : [ 1024 ] }
])

$and operator to select all documents in the products collection where:


        the value in the price field is equal to 899 and
        the value in the color field is either "white" or "black"

db.products.find({
    $and: [{
        price: 899
    }, {
        color: {
            $in: ["white", "black"]
        }
    }]
}, {
    name: 1,
    price: 1,
    color: 1
})

-- $or operator example

db.products.find({
    $or: [{
        price: 799
    }, {
        price: 899
    }]
}, {
    name: 1,
    price: 1
})

# MongoDB $not operator

{ field: { $not: { <expression> } } }

The following example shows how to use the $not operator to find documents where:

the price field is not greater than 699.
do not contain the price field.

db.products.find({
    price: {
        $not: {
            $gt: 699
        }
    }
}, {
    name: 1,
    price: 1
})

# MongoDB $nor
{ $nor: [ { <expression1> }, { <expression2> },...] }

db.products.find({
    $nor :[
        { price: 899},
        { color: "gold"}
    ]
}, {
    name: 1,
    price: 1, 
    color: 1
})

It returns documents where:
    the value is the price field is not 899
    and the color array does not have any "gold" element.

# Updating Documents

db.collection.updateOne(filter, update, options)

The filter is a document that specifies the criteria for the update. If the filter matches multiple documents, then the updateOne() method updates only the first document. If you pass an empty document {} into the method, it will update the first document returned in the collection.
The update is a document that specifies the change to apply.
The options argument provides some options for updates that won’t be covered in this tutorial.

$set operator
{ $set: { <field1>: <value1>, <field2>: <value2>, ...}}

-- 1) Using the MongoDB updateOne() method to update a single document

db.products.updateOne({
    _id: 1
}, {
    $set: {
        price: 899
    }
})

db.products.findOne({ _id: 1 }, { name: 1, price: 1 })

-- 2) Using the MongoDB updateOne() method to update the first matching document

db.products.find({ price: 899 }, { name: 1, price: 1 })
The following example uses the updateOne() method to update the first matching document where the price field is 899:

db.products.updateOne({ price: 899 }, { $set: { price: null } })

db.products.find({ _id: 1}, { name: 1, price: 1 })

-- 3) Using the updateOne() method to update embedded document

db.products.find({ _id: 4 }, { name: 1, spec: 1 })

db.products.updateOne({
    _id: 4
}, {
    $set: {
        "spec.ram": 16,
        "spec.screen": 10.7,
        "spec.cpu": 2.66
    }
})

db.products.find({ _id: 4 }, { name: 1, spec: 1 })

-- 4) Using the MongoDB updateOne() method to update array elements
The following example uses the updateOne() method to update the first and second elements of the storage array in the document with _id 4:

db.products.updateOne(
 { _id: 4}, 
 {
    $set: {
        "storage.0": 16,
        "storage.1": 32
    }
 }
)

db.products.find({ _id: 4 }, { name: 1, storage: 1 });