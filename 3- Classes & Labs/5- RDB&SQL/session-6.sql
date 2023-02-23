

--GROUPING SETS




--GROUPING SETS




SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary

FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year




SELECT *
FROM sale.sales_summary

SELECT Brand, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY
		Brand




SELECT Category, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY
		Category





SELECT SUM(total_sales_price)
FROM sale.sales_summary



SELECT Brand, Model_Year, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY
		Brand, Model_Year
ORDER BY
		1,2



------------



SELECT	Brand, Category, Model_Year, SUM(total_sales_price)
FROM	sale.sales_summary
GROUP BY
		GROUPING SETS (
						(Brand),
						(Category),
						(Brand, Model_Year),
						()			
				)
ORDER BY
		1,2,3


------------------/////////////////


----ROLLUP


SELECT	Brand, Model_Year, Category, SUM(total_sales_price)
FROM	sale.sales_summary
GROUP BY
		ROLLUP (Brand, Model_Year, Category)
ORDER BY
		3 DESC, 2 DESC, 1 DESC



----


SELECT	Brand, Model_Year, Category, SUM(total_sales_price)
FROM	sale.sales_summary
GROUP BY
		CUBE (Brand, Model_Year, Category)
ORDER BY
		1 DESC, 2 DESC, 3 DESC


-------PIVOT TABLE


--kategorilere ve model y�l�na g�re toplam ciro miktar�n� summary tablosu �zerinden P�VOT TABLE �LE hesaplay�n


SELECT	Category, Model_Year, SUM(total_sales_price)
FROM	sale.sales_summary
GROUP BY
		Category, Model_Year
ORDER BY
		1,2


------



SELECT *
FROM
(
SELECT	category, Model_Year, total_sales_price
FROM	SALE.sales_summary
) AS A
PIVOT 
(
SUM(total_sales_price)
FOR Model_Year
IN ([2018], [2019], [2020], [2021])
) AS PVT






SELECT	brand, Model_Year, total_sales_price
INTO	#temp_pivot
FROM	SALE.sales_summary


SELECT *
FROM
#temp_pivot
PIVOT 
(
SUM(total_sales_price)
FOR Model_Year
IN ([2018], [2019], [2020], [2021])
) AS PVT



SELECT *
FROM
#temp_pivot
PIVOT 
(
SUM(total_sales_price)
FOR brand
IN ([Acer], [Alpine], [Apple], [Asus])
) AS PVT


-------------------------------------/////////////////




-- �ki g�nden ge� kargolanan sipari�lerin haftan�n g�nlerine g�re da��l�m�n� hesaplay�n�z.


SELECT *, DATEDIFF(DAY, order_date, shipped_date)
FROM	SALE.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2



SELECT	order_id, DATENAME (DW, order_date) ORDER_DAY
FROM	SALE.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2



SELECT *
FROM
	(
	SELECT	order_id, DATENAME (DW, order_date) ORDER_DAY
	FROM	SALE.orders
	WHERE	DATEDIFF(DAY, order_date, shipped_date) > 2
	) AS A
PIVOT
(
COUNT(order_id)
FOR ORDER_DAY
IN ([Monday],[Tuesday],[Wednesday],[Thursday],[Friday],[Saturday],[Sunday])
) AS PVT



-------------------



-------SET OPERATORS


-- Charlotte �ehrinde sat�lan �r�nler ile Aurora �ehrinde sat�lan �r�nleri listeleyin


--75
SELECT	DISTINCT product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Charlotte'

UNION

--103
SELECT	DISTINCT product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Aurora'


-----------


--75
SELECT	DISTINCT product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Charlotte'

UNION ALL

--103
SELECT	DISTINCT product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Aurora'



-------------------


--Write a query that returns all customers whose  first or last name is Thomas.  (don't use 'OR')


SELECT first_name, last_name
FROM sale.customer
WHERE first_name = 'Thomas' OR last_name = 'Thomas'
ORDER BY
		1


SELECT first_name, last_name
FROM sale.customer
WHERE first_name = 'Thomas'

UNION ALL

SELECT first_name, last_name
FROM sale.customer
WHERE last_name = 'Thomas'

----------

--hatal�
SELECT customer_id, first_name, last_name
FROM sale.customer
WHERE first_name = 'Thomas'

UNION 

SELECT first_name, last_name, customer_id
FROM sale.customer
WHERE last_name = 'Thomas'


--hatal�
SELECT first_name, last_name
FROM sale.customer
WHERE first_name = 'Thomas'

UNION 

SELECT last_name, first_name
FROM sale.customer
WHERE last_name = 'Thomas'



-------


--Write a query that returns all brands with products for both 2018 and 2020 model year.



SELECT  A.brand_id, B.brand_name --,model_year
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		model_year = 2018

INTERSECT

SELECT  A.brand_id, B.brand_name --,model_year
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		model_year = 2020



---------------


-- Write a query that returns the first and the last names of the customers who placed orders in all of 2018, 2019, and 2020.

--622
SELECT	A.customer_id, first_name, last_name
FROM	sale.orders A, sale.customer B
WHERE	A.customer_id = B.customer_id
AND		YEAR (A.order_date) = 2018

INTERSECT
--679
SELECT	A.customer_id,  first_name, last_name
FROM	sale.orders A, sale.customer B
WHERE	A.customer_id = B.customer_id
AND		YEAR (A.order_date) = 2019

INTERSECT

--269
SELECT	A.customer_id,  first_name, last_name
FROM	sale.orders A, sale.customer B
WHERE	A.customer_id = B.customer_id
AND		YEAR (A.order_date) = 2020
ORDER BY
		2










