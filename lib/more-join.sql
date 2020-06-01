-- List the films where the yr is 1962 [Show id, title] 

SELECT id, title
FROM movie
WHERE yr = 1962

-- Give year of 'Citizen Kane'. 

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'

-- What id number does the actor 'Glenn Close' have? 

SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- What is the id of the film 'Casablanca' 

SELECT id
FROM movie
WHERE title = 'Casablanca'

-- Use movieid=11768, (or whatever value you got from the previous question) 

SELECT name
FROM actor JOIN casting ON id = casting.actorid JOIN movie ON movieid = movie.id
WHERE title = 'Casablanca'

-- Obtain the cast list for the film 'Alien' 

SELECT name
FROM actor
     JOIN casting ON id = casting.actorid
     JOIN movie ON movieid = movie.id
WHERE title = 'Alien'

-- List the films in which 'Harrison Ford' has appeared

SELECT title
FROM movie
     JOIN casting ON id = casting.movieid
     JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford'

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 

SELECT title
FROM movie
     JOIN casting ON id = casting.movieid
     JOIN actor ON actorid = actor.id
WHERE name = 'Harrison Ford' AND casting.ord <> 1

-- List the films together with the leading star for all 1962 films. 

SELECT title, name
FROM movie
JOIN casting
ON id = casting.movieid
JOIN actor
ON actorid = actor.id
WHERE ord = 1 AND yr = 1962

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 

SELECT yr,COUNT(title)
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE name = 'Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name
FROM movie
     JOIN casting ON movie.id = movieid
     JOIN actor ON actorid = actor.id
WHERE movie.id IN (SELECT casting.movieid
                   FROM casting
                   WHERE actorid = (SELECT id
                                    FROM actor
                                    WHERE name = 'Julie Andrews'))
                                    AND ord = 1

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT name
FROM actor
JOIN casting ON id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(name) >= 15
ORDER BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT title, COUNT(name)
FROM movie
JOIN casting ON id = casting.movieid
JOIN actor ON actorid = actor.id
WHERE  movie.yr = 1978
GROUP BY title
ORDER BY COUNT(actor.name) DESC, movie.title

-- List all the people who have worked with 'Art Garfunkel'. 
SELECT name
FROM actor
JOIN casting ON id = casting.actorid
WHERE movieid IN
             (SELECT movieid
              FROM casting
              WHERE actorid =
                             (SELECT id
                              FROM actor
                              WHERE name = 'Art Garfunkel'))
                              AND name <> 'Art Garfunkel'
ORDER BY name
