/*
Write a query to return the titles of the 5 shortest movies by duration.
The order of your results doesn't matter.

       col_name       |  col_type
----------------------+--------------------------
 film_id              | integer
 title                | text
 description          | text
 release_year         | integer
 language_id          | smallint
 original_language_id | smallint
 rental_duration      | smallint
 rental_rate          | numeric
 length               | smallint
 replacement_cost     | numeric
 rating               | text
*/

SELECT title
FROM film
ORDER BY length
LIMIT 5;