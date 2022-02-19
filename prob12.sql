/*
Identify all actors whose last name ends in 'EN' or 'RY'.
Group and count them by their last name.

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
*/


SELECT last_name, COUNT(last_name) FROM actor
WHERE last_name LIKE '%EN' OR last_name LIKE '%RY'
GROUP BY last_name