/*
Write a query to return the total movie rental revenue for each month.
You can use EXTRACT(MONTH FROM colname) and EXTRACT(YEAR FROM colname) to extract month and year from a timestamp column

 col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone


*/



SELECT t.year , t.mon, sum(amount) as rev
FROM (
  SELECT EXTRACT(YEAR FROM payment.payment_ts) as year, EXTRACT(MONTH FROM payment.payment_ts) as mon, amount FROM payment
  ) as t
GROUP BY t.year, t.mon;