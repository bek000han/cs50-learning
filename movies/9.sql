SELECT DISTINCT name FROM stars
JOIN movies ON stars.movie_id = movies.id
JOIN people ON stars.person_id = people.id
WHERE year = 2004
ORDER BY birth;