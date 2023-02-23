



---Session 11



--Her bir personelin üçüncü ve dördüncü sipariþlerinin ürün sayýlarý arasýndaki farký bulunuz.


SELECT	staff_id, A.order_id, B.product_id, quantity
FROM	SALE.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
ORDER BY
		1,2




SELECT	staff_id, A.order_id, SUM(quantity) total_product
FROM	SALE.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
GROUP BY
		staff_id, A.order_id
ORDER BY 
		1,2


WITH T1 AS (
SELECT	DISTINCT staff_id, A.order_id, SUM(quantity) OVER (PARTITION BY staff_id, A.order_id)total_product,
		DENSE_RANK() OVER (PARTITION BY staff_id ORDER BY A.order_id) row_num
FROM	SALE.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
), T2 AS (
SELECT *
FROM	T1
WHERE	row_num = 3
), T3 AS (
SELECT *
FROM	T1
WHERE	row_num = 4
)
SELECT	*, T2.total_product - T3.total_product
FROM	T2, T3
WHERE T2.staff_id = T3.staff_id
ORDER BY
		T2.staff_id




---KONTROL

SELECT	staff_id, A.order_id, B.product_id, quantity
FROM	SALE.orders A, sale.order_item B
WHERE	A.order_id = B.order_id
AND		A.staff_id = 2
ORDER BY
		1,2





--------///////

--Calculate the stores' weekly cumulative count of orders for 2018


--maðazalarýn 2018 yýlýna ait haftalýk kümülatif sipariþ sayýlarýný hesaplayýnýz




CREATE VIEW view7 AS
SELECT A.store_id, A.store_name, B.order_id, B.order_date, DATEPART(week, B.order_date) week_of_year
FROM sale.store A, sale.orders B
WHERE A.store_id = B.store_id;



SELECT  A.store_id, COUNT(DISTINCT B.order_id)
FROM view7
GROUP BY A.store_id, DATEPART(week, B.order_date)




-----



SELECT	DISTINCT A.store_id, A.store_name, DATEPART(WEEK, B.order_date) ord_week,
		COUNT(order_id) OVER (PARTITION BY A.store_id, DATEPART(WEEK, B.order_date)) cnt_order,
		COUNT(order_id) OVER (PARTITION BY A.store_id ORDER BY DATEPART(WEEK, B.order_date)) cumulative_cnt_order
FROM	sale.store A, sale.orders B
WHERE	A.store_id = B.store_id
AND		YEAR (B.order_date) = 2018





SELECT	 A.store_id, A.store_name, DATEPART(WEEK, B.order_date) ord_week, order_id,
		COUNT(order_id) OVER (PARTITION BY A.store_id, DATEPART(WEEK, B.order_date)) cnt_order,
		COUNT(order_id) OVER (PARTITION BY A.store_id ORDER BY DATEPART(WEEK, B.order_date)) cumulative_cnt_order
FROM	sale.store A, sale.orders B
WHERE	A.store_id = B.store_id
AND		YEAR (B.order_date) = 2018
ORDER BY 
		1,3


------------------------

-----/////


--Calculate 7-day moving average of the number of products sold between '2018-03-12' and '2018-04-12'.
--'2018-03-12' ve '2018-04-12' arasýnda satýlan ürün sayýsýnýn 7 günlük hareketli ortalamasýný hesaplayýn.


WITH T1 AS (
SELECT	order_date, SUM(B.quantity) as total_product
FROM	sale.orders A, sale.order_item B
WHERE	order_date BETWEEN '2018-03-12' AND '2018-04-12'
AND		A.order_id = B.order_id
GROUP BY
		order_date
)
SELECT *, AVG(total_product) OVER (ORDER BY order_date ROWS BETWEEN 3 PRECEDING AND 3 fOLLOWING) moving_avg
FROM	T1




SELECT	order_date, SUM(B.quantity), AVG(SUM(B.quantity)) OVER (ORDER BY order_date ROWS BETWEEN 3 PRECEDING AND 3 fOLLOWING)
FROM	sale.orders A, sale.order_item B
WHERE	order_date BETWEEN '2018-03-12' AND '2018-04-12'
AND		A.order_id = B.order_id
GROUP BY
		order_date



-----------------------------------



--Write a query that returns the highest daily turnover amount for each week on a yearly basis.
--Yýl bazýnda her haftaya ait en yüksek günlük ciro miktarýný döndüren bir sorgu yazýnýz.


SELECT	YEAR(order_date) ord_year, DATEPART(WEEK, order_date) ord_week, order_date, SUM(quantity*list_price*(1-discount)) turnover
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
GROUP BY 
		order_date
ORDER BY order_date




WITH T1 AS (
SELECT	YEAR(order_date) ord_year, DATEPART(WEEK, order_date) ord_week, order_date, SUM(quantity*list_price*(1-discount)) turnover
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
GROUP BY 
		order_date
)
SELECT	ord_year, ord_week, order_date,
		MAX(turnover) OVER (PARTITION BY ord_year, ord_week)
FROM	T1



WITH T1 AS (
SELECT	YEAR(order_date) ord_year, 
		DATEPART(WEEK, order_date) ord_week, order_date, 
		SUM(quantity*list_price*(1-discount)) turnover
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
GROUP BY 
		order_date
)
SELECT	ord_year, ord_week,
		MAX(turnover) max_turnover
FROM	T1
GROUP BY
		ord_year, ord_week
ORDER BY 1,2

;




WITH T1 AS (
SELECT	YEAR(order_date) ord_year, DATEPART(WEEK, order_date) ord_week, order_date, SUM(quantity*list_price*(1-discount)) turnover
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
GROUP BY 
		order_date
)
SELECT	DISTINCT ord_year, ord_week,
		FIRST_VALUE(turnover) OVER (PARTITION BY ord_year, ord_week ORDER BY turnover DESC) max_turnover
FROM	T1





--List customers whose have at least 2 consecutive orders are not shipped.
--Peþpeþe en az 2 sipariþi gönderilmeyen müþterileri bulunuz


SELECT	customer_id, order_id, shipped_date,
		CASE WHEN shipped_date IS NULL THEN 'Not Shipped'
				ELSE 'Shipped'
		END	IsShipped

FROM	sale.orders 
WHERE customer_id = 50
ORDER BY
		1,2




WITH T1 AS 
(
SELECT	customer_id, order_id, shipped_date,
		CASE WHEN shipped_date IS NULL THEN 'Not Shipped'
				ELSE 'Shipped'
		END	IsShipped

FROM	sale.orders 
), T2 AS (
SELECT *, LEAD(IsShipped) OVER (PARTITION BY customer_id ORDER BY order_id) next_order_shipping
FROM	T1
) 
SELECT *
FROM	T2
WHERE	T2.IsShipped = 'Not Shipped'
AND		T2.next_order_shipping = 'Not Shipped'


---------------

WITH T1 AS 
(
SELECT	customer_id, order_id, shipped_date,
		LEAD(shipped_date) OVER (PARTITION BY customer_id ORDER BY order_id) next_ord
FROM sale.orders
)
SELECT customer_id, COUNT(customer_id) count_c
FROM	T1
WHERE	shipped_date IS NULL AND next_ord IS NULL
GROUP BY customer_id
HAVING COUNT(customer_id) > 1











