SELECT DISTINCT name FROM directors
JOIN ratings on directors.movie_id = ratings.movie_id
JOIN people on directors.person_id = people.id
WHERE rating >= 9.0;