 # MongoDB Indexes
 
 db.collection.getIndexes()

 db.sales.getIndexes()


 --Create an index for a field in a collection
 db.movies.createIndex({title:1})

-- The following query shows the indexes of the movies collection:
 db.movies.getIndexes()

-- To get the information and execution statistics of query plans, you can use the explain() method:
 db.collection.explain()
 
 db.movies.find({
   title: 'Pirates of Silicon Valley'
}).explain('executionStats')

-- MongoDB Drop Index
db.collection.dropIndex(index)

-- db.collection.dropIndex('*') to drop all non-_id indexes. Instead, you use the dropIndexes() method:

Drop an index example

db.movies.createIndex({title:1})

-- db.movies.createIndex({year: 1})

-- Second, show all the indexes of the movies collection by using the getIndexes() method:
db.movies.getIndexes()

-- output
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { year: 1 }, name: 'year_1' }
]

db.movies.dropIndex('year_1')

-- Compound index

db.collection.createIndex({
    field1: type,
    field2: type,
    field3: type,
    ...
});

db.movies.createIndex({ title: 1, year: 1 })

-- MongoDB Unique Index
--  you want to ensure that the values of a field are unique across documents in a collection, such as an email or username.

-- A unique index can help you to enforce this rule. In fact, MongoDB uses a unique index to ensure that the _id is a unique primary key.

db.collection.createIndex({ field: 1}, {unique: true});

--  Create a unique index for a field

db.users.insertMany([
   { email:  "john@test.com", name: "john"},
   { email:  "jane@test.com", name: "jane"},
]);

--Second, create a unique index for the email field:
db.users.createIndex({email:1},{unique:true});
-- Third, attempt to insert a new document with the email that already exists:

db.users.insertOne(
   { email:  "john@test.com", name: "johny"}
);

MongoDB returned the following error:
--MongoServerError: E11000 duplicate key error collection: mflix.users index: email_1 dup key: {

2) Create a unique index for collection with duplicate data

db.users.drop()

db.users.insertMany([
   { email:  "john@test.com", name: "john"},
   { email:  "john@test.com", name: "johny"},
   { email:  "jane@test.com", name: "jane"},
])
-- Second, attempt to create a unique index for the email field of the users collection:

db.users.createIndex({email: 1},{unique:true})

MongoDB returned the following error:
--MongoServerError: Index build failed: 95f78956-d5d0-4882-bfe0-2d856df18c61: Collection mflix.u

First, delete the duplicate user:

db.users.deleteOne({name:'johny', email: 'john@test.com'});

Then, create a unique index for the email field:
db.users.createIndex({email: 1},{unique:true})


# Unique compound index

When a unique index contains more than one field, it is called a unique compound index. A unique compound index ensures the uniqueness of the combination of fields.
db.collection.createIndex({field1: 1, field2: 1}, {unique: true});

db.locations.insertOne({
	address: "Downtown San Jose, CA, USA",
	lat: 37.335480,
	long: -121.893028
})

Second, create a unique compound index for the lat and long fields of the locations collection:

db.locations.createIndex({
	lat: 1,
	long: 1
},{ unique: true });

Third, insert a location with the lat value that already exists:

db.locations.insertOne({
	address: "Dev Bootcamp, San Jose, CA, USA",
	lat: 37.335480,
	long: -122.893028
})

It works because the lat_1_long_1 index only checks the duplicate of the combination of lat and long values.

Finally, attempt to insert a location with the lat and long that already exists:

db.locations.insertOne({
	address: "Central San Jose, CA, USA",
	lat: 37.335480,
	long: -121.893028
})

MongoDB issued the following error:
-- MongoServerError: E11000 duplicate key error collection: mflix.locations index: lat_1_long_1 dup ke