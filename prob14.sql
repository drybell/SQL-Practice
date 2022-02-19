/*
Write a query to return the number of fast movie watchers vs slow movie watchers.
fast movie watcher: by average return their rentals within 5 days.
slow movie watcher: takes an average of >5 days to return their rentals.
Most customers have multiple rentals over time, you need to first compute the number of days for each rental transaction, then compute the average on the rounded up days. e.g., if the rental period is 1 day and 10 hours, count it as 2 days.
Skip the rentals that have not been returned yet, e.g., return_ts IS NULL.
The orders of your results doesn't matter.
A customer can only rent one movie per transaction.

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint

*/

/*
 Correct Approach
*/

SELECT *
FROM (
    WITH t AS 
    (
      SELECT customer_id, AVG(CEILING((DATE_PART('day', return_ts - rental_ts) * 24 * 60 + DATE_PART('hour', return_ts - rental_ts) * 60 + DATE_PART('minute', return_ts - rental_ts)) / (24 * 60))) as avg_time FROM rental WHERE return_ts IS NOT NULL
      GROUP BY customer_id
    )

    SELECT 'fast_watcher' AS watcher_category, COUNT(CASE WHEN t.avg_time <= 5 THEN 1 END) FROM t
    UNION ALL
    SELECT 'slow_watcher' AS watcher_category, COUNT(CASE WHEN t.avg_time > 5 THEN 1 END) FROM t
) s

/*
    http://www.sqlines.com/postgresql/how-to/datediff
    Basically, PostgreSQL sucks with dates, and the best case would be to replicate the DATEDIFF structure in SQL. I guess I read the webpage wrong when trying to understand date_part, as it reports the full amount of __ that passed in the interval. 
    I basically converted to minutes and back to days, rounded up with ceiling, then took the average in order to complete this problem.

    In order to debug this problem, I focused on the 't' table and printed out different queries (comparing my approach to return_ts - rental_ts to see if I was rounding properly) and ultimately found that I needed to go all the way down to minutes
    to make sure that I am looking for full rounded up days.

*/

/* 
Incorrect, but modified approach

*/

SELECT *
FROM (
    WITH t AS (
	  SELECT customer_id, AVG(DATE_PART('day', return_ts - rental_ts)) as avg_time FROM rental WHERE return_ts IS NOT NULL
	  GROUP BY customer_id
	)
	SELECT 'fast_watcher' AS watcher_category, COUNT(CASE WHEN t.avg_time <= 5 THEN 1 END) FROM t
  	UNION ALL
    SELECT 'slow_watcher' AS watcher_category, COUNT(CASE WHEN t.avg_time > 5 THEN 1 END) FROM t
) s

/* 
    For some weird reason, I get fast = 488, slow = 111 when the answer is fast = 112, slow = 487. If I flip the logic, then the answer will be correct, but it won't make sense.
    fast watchers explicitly are customers that on average return within 5 days, or <= 5. 
    There is also some rounding error, even though DATE_PART rounds up and the comparison operators are correct. I have a feeling that the question should say <5 and >= 5 days
*/


/*
Initial Approach

*/
SELECT *
FROM (
	WITH t AS 
	(
	  SELECT customer_id, AVG(return_ts - rental_ts) as avg_time FROM rental WHERE return_ts IS NOT NULL
	  GROUP BY customer_id
	)
	SELECT 'fast_watcher' AS watcher_category, SELECT COUNT(CASE WHEN t.avg_time <= 5 THEN 1 END) FROM t
  	UNION ALL
    SELECT 'slow_watcher' AS watcher_category, SELECT COUNT(CASE WHEN t.avg_time > 5 THEN 1 END) FROM t
) s