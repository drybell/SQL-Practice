/*
Find the number of actors whose last name is one of the following: 'DAVIS', 'BRODY', 'ALLEN', 'BERRY'

col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
*/


/*
BETTER SOLUTION

*/

SELECT last_name, COUNT(last_name)
FROM actor 
WHERE last_name in ('DAVIS', 'BRODY', 'ALLEN', 'BERRY')
GROUP BY last_name


/* 
INITIAL GUESS

*/
SELECT last_name, COUNT(CASE WHEN last_name in ('DAVIS', 'BRODY', 'ALLEN', 'BERRY') THEN 1 ELSE 0 END)
FROM actor 
WHERE last_name in ('DAVIS', 'BRODY', 'ALLEN', 'BERRY')
GROUP BY last_name