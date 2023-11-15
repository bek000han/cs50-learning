SELECT title FROM stars
JOIN movies ON stars.movie_id = movies.id
JOIN people ON stars.person_id = people.id
WHERE person_id = (SELECT id FROM people WHERE name = 'Johnny Depp')
INTERSECT
SELECT title FROM stars
JOIN movies ON stars.movie_id = movies.id
JOIN people ON stars.person_id = people.id
WHERE person_id = (SELECT id FROM people WHERE name = 'Helena Bonham Carter');