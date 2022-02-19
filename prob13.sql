/*
Write a query to return the number of actors whose first name starts with 'A', 'B', 'C', or others.
The order of your results doesn't matter.
You need to return 2 columns:
The first column is the group of actors based on the first letter of their first_name, use the following: 'a_actors', 'b_actors', 'c_actors', 'other_actors' to represent their groups.
Second column is the number of actors whose first name matches the pattern.

 col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
*/

SELECT * 
FROM ( 
  SELECT 'a_actors' as actor_category, COUNT (CASE WHEN first_name LIKE 'A%' THEN 1 END) from actor
  UNION ALL
  SELECT 'b_actors' as actor_category, COUNT (CASE WHEN first_name LIKE 'B%' THEN 1 END) from actor
  UNION ALL
  SELECT 'c_actors' as actor_category, COUNT (CASE WHEN first_name LIKE 'C%' THEN 1 END) from actor
  UNION ALL
  SELECT 'other_actors' as actor_category, COUNT (CASE WHEN first_name !~* '^[ABC][A-Z]*' THEN 1 END) from actor
) t
