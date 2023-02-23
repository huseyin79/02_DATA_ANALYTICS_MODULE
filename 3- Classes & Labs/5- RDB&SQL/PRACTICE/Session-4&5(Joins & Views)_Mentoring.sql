

---------------------------------------- JOINS -----

-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
-- (INNER) JOIN: Returns records that have matching values in both tables
-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table

https://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins
https://www.w3schools.com/sql/sql_join.asp
https://www.sqlservertutorial.net/sql-server-basics/sql-server-joins/

----- INNER JOIN -----

-- The INNER JOIN keyword selects records that have matching values in both tables.


--- QUESTION : Make a list of products showing the product ID, product name, category ID and category name.

SELECT * FROM product.product
SELECT * FROM product.category

SELECT DISTINCT category_id
FROM product.product

SELECT
	A.product_id,
	A.product_name,
	B.category_id,
	B.category_name
FROM product.product A
INNER JOIN product.category B
ON A.category_id = B.category_id

SELECT
	A.product_id,
	A.product_name,
	B.category_id,
	B.category_name
FROM product.product A, product.category B
WHERE A.category_id = B.category_id


--- QUESTION : List employees of stores with their store information. Select first_name, last name and store name

SELECT * FROM sale.staff
SELECT * FROM sale.store

SELECT
	A.first_name,
	A.last_name,
	B.store_name
FROM sale.staff A
INNER JOIN sale.store B
ON A.store_id = B.store_id

SELECT
	A.first_name,
	A.last_name,
	B.store_name
FROM sale.staff A, sale.store B
WHERE A.store_id = B.store_id


----- LEFT JOIN -----

-- The LEFT JOIN keyword returns all records from the left table (table1), and the matching records from the right table (table2). 
-- The result is 0 records from the right side, if there is no match.


--- QUESTION : Write a query that returns products that have never been ordered.
--- Select product_id, product_name, order_id

SELECT * FROM product.product
SELECT * FROM sale.orders
SELECT * FROM sale.order_item

SELECT
	A.product_id,
	A.product_name,
	B.order_id,
	B.product_id
FROM product.product A
LEFT JOIN sale.order_item B
ON A.product_id = B.product_id
WHERE B.order_id IS NULL


--- QUESTION : Report the stock status of the products that product id greater than 310 in the stores.
--- Expected columns: product_id, product_name, store_id, product_id, quantity

SELECT * FROM product.product
SELECT * FROM product.stock

SELECT
	A.product_id,
	A.product_name,
	B.store_id,
	B.product_id,
	B.quantity
FROM product.product A
LEFT JOIN product.stock B
ON A.product_id = B.product_id
WHERE A.product_id > 310
--- AND B.product_id IS NULL


----- RIGHT JOIN -----

-- The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records from the left table (table1). 
-- The result is 0 records from the left side, if there is no match.


--- QUESTION : Report the stock status of the products that product id greater than 310 in the stores.
--- Expected columns: product_id, product_name, store_id, product_id, quantity

SELECT * FROM product.product
SELECT * FROM product.stock

SELECT
	A.product_id,
	A.product_name,
	B.store_id,
	B.product_id,
	B.quantity
FROM product.stock B
RIGHT JOIN product.product A
ON A.product_id = B.product_id
WHERE A.product_id > 310


--- QUESTION : Report the order information made by all staffs.
--- Expected columns : staff_id, first_name, last_name, all the information about orders

SELECT * FROM sale.staff
SELECT * FROM sale.orders

SELECT
	A.staff_id,
	A.first_name,
	A.last_name,
	B.store_id,
	B.*
FROM sale.orders B
RIGHT JOIN sale.staff A
ON A.staff_id = B.staff_id



----- FULL OUTER JOIN -----

-- The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.


--- QUESTION : Write a query that returns stock and order information together for all products . (TOP 100)
--Expected columns: Product_id, store_id, quantity, order_id, list_price


SELECT 
	A.*, 
	B.product_name, 
	C.order_id
FROM product.stock A
FULL OUTER JOIN product.product B
ON A.product_id = B.product_id
FULL OUTER JOIN sale.order_item C
ON B.product_id = C.product_id



--- QUESTION : Write a query that returns the staffs with their managers.
--Expected columns: staff first name, staff last name, manager name


SELECT A.staff_id, A.first_name, A.last_name , A.manager_id, B.first_name
FROM SALE.staff A 
LEFT JOIN SALE.staff B
ON A.manager_id = B.staff_id

--or

SELECT A.staff_id, A.first_name, A.last_name , A.manager_id, B.first_name
FROM SALE.staff A, SALE.staff B
WHERE A.manager_id = B.staff_id





---------- VIEWS ----------

-- In SQL, a view is a virtual table based on the result-set of an SQL statement.
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.
-- A view is created with the CREATE VIEW statement.

https://www.sqlservertutorial.net/sql-server-views/


----- CREATE VIEW Syntax

--CREATE VIEW view_name AS
--SELECT column1, column2, ...
--FROM table_name
--WHERE condition;


----- SQL Updating a View

-- A view can be updated with the CREATE OR REPLACE VIEW statement.


----- SQL CREATE OR REPLACE VIEW Syntax

--CREATE OR REPLACE VIEW view_name AS
--SELECT column1, column2, ...
--FROM table_name
--WHERE condition;


----- SQL Dropping a View

-- A view is deleted with the DROP VIEW statement.
-- Syntax DROP VIEW view_name;



--- QUESTION : Müþterilerin sipariþ ettiði ürünleri gösteren bir view oluþturun.

SELECT 
	A.customer_id,
	A.first_name,
	A.last_name,
	B.order_id,
	C.product_id,
	D.product_name
FROM sale.customer A
LEFT JOIN sale.orders B
ON A.customer_id = B.customer_id
LEFT JOIN sale.order_item C
ON B.order_id = C.order_id
LEFT JOIN product.product D
ON C.product_id = D.product_id

CREATE VIEW v_customers_and_products AS
SELECT DISTINCT
	A.customer_id,
	A.first_name,
	A.last_name,
	B.order_id,
	C.product_id,
	D.product_name
FROM sale.customer A
LEFT JOIN sale.orders B
ON A.customer_id = B.customer_id
LEFT JOIN sale.order_item C
ON B.order_id = C.order_id
LEFT JOIN product.product D
ON C.product_id = D.product_id

SELECT *
FROM v_customers_and_products





































