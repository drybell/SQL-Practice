/*

Write a query to return the total number of unique customers for each month
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
*/


SELECT t.year, t.mon, COUNT(DISTINCT t.uu_cnt) 
FROM (
  	SELECT EXTRACT(YEAR from rental_ts) as year, EXTRACT(MONTH from rental_ts) as mon, customer_id as uu_cnt FROM rental
  ) as t
GROUP BY t.year, t.mon