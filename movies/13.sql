SELECT name FROM stars
JOIN movies ON stars.movie_id = movies.id
JOIN people ON stars.person_id = people.id
WHERE movie_id IN (SELECT movie_id FROM stars WHERE person_id =
        (SELECT id from people
        WHERE name = 'Kevin Bacon' and birth = 1958))
AND NOT name = 'Kevin Bacon';