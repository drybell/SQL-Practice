/*
Write a query to find the top 3 film categories that generated the most sales.
The order of your results doesn't matter.

  col_name   | col_type
-------------+----------
 category    | text
 total_sales | numeric
*/

SELECT category
FROM sales_by_film_category
ORDER BY total_sales DESC
LIMIT 3;