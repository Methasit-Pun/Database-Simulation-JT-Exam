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