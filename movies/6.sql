SELECT AVG(rating)
FROM (SELECT * FROM ratings JOIN movies ON id = movie_id)
WHERE year = 2012;