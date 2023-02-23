



---SESSION - 10 

---LAG / LEAD


--Write a query that returns the order date of the one previous sale of each staff (use the LAG function)
--1. Herbir personelin bir önceki satýþýnýn sipariþ tarihini yazdýrýnýz (LAG fonksiyonunu kullanýnýz)



SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_ord_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
ORDER BY
		1,4




SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date, 1, order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_ord_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id




WITH T1 AS (
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date, 1, order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_ord_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
)
SELECT	*, AVG(DATEDIFF(DAY, prev_ord_date, order_date)) OVER (PARTITION BY staff_id) AVG_DAY_DIF
FROM	T1




--------------------


--Write a query that returns the order date of the one next sale of each staff (use the LEAD function)
--2. Herbir personelin bir sonraki satýþýnýn sipariþ tarihini yazdýrýnýz (LEAD fonksiyonunu kullanýnýz)



SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LEAD(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) next_ord_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id




SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LEAD(order_date,2) OVER (PARTITION BY A.staff_id ORDER BY order_id) next_ord_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id




--Write a query that returns the difference order count between the current month and the next month for eachh year. 
--Her bir yýl için peþ peþe gelen aylarýn sipariþ sayýlarý arasýndaki farklarý bulunuz.


WITH T1 AS (
SELECT	DISTINCT 
		YEAR (order_date) AS ord_year, 
		MONTH(order_date) AS ord_month,
		COUNT(order_id) OVER (PARTITION BY YEAR (order_date), MONTH(order_date)) cnt_order_by_month
FROM	sale.orders
)
SELECT	*, 
		LEAD(ord_month) OVER (PARTITION BY ord_year ORDER BY ord_year, ord_month) next_month,
		LEAD(cnt_order_by_month) OVER (PARTITION BY ord_year ORDER BY ord_year, ord_month) next_month_order_cnt,
		cnt_order_by_month - LEAD(cnt_order_by_month) OVER (PARTITION BY ord_year ORDER BY ord_year, ord_month) order_diff
FROM	T1


/* WINDOW FUNCTIONS */



-- 3. ANALYTIC NUMBERING FUNCTIONS --

	
--ROW_NUMBER() - RANK() - DENSE_RANK() - CUME_DIST() - PERCENT_RANK() - NTILE()



--Assign an ordinal number to the product prices for each category in ascending order

--1. Herbir kategori içinde ürünlerin fiyat sýralamasýný yapýnýz (artan fiyata göre 1'den baþlayýp birer birer artacak)


SELECT	category_id, product_id, list_price, 
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) number
FROM	product.product


SELECT	category_id, product_id, list_price, 
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price DESC) number
FROM	product.product


SELECT	category_id, product_id, list_price, 
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) ROWnumber,
		RANK() OVER (PARTITION BY category_id ORDER BY list_price) RANKnumber
FROM	product.product



SELECT	category_id, product_id, list_price, 
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) ROWnumber,
		RANK() OVER (PARTITION BY category_id ORDER BY list_price) RANKnumber,
		DENSE_RANK() OVER (PARTITION BY category_id ORDER BY list_price) DENSE_RANKnumber
FROM	product.product


--------------

----------------/////////////////////////---------------------


--Write a query that returns how many days are between the third and fourth order dates of each staff.
--Her bir personelin üçüncü ve dördüncü sipariþleri arasýndaki gün farkýný bulunuz.


SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
ORDER BY
		1,4



WITH T1 AS 
(
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_ord_date,
		ROW_NUMBER() OVER (PARTITION BY A.staff_id ORDER BY order_id) ROW_NUM
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
)
SELECT *, DATEDIFF(DAY, prev_ord_date, order_date) DAY_DIFF
FROM	T1
WHERE	ROW_NUM = 4





with T1 as (
SELECT	A.staff_id,order_id,order_date, row_number() over (order by order_date) ord_date_row_n
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id
)


-----------------



--/////


-- Write a query that returns the cumulative distribution of the list price in product table by brand.

-- product tablosundaki list price' larýn kümülatif daðýlýmýný marka kýrýlýmýnda hesaplayýnýz



SELECT brand_id, list_price,
		ROUND(CUME_DIST() OVER (PARTITION BY brand_id ORDER BY list_price), 1) AS [cume_dist]
	   FROM product.product




	   ---//////////////////


--Write a query that returns the relative standing of the list price in product table by brand.


SELECT brand_id, list_price,
		ROUND(CUME_DIST() OVER (PARTITION BY brand_id ORDER BY list_price), 1) AS [cume_dist],
		ROUND(PERCENT_RANK() OVER (PARTITION BY brand_id ORDER BY list_price), 1) AS [relative standing]
	   FROM product.product




-----------///////////////


--Write a query that returns both of the followings:
--Average product price.
--The average product price of orders.



SELECT	DISTINCT 
		AVG(list_price) OVER () avg_price_of_table,
		AVG(list_price) OVER (PARTITION BY order_id) avg_price_by_order,
		order_id
FROM	sale.order_item
ORDER BY 
	order_id



----///////////////


--Which orders' average product price is lower than the overall average price?
--Hangi sipariþlerin ortalama ürün fiyatý genel ortalama fiyattan daha düþüktür?



with T1 as (
SELECT	DISTINCT
		AVG(list_price) OVER () avg_price_of_table,
		AVG(list_price) OVER (PARTITION BY order_id) avg_price_by_order,
		order_id
FROM	sale.order_item
)
select t1.order_id,t1.avg_price_of_table,t1.avg_price_by_order
from T1
where t1.avg_price_by_order < t1.avg_price_of_table
ORDER BY
		order_id

























