
/* 
Write a query to return the name of the store and its manager, that generated the most sales.

Table: sales_by_store
*/

SELECT store, manager
FROM sales_by_store
WHERE total_sales = (SELECT MAX(total_sales) FROM sales_by_store);