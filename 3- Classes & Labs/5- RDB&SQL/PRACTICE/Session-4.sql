


---------- Session - 4


SELECT LOWER('CHARACTER')


SELECT UPPER('character')


SELECT *
FROM	string_split('TAYYAR,HÜSEYÝN,ZAFER', ',')



---------------


----CHARACTER kelimesinin ilk harfini büyük, sonrakileri küçük olacak þekilde dönüþtürün

SELECT UPPER (LEFT('CHARACTER', 1))


SELECT LEN('CHARACTER')

SELECT UPPER (LEFT('CHARACTER', 1)) + LOWER(SUBSTRING('CHARACTER ', 2, LEN('CHARACTER')))



SELECT	first_name, SUBSTRING(first_name, LEN(first_name), 1)
FROM	sale.customer


-----------------------------


SELECT TRIM('   CHA RACTER   ')


SELECT TRIM('?/' FROM '/?CHA RACTER/?')


SELECT LTRIM('  CHARACTER   ')


SELECT RTRIM('  CHARACTER   ') 


-----------------------



SELECT REPLACE('CHARA**CTER', '*', ' ')


SELECT STR(123465)



SELECT CAST(2356.5465 AS INT)



SELECT CAST(2356.5465 AS FLOAT)


SELECT CAST('2023-01-01' AS DATE)


SELECT CONVERT(DATETIME, '2023-01-01')


SELECT CONVERT(VARCHAR(10), CAST('2023-01-01' AS DATE), 6)


SELECT CONVERT(DATE, '01 Jan 23', 6)



https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/ 


------------



SELECT ROUND(75689.368 , 2, 0)

SELECT ROUND(75689.368 , 2)

SELECT ROUND(75689.364 , 2, 0)


SELECT ROUND(75689.368 , 2, 1)


----------

SELECT ISNULL(NULL, 'ALÝ')

SELECT ISNULL('VELÝ', 'ALÝ')

SELECT ISNULL(1, 'ALÝ')


------------


SELECT COALESCE(NULL, NULL, 'ALÝ', 'VELÝ')

SELECT COALESCE(NULL, 'ALÝ', NULL,  'VELÝ')


SELECT NULLIF('ALÝ', 'VELÝ')

SELECT NULLIF(1, 1)


SELECT	NULLIF(first_name, 'Diane')
FROM	SALE.customer



------

SELECT ISNUMERIC(1)

SELECT ISNUMERIC(65468.3545)


SELECT ISNUMERIC('65468.3545')


SELECT ISNUMERIC('/')


-------////////////////////



---------- How many customers have yahoo mail?



SELECT	COUNT(customer_id)
FROM	sale.customer
WHERE	email LIKE '%@yahoo.com%'


SELECT	*, PATINDEX('%@yahoo.com%', email)
FROM	sale.customer
WHERE	PATINDEX('%@yahoo.com%', email) > 0


SELECT	COUNT(customer_id)
FROM	sale.customer
WHERE	PATINDEX('%@yahoo.com%', email) > 0



--Write a query that returns the characters before the '@' character in the email column.


SELECT LEFT(email, CHARINDEX('@', email)-1)
FROM	sale.customer


SELECT LEFT(email, PATINDEX('%@%', email)-1)
FROM sale.customer


--Add a new column to the customers table that contains the customers' contact information. 
--If the phone is not null, the phone information will be printed, if not, the email information will be printed.


SELECT *, COALESCE(phone, email) contact
FROM sale.customer



SELECT * , ISNULL(email,phone) CONTACT
FROM sale.customer



--Write a query that returns the name of the streets, where the third character of the streets is numeric.


SELECT *, SUBSTRING(street, 3,1) third_char
FROM	SALE.customer
WHERE	ISNUMERIC(SUBSTRING(street, 3,1)) = 1

 




--------------////////////////////////


---joins

--inner join

-- Make a list of products showing the product ID, product name, category ID, and category name.


SELECT product_id, product_name, product.product.category_id, product.category.category_id, category_name
FROM	product.product
		INNER JOIN
		product.category
		ON	product.product.category_id = product.category.category_id

------


SELECT	product_id, product_name, A.category_id, B.category_id, category_name
FROM	product.product AS A
		INNER JOIN
		product.category AS B
		ON	A.category_id = B.category_id


----

SELECT	product_id, product_name, A.category_id, B.category_id, category_name
FROM	product.product AS A
		JOIN
		product.category AS B
		ON	A.category_id = B.category_id


----------


SELECT	product_id, product_name, A.category_id, B.category_id, category_name
FROM	product.product AS A ,	product.category AS B
WHERE	A.category_id = B.category_id






SELECT distinct category_id
FROM product.category



SELECT distinct category_id
FROM product.product



-------------


--How many employees are in each store?


SELECT	B.store_name , COUNT(staff_id) CNT_STAFF
FROM	sale.staff AS A
		INNER JOIN
		sale.store AS B
		ON	A.store_id = B.store_id
GROUP BY B.store_name


SELECT	B.store_name , staff_id
FROM	sale.staff AS A
		INNER JOIN
		sale.store AS B
		ON	A.store_id = B.store_id
ORDER BY 1


SELECT	B.store_name 
FROM	sale.staff AS A
		INNER JOIN
		sale.store AS B
		ON	A.store_id = B.store_id
GROUP BY B.store_name 


--------

--Write a query that returns products that have never been ordered

select * from product.productselect * from sale.order_item

SELECT	DISTINCT product_id
FROM	sale.order_item
ORDER BY product_id

SELECT	DISTINCT A.product_id, A.product_name, ISNULL(STR(B.product_id), 'NOT ORDERED') AS IsOrdered
FROM	product.product AS A
		LEFT JOIN
		sale.order_item AS B
		ON	A.product_id = B.product_id
WHERE	B.product_id IS NULL


SELECT	COUNT(B.product_id)
FROM	product.product AS A
		LEFT JOIN
		sale.order_item AS B
		ON	A.product_id = B.product_id
WHERE	B.product_id IS NULL




SELECT	COUNT(DISTINCT B.product_id)
FROM	product.product AS A
		INNER JOIN
		sale.order_item AS B
		ON	A.product_id = B.product_id


---çalýþanlarýn sattýklarý ürün sayýlarýný bulunuz


SELECT	S.staff_id, COUNT (DISTINCT product_id)
FROM	sale.staff S
		LEFT JOIN
		sale.orders A
		ON	S.staff_id = A.staff_id
		LEFT JOIN
		sale.order_item B
		ON	A.order_id = B.order_id
GROUP BY 
		S.staff_id




SELECT	S.staff_id, ISNULL(SUM (quantity),0) cnt_product
FROM	sale.staff S
		LEFT JOIN
		sale.orders A
		ON	S.staff_id = A.staff_id
		LEFT JOIN
		sale.order_item B
		ON	A.order_id = B.order_id
GROUP BY 
		S.staff_id
ORDER BY
		1






