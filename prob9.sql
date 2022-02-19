/*
Write a query to count the number of customers who spend more than > $20 by month
You can use EXTRACT(YEAR from timestamp_col) and EXTRACT(MONTH from timestamp_col) to get year and month from a timestamp column.
Hint: a customer's spend varies every month.

  col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone

*/


SELECT t.year, t.mon, COUNT(DISTINCT t.uniq)
FROM (
    SELECT EXTRACT(YEAR FROM payment_ts) AS year, EXTRACT(MONTH FROM payment_ts) AS mon, 
    customer_id as uniq, SUM(amount) as amount
    FROM payment
    GROUP BY year, mon, uniq
) AS t
WHERE t.amount > 20
GROUP BY t.year, t.mon
ORDER BY t.mon


/* 
ORIGINAL APPROACH 

SELECT s.year, s.mon, COUNT(s.uniq)
FROM (
  SELECT t.year, t.mon, t.uniq, SUM(t.amount) as monthly
	FROM (
	  SELECT EXTRACT(YEAR FROM payment_ts) AS year, EXTRACT(MONTH FROM payment_ts) AS mon, 
	  customer_id as uniq, amount
	  FROM payment
	  GROUP BY year, mon, uniq, amount
	) AS t
  GROUP BY t.year, t.mon, t.uniq
) AS s
WHERE s.monthly > 20
GROUP BY s.year, s.mon
ORDER BY s.mon

Close, but looks like I added one extra select statement when I could've condensed. This also produces the incorrect output (no idea why)
*/