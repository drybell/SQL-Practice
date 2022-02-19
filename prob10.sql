/*
Write a query to return the minimum and maximum customer total spend in June 2020.
For each customer, first calculate their total spend in June 2020.
Then use MIN, and MAX function to return the min and max customer spend .

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
*/


SELECT MIN(t.amount), MAX(t.amount)
FROM (
  SELECT customer_id, SUM(amount) as amount FROM payment
  WHERE EXTRACT(MONTH FROM payment_ts) = 6 AND EXTRACT(YEAR FROM payment_ts) = 2020
  GROUP BY customer_id
) t