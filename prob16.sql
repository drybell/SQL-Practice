
/*
Write a query to return the first and last name of the customer who spent the most on movie rentals in Feb 2020.

customer table
 col_name   | col_type
-------------+--------------------------
 customer_id | integer
 store_id    | smallint
 first_name  | text
 last_name   | text
 email       | text
 address_id  | smallint
 activebool  | boolean
 create_date | date
 active      | integer

 payment table
    col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone

*/

WITH monthly_payments AS 
(
  SELECT * FROM (
	SELECT customer_id, EXTRACT(YEAR FROM payment_ts) as year, EXTRACT(MONTH FROM payment_ts) AS mon, SUM(amount) as monthly
	FROM payment 
	GROUP BY year, mon, customer_id
  ) t 
  WHERE t.year = 2020 and t.mon = 2
)


SELECT first_name, last_name FROM customer
LEFT JOIN monthly_payments 
	ON customer.customer_id = monthly_payments.customer_id 
	WHERE monthly_payments.monthly is not null
		ORDER BY monthly_payments.monthly DESC
			LIMIT 1
