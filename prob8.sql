/*
Write a query to return the average customer spend by month.
Definition: average customer spend: total customer spend divided by the unique number of customers for that month.
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone

*/

SELECT t.year, t.mon, t.monthly / t.uniq AS avg_spend
FROM (
  SELECT EXTRACT(YEAR FROM payment_ts) AS year, EXTRACT(MONTH FROM payment_ts) AS mon, 
  SUM(amount) as monthly, COUNT(DISTINCT customer_id) as uniq
  FROM payment
  GROUP BY year, mon
) as t