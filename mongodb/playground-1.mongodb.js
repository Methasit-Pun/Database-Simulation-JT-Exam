/* global use, db */
// MongoDB Playground
// To disable this template go to Settings | MongoDB | Use Default Template For Playground.
// Make sure you are connected to enable completions and to be able to run a playground.
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.
// The result of the last command run in a playground is shown on the results panel.
// By default the first 20 documents will be returned with a cursor.
// Use 'console.log()' to print to the debug output.
// For more documentation on playgrounds please refer to
// https://www.mongodb.com/docs/mongodb-vscode/playgrounds/
// 1. Show all documents in sales

// 1. Show all documents with increasing order of quantity
db.sales.find().sort({ quantity: 1 });

// 2. Count the records for each type of item and sort the result in decreasing order
db.sales.aggregate([
    {
        $group: {
            _id: "$item",
            count: { $sum: 1 }
        }
    },
    {
        $sort: { count: -1 }
    }
]);

// 3. Show max quantity for each type of item
db.sales.aggregate([
    {
        $group: {
            _id: "$item",
            max_quantity: { $max: "$quantity" }
        }
    }
]);