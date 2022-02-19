/*
Write a SQL query to return this staff's first name and last name.
Picture field contains the link that points to a staff's profile image.
There is only one staff who doesn't have a profile picture.
Use colname IS NULL to identify data that are missing.

  col_name   | col_type
-------------+--------------------------
 staff_id    | integer
 first_name  | text
 last_name   | text
 address_id  | smallint
 email       | text
 store_id    | smallint
 active      | boolean
 username    | text
 picture     | character varying

*/

SELECT first_name, last_name
FROM staff
WHERE picture is NULL;