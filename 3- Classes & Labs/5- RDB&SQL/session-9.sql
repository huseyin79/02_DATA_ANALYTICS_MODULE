



----Session 9 Window Functions


-- Window Functions (WF) vs. GROUP BY



--Write a query that returns the total stock amount of each product in the stock table.
--ürünlerin stock sayýlarýný bulunuz


SELECT	count (distinct product_id)
FROM	product.stock


SELECT	product_id, SUM(quantity) stock_amount
FROM	product.stock
GROUP BY
		product_id
ORDER BY
		1


SELECT	product_id, SUM(quantity) OVER (PARTITION BY product_id)
FROM	product.stock



SELECT	*, SUM(quantity) OVER (PARTITION BY product_id) product_stock,
			SUM(quantity) OVER (PARTITION BY store_id) store_stock
FROM	product.stock
ORDER BY
		product_id


-- Write a query that returns average product prices of brands. 

-- Markalara göre ortalama ürün fiyatlarýný hem Group By hem de Window Functions ile hesaplayýnýz.


SELECT	brand_id, AVG(list_price) avg_price
FROM	product.product
GROUP BY
		brand_id



SELECT	DISTINCT brand_id, AVG(list_price) OVER (PARTITION BY brand_id) avg_price
FROM	product.product


-- What is the cheapest product price for each category?
-- Herbir kategorideki en ucuz ürünün fiyatý



SELECT	DISTINCT B.category_name, MIN(A.list_price) OVER (PARTITION BY B.category_name) cheapest_by_cat
FROM	product.product A, product.category B
WHERE	A.category_id=B.category_id
ORDER BY
		2



SELECT	DISTINCT  MIN(A.list_price) OVER () min_price
FROM	product.product A, product.category B
WHERE	A.category_id=B.category_id



-----------


--///


-- How many different product in the product table?
-- Product tablosunda toplam kaç faklý product bulunduðu


SELECT	COUNT (DISTINCT product_id)
FROM	product.product



SELECT	DISTINCT COUNT (product_id) OVER ()
FROM	product.product



---////

-- How many different product in the order_item table?
-- Order_item tablosunda kaç farklý ürün bulunmaktadýr?


SELECT	COUNT (DISTINCT product_id)
FROM	sale.order_item


SELECT	DISTINCT COUNT (product_id) OVER ()
FROM	sale.order_item



SELECT	DISTINCT COUNT (product_id) OVER ()
FROM	(
		SELECT	DISTINCT product_id
		FROM	sale.order_item
		) A


----/////
-- Write a query that returns how many products are in each order?
-- Her sipariþte kaç ürün olduðunu döndüren bir sorgu yazýn?


SELECT	DISTINCT order_id, SUM(quantity) OVER (PARTITION BY order_id)
FROM	sale.order_item


--////

-- How many different product are in each brand in each category?
-- Herbir kategorideki herbir markada kaç farklý ürünün bulunduðu



SELECT	DISTINCT brand_id, category_id, COUNT (product_id) OVER (PARTITION BY brand_id, category_id) cnt_product
FROM	product.product


--------------




--------------------/////////////////////////////-------------------




-- Window Frames



SELECT	*, SUM(list_price) OVER (PARTITION BY order_id)
FROM	sale.order_item 



SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id)
FROM	sale.order_item 


SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM	sale.order_item 


SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM	sale.order_item 



SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	sale.order_item 
ORDER BY
 order_id, item_id



 SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	sale.order_item 




SELECT	*, SUM(list_price) OVER (PARTITION BY order_id ORDER BY item_id ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM	sale.order_item 



SELECT	*, MIN(list_price) OVER (PARTITION BY order_id ORDER BY item_id ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM	sale.order_item 



------------------//////////////////////////////--------------------


-- 2. ANALYTIC NAVIGATION FUNCTIONS --





--FIRST_VALUE() - 

--Write a query that returns one of the most stocked product in each store.


SELECT *
FROM	product.stock
ORDER BY 1,3 DESC



SELECT	DISTINCT store_id, FIRST_VALUE (product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC) most_stock_product
FROM	product.stock


-----////


--Write a query that returns customers and their most valuable order with total amount of it.



SELECT	DISTINCT A.customer_id, A.order_id, SUM(quantity*list_price*(1-discount)) OVER (PARTITION BY A.customer_id, A.order_id) AS net_amount
FROM	sale.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
ORDER BY 
		customer_id, net_amount DESC


WITH T1 AS (
SELECT	A.customer_id, A.order_id, SUM(quantity*list_price*(1-discount)) OVER (PARTITION BY A.customer_id, A.order_id) AS net_amount
FROM	sale.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
)
SELECT	DISTINCT customer_id, 
		FIRST_VALUE (order_id) OVER (PARTITION BY customer_id ORDER BY net_amount DESC) most_val_order,
		FIRST_VALUE (net_amount) OVER (PARTITION BY customer_id ORDER BY net_amount DESC) net_amount
FROM	T1


---------


---Write a query that returns first order date by month
---Her ay için ilk sipariþ tarihini belirtiniz.


SELECT	DISTINCT YEAR (order_date) AS ORD_YEAR, MONTH(order_date) AS ORD_MONTH ,
		FIRST_VALUE(order_date) OVER (PARTITION BY YEAR (order_date), MONTH(order_date) ORDER BY order_date) first_ord_date,
		MIN (order_date) OVER (PARTITION BY YEAR (order_date), MONTH(order_date)) min_order_date
FROM sale.orders



--LAST VALUE

--Write a query that returns most stocked product in each store. (Use Last_Value)


SELECT *
FROM	product.stock
ORDER BY 1, 3 ASC, product_id desc


SELECT	DISTINCT store_id, 
		LAST_VALUE (product_id) OVER (PARTITION BY store_id ORDER BY quantity ASC, product_id DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) most_stock_product
FROM	product.stock






