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

// ============================================================
// EXE 5 - sample_mflix > movies
// ============================================================
use('sample_mflix');

// 1. Find all movies where languages equals 'French' OR 'English'
db.movies.find({
    languages: { $in: ['French', 'English'] }
});

// 2. Find all movies that include BOTH 'Action' AND 'Crime' in genres
db.movies.find({
    genres: { $all: ['Action', 'Crime'] }
});

// 3. Find all movies that have exactly 4 casts AND first cast (cast.0) has "Frank" in the name
db.movies.find({
    cast: { $size: 4 },
    'cast.0': { $regex: /Frank/ }
});

// ============================================================
// EXE 6 - sample_mflix > movies  &  sample_supplies > sales
// ============================================================
use('sample_mflix');

// 1. Find all movies where imdb.votes >= 100000 OR imdb.rating >= 9
db.movies.find({
    $or: [
        { 'imdb.votes': { $gte: 100000 } },
        { 'imdb.rating': { $gte: 9 } }
    ]
});

// Query on an Array of Embedded/Nested Documents (sample_supplies)
use('sample_supplies');

db.sales.find(
    { 'items.price': { $gt: 100 }, 'items': { $size: 2 } },
    { items: 1 }
);

use('sample_supplies');
db.sales.find(
    { 'items.price': { $not: { $lt: 100 } }, 'items': { $size: 2 } },
    { items: 1 }
);

use('sample_supplies');
db.sales.find(
    {
        $and: [
            { items: { $elemMatch: { price: { $gt: 400, $lt: 600 } } } },
            { items: { $size: 1 } }
        ]
    },
    { items: 1 }
);

use('sample_supplies');
db.sales.find(
    {
        $and: [
            { items: { $elemMatch: { name: 'laptop', price: { $gt: 1000, $lt: 1200 } } } },
            { items: { $size: 1 } }
        ]
    },
    { items: 1 }
);

// ============================================================
// EXE 7 - sample_training > grades
// ============================================================
use('sample_training');

// 1. Find all students with "Exam" scores > 90
db.grades.find({
    scores: { $elemMatch: { type: 'exam', score: { $gt: 90 } } }
});

// 2. Find all students who do NOT have exactly 4 scores
db.grades.find({
    scores: { $not: { $size: 4 } }
});

// ============================================================
// EXE 8 - sample_training > grades
// Calculate average score per course_id
// Score = 0.7*exam + 0.2*quiz + 0.05*hw1 + 0.05*hw2
// ============================================================
use('sample_training');

db.grades.aggregate([
    // Step 1: Extract each score type into named fields
    {
        $addFields: {
            exam:  { $arrayElemAt: ['$scores', 0] },
            quiz:  { $arrayElemAt: ['$scores', 1] },
            hw1:   { $arrayElemAt: ['$scores', 2] },
            hw2:   { $arrayElemAt: ['$scores', 3] }
        }
    },
    // Step 2: Pull out just the score values
    {
        $addFields: {
            exam:  '$exam.score',
            quiz:  '$quiz.score',
            hw1:   '$hw1.score',
            hw2:   '$hw2.score'
        }
    },
    // Step 3: Compute weighted score per student
    {
        $addFields: {
            weightedScore: {
                $add: [
                    { $multiply: ['$exam', 0.7]  },
                    { $multiply: ['$quiz', 0.2]  },
                    { $multiply: ['$hw1', 0.05] },
                    { $multiply: ['$hw2', 0.05] }
                ]
            }
        }
    },
    // Step 4: Group by course_id and calculate average weighted score
    {
        $group: {
            _id: '$course_id',
            avgScore: { $avg: '$weightedScore' }
        }
    },
    // Step 5: Sort by course_id ascending
    {
        $sort: { _id: 1 }
    }
]);
