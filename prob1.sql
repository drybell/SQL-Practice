/*   
Instruction

Write a query to return the number of films in the following categories: short, medium, and long.
The order of your results doesn't matter.
Definition
short: less <60 minutes.
medium: >=60 minutes, but <100 minutes.
long: >=100 minutes
Table: film

*/

SELECT c.film_category as film_category, count
FROM (
  SELECT 'short' as film_category, COUNT(CASE WHEN film.length < 60 THEN 1 END) as count from film
  UNION ALL
  SELECT 'medium' as film_category, COUNT(CASE WHEN film.length >= 60 AND film.length < 100 THEN 1 END) as count from film
  UNION ALL
  SELECT 'long' as film_category, COUNT(CASE WHEN film.length >= 100 THEN 1 END) as count from film
) c 
GROUP BY film_category, count;

