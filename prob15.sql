/*
  Write a query to return the first name and the last name of the actor who appeared in the most films.

  actor table 
    col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text


 film_actor table
  col_name   | col_type
-------------+--------------------------
 actor_id    | smallint
 film_id     | smallint


INITIAL APPROACH

SELECT first_name, last_name 
FROM actor LEFT JOIN
( 
	SELECT actor_id, COUNT(film_id) as count FROM film_actor GROUP BY actor_id
    ORDER BY count DESC
 	LIMIT 1 
) t ON actor.actor_id = t.actor_id

*/

WITH t AS ( 
	SELECT actor_id, COUNT(film_id) as count FROM film_actor GROUP BY actor_id
) 

SELECT first_name, last_name
FROM actor 
LEFT JOIN t ON actor.actor_id = t.actor_id
WHERE count IS NOT NULL
ORDER BY t.count DESC
LIMIT 1 