MongoDB updateOne() method

db.collection.updateOne(filter, update, options)

The filter is a document that specifies the criteria for the update. If the filter matches multiple documents, then the updateOne() method updates only the first document. If you pass an empty document {} into the method, it will update the first document returned in the collection.
The update is a document that specifies the change to apply.
The options argument provides some options for updates that won’t be covered in this tutorial.

$set operator
{ $set: { <field1>: <value1>, <field2>: <value2>, ...}}

-- products collection:

db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])

db.products.updateOne(
    {
    _id: 1
    }, 
    {
        $set: 
        {
            price: 899
        }
    })

-- check the update
db.products.findOne({ _id: 1 }, { name: 1, price: 1 })

db.products.find({ price: 899 }, { name: 1, price: 1 })
-- The following example uses the updateOne() method to update the first matching document where the price field is 899:

db.products.updateOne({ price: 899 }, { $set: { price: null } })

db.products.find({ _id: 1}, { name: 1, price: 1 })

updateOne() method to update embedded documents
--The following query uses the find() method to select the document with _id: 4:
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

-- update array elements
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

# MongoDB updateMany() method
db.collection.updateMany(filter, update, options)
{ $set: { <field1>: <value1>, <field2>: <value2>, ...}}
-- products collection:
db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "name" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])

-- MongoDB updateMany() method to update multiple documents
db.products.updateMany(
    {  price: 899}, 
    { $set: {  price: 895 }}
)

-- check
db.products.find({
    price: 895
}, {
    name: 1,
    price: 1
})

-- update embedded documents
db.products.updateMany({
    price: { $gt: 700}
}, {
    $set: {
        "spec.ram": 32,
        "spec.screen": 9.8,
        "spec.cpu": 5.66
    }
})

-- update array elements
db.products.updateMany({
    _id: {
        $in: [1, 2, 3]
    }
}, {
    $set: {
        "storage.0": 16,
        "storage.1": 32
    }
})

# $inc operator
--increment the value of one or more fields by a specified value. In this case, you can use the update() method with the $inc operator.
db.products.updateOne({
    _id: 1
}, {
    $inc: {
        price: 50
    }
})

# $min operator example
-- will not update, The reason is that the new value 699 is greater than the current value 599.
db.products.updateOne({
    _id: 5
}, {
    $min: {
        price: 699
    }
})
-- $min operator to update the price of the document _id 5: 
-- now can update
db.products.updateOne({
    _id: 5
}, {
    $min: {
        price: 499
    }
})

# $max operator -- less value not update

db.products.updateOne({
    _id: 1
}, {
    $max: {
        price: 899
    }
})

# $mul operator -- allows you to multiply the value of a field by a specified number.

 db.products.updateOne({ _id: 5 }, { $mul: { price: 1.1 } })

db.products.find({
    _id: 5
}, {
    name: 1,
    price: 1
})

--$mul to multiply the values of array elements
db.products.updateOne({
    _id: 1
}, {
    $mul: {
        "storage.0": 2,
        "storage.1": 2,
        "storage.2": 2
    }
})

# $unset operator to remove a field from a document
-- unset operator to remove the price field from the document _id 1 in the products collection:
db.products.updateOne({
    _id: 1
}, {
    $unset: {
        price: ""
    }
})

-- remove a field in an embedded document
db.products.updateMany({}, {
    $unset: {
        "spec.ram": ""
    }
})

db.products.find({}, {
    spec: 1
})

# $rename field operator examples

db.products.insertMany([
    { "_id" : 1, "nmea" : "xPhone", "price" : 799, "releaseDate": ISODate("2011-05-14"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 },"color":["white","black"],"storage":[64,128,256]},
    { "_id" : 2, "nmea" : "xTablet", "price" : 899, "releaseDate": ISODate("2011-09-01") , "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 },"color":["white","black","purple"],"storage":[128,256,512]},
    { "_id" : 3, "nmea" : "SmartTablet", "price" : 899, "releaseDate": ISODate("2015-01-14"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 },"color":["blue"],"storage":[16,64,128]},
    { "_id" : 4, "nmea" : "SmartPad", "price" : 699, "releaseDate": ISODate("2020-05-14"),"spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256,1024]},
    { "_id" : 5, "nmea" : "SmartPhone", "price" : 599,"releaseDate": ISODate("2022-09-14"), "spec" : { "ram" : 4, "screen" : 5.7, "cpu" : 1.66 },"color":["white","orange","gold","gray"],"storage":[128,256]}
 ])
-- $rename to rename a field in a document
db.products.updateMany({}, {
    $rename: {
        nmea: "name"
    }
})
-- in embedded documents
db.products.updateMany({}, {
    $rename: {
        "spec.screen": "spec.screenSize"
    }
})

# MongoDB upsert 
Upsert is a combination of update and insert. Upsert performs two functions:
    Update data if there is a matching document.
    Insert a new document in case there is no document matches the query criteria.

document.collection.updateMany(query, update, { upsert: true} )

-- The following query uses the update() method to update the price for the document _id 6:

db.products.updateMany(
    {_id: 6 },
    { $set: {price: 999} }
)
--The query found no match and didn’t update any document as shown in the following output:

db.products.updateMany(
    { _id: 6 },
    { $set: {price: 999} },
    { upsert: true}
)

db.products.find({_id:6})
-- output [ { _id: 6, price: 999 } ]

# MongoDB deleteOne

db.collection.deleteOne(filter, option)

db.products.deleteOne({ _id: 1 })

-- deleteOne() method to delete the first document from a collection
db.products.deleteOne({})

# deleteMany
db.collection.deleteMany(filter, option)

db.products.deleteMany({ price: 899 })

-- deleteMany() method to delete all documents
db.products.deleteMany({})

# MongoDB $exists operator
{ field: { $exists: <boolean_value> } }
-- $exists operator to select documents where the price field exists:
db.products.find(
   {
 price: {
 $exists: true
 } 
}, 
   {
 name: 1,
 price: 1
 }
)
--  select documents whose price field exists and has a value greater than 799:
db.products.find({
    price: {
        $exists: true,
        $gt: 699
    }
}, {
    name: 1,
    price: 1
});


# MongoDB $type

Sometimes, you need to deal with highly unstructured data where data types are unpredictable. In this case, you need to use the $type operator.

The $type is an element query operator that allows you to select documents where the value of a field is an instance of a specified BSON type.

The $type operator has the following syntax:

{ field: { $type: <BSON type> } }

{ field: { $type: [ <BSON type1> , <BSON type2>, ... ] } }

-- MongoDB provides you with three ways to identify a BSON type: string, number, and alias. The following table lists the BSON types identified by these three forms:

Type	Number	Alias
Double	1	“double”
String	2	“string”
Object	3	“object”
Array	4	“array”
Binary data	5	“binData”
ObjectId	7	“objectId”
Boolean	8	“bool”
Date	9	“date”
Null	10	“null”
Regular Expression	11	“regex”
JavaScript	13	“javascript”
32-bit integer	16	“int”
Timestamp	17	“timestamp”
64-bit integer	18	“long”
Decimal128	19	“decimal”
Min key	-1	“minKey”
Max key	127	“maxKey”

The $type operator also supports the number alias that matches against the following BSON types:

double
32-bit integer
64-bit integer
decimal

-- example
--price field is the string type or is an array containing an element that is a string type.
db.products.find({
    price: {
        $type: "string"
    }
}, {
    name: 1,
    price: 1
})

-- Since the string type corresponds to the number 2 (see the BSON types table above), you can use the number 2 in the query instead:
db.products.find({
    price: {
        $type: 2
    }
}, {
    name: 1,
    price: 1
})

--array type example
db.products.find({
    price: {
        $type: "array"
       -- $type: ["number", "string"]
    }
}, {
    name: 1,
    price: 1
})


#  $size operator

-- The $size is an array query operator that allows you to select documents that have an array containing a specified number of elements.

db.products.find({
    color: {
        $size: 2
    }
}, {
    name: 1,
    color: 1
})
-- output
{ "_id" : 1, "color" : [ "white", "black" ], "name" : "xPhone" }


-- $all operator 
db.products.find({
    color: {
        $all: ["black", "white"]
    }
}, {
    name: 1,
    color: 1
})
--output 
{ "_id" : 1, "name" : "xPhone", "color" : [ "white", "black" ] }
{ "_id" : 2, "name" : "xTablet", "color" : [ "white", "black", "purple" ] }

# $elemMatch
--The $elemMatch is an array query operator that matches documents that contain an array field and the array field has at least one element that satisfies all the specified queries.
db.products.find({
    storage: {
        $elemMatch: {
            $lt: 128
        }
    }
}, {
    name: 1,
    storage: 1
});

-- output
[
  { _id: 1, name: 'xPhone', storage: [ 64, 128, 256 ] },
  { _id: 3, name: 'SmartTablet', storage: [ 16, 64, 128 ] }
]


