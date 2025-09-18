MongoDB sort

cursor.sort({field1: order, field2: order, ...})

-- The sort() method allows you to sort the matching documents by one or more fields (field1, field2, …) in ascending or descending order.

-- The order takes two values: 1 and -1. If you specify { field: 1 }, the sort() will sort the matching documents by the field in ascending order:

cursor.sort({ field: 1 })
cursor.sort({field: -1})
cursor.sort({field1: 1, field2: -1});

db.products.insertMany([
    { "_id" : 1, "name" : "xPhone", "price" : 799, "releaseDate" : ISODate("2011-05-14T00:00:00Z"), "spec" : { "ram" : 4, "screen" : 6.5, "cpu" : 2.66 }, "color" : [ "white", "black" ], "storage" : [ 64, 128, 256 ] },
    { "_id" : 2, "name" : "xTablet", "price" : 899, "releaseDate" : ISODate("2011-09-01T00:00:00Z"), "spec" : { "ram" : 16, "screen" : 9.5, "cpu" : 3.66 }, "color" : [ "white", "black", "purple" ], "storage" : [ 128, 256, 512 ] },
    { "_id" : 3, "name" : "SmartTablet", "price" : 899, "releaseDate" : ISODate("2015-01-14T00:00:00Z"), "spec" : { "ram" : 12, "screen" : 9.7, "cpu" : 3.66 }, "color" : [ "blue" ], "storage" : [ 16, 64, 128 ] },
    { "_id" : 4, "name" : "SmartPad", "price" : 699, "releaseDate" : ISODate("2020-05-14T00:00:00Z"), "spec" : { "ram" : 8, "screen" : 9.7, "cpu" : 1.66 }, "color" : [ "white", "orange", "gold", "gray" ], "storage" : [ 128, 256, 1024 ] },
    { "_id" : 5, "name" : "SmartPhone", "price" : 599, "releaseDate" : ISODate("2022-09-14T00:00:00Z"), "spec" : { "ram" : 4, "screen" : 9.7, "cpu" : 1.66 }, "color" : [ "white", "orange", "gold", "gray" ], "storage" : [ 128, 256 ] },
    { "_id" : 6, "name" : "xWidget", "spec" : { "ram" : 64, "screen" : 9.7, "cpu" : 3.66 }, "color" : [ "black" ], "storage" : [ 1024 ] },
    { "_id" : 7, "name" : "xReader", "price" : null, "spec" : { "ram" : 64, "screen" : 6.7, "cpu" : 3.66 }, "color" : [ "black", "white" ], "storage" : [ 128 ] }
])

-- 1) Sorting document by one field example
db.products.find({
    'price': {
        $exists: 1
    }
}, {
    name: 1,
    price: 1
})

-- output 
[
  { _id: 1, name: 'xPhone', price: 799 },
  { _id: 2, name: 'xTablet', price: 899 },
  { _id: 3, name: 'SmartTablet', price: 899 },
  { _id: 4, name: 'SmartPad', price: 699 },
  { _id: 5, name: 'SmartPhone', price: 599 },
  { _id: 7, name: 'xReader', price: null }
]
-- To sort the products by prices in ascending order, you use the sort() method like this:
db.products.find({
    'price': {
        $exists: 1
    }
}, {
    name: 1,
    price: 1
}).sort({price: 1})
-- }).sort({price: -1})

-- Sorting document by two or more fields example
db.products.find({
    'price': {
        $exists: 1
    }
}, {
    name: 1,
    price: 1
}).sort({price: 1,name: 1});
--}).sort({price: 1,name: -1});
-- the sort() method sorts the products by prices first. Then it sorts the sorted result set by names

-- Sorting documetns by dates
db.products.find({
    releaseDate: {
        $exists: 1
    }

}, {
    name: 1,
    releaseDate: 1
}).sort({releaseDate: 1});

-- by fields in embedded documents
db.products.find({}, {
    name: 1,
    spec: 1
}).sort({
    "spec.ram": 1
});

#MongoDB limit
db.collection.find(<query>).limit(<documentCount>)

--limit() to get the most expensive product

db.products.find({}, {
    name: 1,
    price: 1
}).sort({
    price: -1
}).limit(1);

--output 
[ { _id: 2, name: 'xTablet', price: 899 } ]

-- limit() and skip() to get the paginated result

db.products.find({}, {
    name: 1,
    price: 1
}).sort({
    price: -1,
    name: 1
}).skip(2).limit(2);

-- output
[
  { _id: 1, name: 'xPhone', price: 799 },
  { _id: 4, name: 'SmartPad', price: 699 }
]




###### Aggregation ########

db.sales.insertMany([
	{ "_id" : 1, "item" : "Americanos", "price" : 5, "size": "Short", "quantity" : 22, "date" : ISODate("2022-01-15T08:00:00Z") },
	{ "_id" : 2, "item" : "Cappuccino", "price" : 6, "size": "Short","quantity" : 12, "date" : ISODate("2022-01-16T09:00:00Z") },
	{ "_id" : 3, "item" : "Lattes", "price" : 15, "size": "Grande","quantity" : 25, "date" : ISODate("2022-01-16T09:05:00Z") },
	{ "_id" : 4, "item" : "Mochas", "price" : 25,"size": "Tall", "quantity" : 11, "date" : ISODate("2022-02-17T08:00:00Z") },
	{ "_id" : 5, "item" : "Americanos", "price" : 10, "size": "Grande","quantity" : 12, "date" : ISODate("2022-02-18T21:06:00Z") },
	{ "_id" : 6, "item" : "Cappuccino", "price" : 7, "size": "Tall","quantity" : 20, "date" : ISODate("2022-02-20T10:07:00Z") },
	{ "_id" : 7, "item" : "Lattes", "price" : 25,"size": "Tall", "quantity" : 30, "date" : ISODate("2022-02-21T10:08:00Z") },
	{ "_id" : 8, "item" : "Americanos", "price" : 10, "size": "Grande","quantity" : 21, "date" : ISODate("2022-02-22T14:09:00Z") },
	{ "_id" : 9, "item" : "Cappuccino", "price" : 10, "size": "Grande","quantity" : 17, "date" : ISODate("2022-02-23T14:09:00Z") },
	{ "_id" : 10, "item" : "Americanos", "price" : 8, "size": "Tall","quantity" : 15, "date" : ISODate("2022-02-25T14:09:00Z")}
]);

# $sum example

db.sales.aggregate([
  {
    $group: {
      _id: null,
      totalQty: { $sum: '$quantity' },
    },
  },
]);

-- outpput
[ { _id: null, totalQty: 185 } ]

--Using mongoDB $sum to calculcate the sum of groups
-- The following example uses the $sum to calculate the sum of quantity grouped by items:
db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      totalQty: { $sum: '$quantity' },
    },
  },
]);

--output
[
  { _id: 'Cappuccino', totalQty: 49 },
  { _id: 'Lattes', totalQty: 55 },
  { _id: 'Americanos', totalQty: 70 },
  { _id: 'Mochas', totalQty: 11 }
]

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      totalQty: { $sum: '$quantity' },
    },
  },
  { $sort: { totalQty: -1 } },
]);

-- output 
[
  { _id: 'Americanos', totalQty: 70 },
  { _id: 'Lattes', totalQty: 55 },
  { _id: 'Cappuccino', totalQty: 49 },
  { _id: 'Mochas', totalQty: 11 }
]

-- $sum with $match example
db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      totalQty: { $sum: '$quantity' },
    },
  },
  { $match: { totalQty: { $gt: 50 } } },
  { $sort: { totalQty: -1 } },
]);

-- output 
[
  { _id: 'Americanos', totalQty: 70 },
  { _id: 'Lattes', totalQty: 55 }
]


-- $sum with an expression

db.sales.aggregate([
  {
    $group: {
      _id: '$size',
      totalAmount: { $sum: { $multiply: ['$price', '$quantity'] } },
    },
  },
  { $sort: { totalAmount: -1 } },
]);


-- output 
[
  { _id: 'Tall', totalAmount: 1285 },
  { _id: 'Grande', totalAmount: 875 },
  { _id: 'Short', totalAmount: 182 }
]

# $count
{ $count: {} }
-- Note that the $count does not accept any parameters.
-- $count to count the number of documents per group example
db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      itemCount: { $count: {} },
    },
  },
])

-- Output
[
  { _id: 'Mochas', itemCount: 1 },
  { _id: 'Americanos', itemCount: 4 },
  { _id: 'Lattes', itemCount: 2 },
  { _id: 'Cappuccino', itemCount: 3 }
]

-- $count with the $match example
db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      itemCount: { $count: {} },
    },
  },
  {
    $match: { itemCount: { $gt: 2 } },
  },
]);

-- output 
[
  { _id: 'Americanos', itemCount: 4 },
  { _id: 'Cappuccino', itemCount: 3 }
]

# $avg

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      averageQty: { $avg: '$quantity' },
    },
  },
]);

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      averageAmount: { $avg: { $multiply: ['$quantity', '$price'] } },
    },
  },
  { $sort: { averageAmount: 1 } },
])

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      averageAmount: { $avg: { $multiply: ['$quantity', '$price'] } },
    },
  },
  { $match: { averageAmount: { $gt: 150 } } },
  { $sort: { averageAmount: 1 } },
]);


# $max $min

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      maxQty: { $max: '$quantity' },
    },
  },
]);

db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      maxQty: { $max: { $multiply: ['$quantity', '$price'] } },
    },
  },
]);


db.sales.aggregate([
  {
    $group: {
      _id: '$item',
      maxQty: { $min: { $multiply: ['$quantity', '$price'] } },
    },
  },
]);


MongoDB aggregation operations allow you to process multiple documents and return the calculated results.

Typically, you use aggregation operations to group documents by specific field values and perform aggregations on the grouped documents to return computed results.

For example, you can use aggregation operations to take a list of sales orders and calculate the total sales amounts grouped by the products.

To perform aggregation operations, you use aggregation pipelines. An aggregation pipeline contains one or more stages that process the input documents:

Each stage in the aggregation pipeline performs an operation on the input documents and returns the output documents
The operations on each stage can be one of the following:

$project  select fields for the output documents.
$match select documents to be processed.
$limit  limit the number of documents to be passed to the next stage.
$skip  skip a specified number of documents.
$sort  sort documents.
$group  group documents by a specified key.

db.collection.aggregate([{ $match:...},{$group:...},{$sort:...}]);

use coffeeshop

db.sales.insertMany([
	{ "_id" : 1, "item" : "Americanos", "price" : 5, "size": "Short", "quantity" : 22, "date" : ISODate("2022-01-15T08:00:00Z") },
	{ "_id" : 2, "item" : "Cappuccino", "price" : 6, "size": "Short","quantity" : 12, "date" : ISODate("2022-01-16T09:00:00Z") },
	{ "_id" : 3, "item" : "Lattes", "price" : 15, "size": "Grande","quantity" : 25, "date" : ISODate("2022-01-16T09:05:00Z") },
	{ "_id" : 4, "item" : "Mochas", "price" : 25,"size": "Tall", "quantity" : 11, "date" : ISODate("2022-02-17T08:00:00Z") },
	{ "_id" : 5, "item" : "Americanos", "price" : 10, "size": "Grande","quantity" : 12, "date" : ISODate("2022-02-18T21:06:00Z") },
	{ "_id" : 6, "item" : "Cappuccino", "price" : 7, "size": "Tall","quantity" : 20, "date" : ISODate("2022-02-20T10:07:00Z") },
	{ "_id" : 7, "item" : "Lattes", "price" : 25,"size": "Tall", "quantity" : 30, "date" : ISODate("2022-02-21T10:08:00Z") },
	{ "_id" : 8, "item" : "Americanos", "price" : 10, "size": "Grande","quantity" : 21, "date" : ISODate("2022-02-22T14:09:00Z") },
	{ "_id" : 9, "item" : "Cappuccino", "price" : 10, "size": "Grande","quantity" : 17, "date" : ISODate("2022-02-23T14:09:00Z") },
	{ "_id" : 10, "item" : "Americanos", "price" : 8, "size": "Tall","quantity" : 15, "date" : ISODate("2022-02-25T14:09:00Z")}
]);

db.sales.aggregate([
	{ 
		$match: { item: "Americanos" } 
	},
	{ 
		$group: {
			_id: "$size",
			totalQty: {$sum: "$quantity"}
		}
	},
	{
		$sort: { totalQty : -1}		
	}
]);

-- SQL equivalent to MongoDB aggregation
select 
   name as _id, 
   sum(quantity) as totalQty
from 
   sales 
where name = 'Americanos'
group by name
order by totalQty desc; 

# $sum
