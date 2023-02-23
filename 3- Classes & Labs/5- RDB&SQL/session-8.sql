

-------------------------------- SESSION 8 SUBQUERIES & CTE'S

-- //////

--Write a query that returns the product_names and list price that were made in 2021. 
--(Exclude the categories that match Game, gps, or Home Theater )

-- Game, gps veya Home Theater haricindeki kategorilere ait ürünleri listeleyin.
-- Sadece 2021 model yýlýna ait ürünlerin adý ve fiyat bilgilerini listeleyin.



SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2021
AND		category_id NOT IN (
								SELECT	category_id
								FROM	product.category
								WHERE	category_name IN ('Game', 'gps', 'Home Theater')
							)
ORDER BY
		2 DESC


SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2021
AND		category_id <> ALL (
								SELECT	category_id
								FROM	product.category
								WHERE	category_name IN ('Game', 'gps', 'Home Theater')
							)
ORDER BY
		2 DESC


-------------------

---//////

--Write a query that returns the list of product names that were made in 2020 
--and whose prices are higher than maximum product list price of Receivers Amplifiers category.

-- 2020 model olup Receivers Amplifiers kategorisindeki en pahalý üründen daha pahalý ürünleri listeleyin.
-- Ürün adý, model_yýlý ve fiyat bilgilerini yüksek fiyattan düþük fiyata doðru sýralayýnýz.


SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2020
AND		list_price > (
						SELECT	MAX(list_price)
						FROM	product.product A, product.category B
						WHERE	A.category_id = B.category_id
						AND		B.category_name = 'Receivers Amplifiers'
						)


SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2020
AND		list_price > ALL (
						SELECT	list_price
						FROM	product.product A, product.category B
						WHERE	A.category_id = B.category_id
						AND		B.category_name = 'Receivers Amplifiers'
						)



--///////

-- Write a query that returns the list of product names that were made in 2020 
-- and whose prices are higher than minimum product list price of Receivers Amplifiers category.

-- Receivers Amplifiers kategorisindeki ürünlerin herhangi birinden yüksek fiyatlý ürünleri listeleyin.
-- Ürün adý, model_yýlý ve fiyat bilgilerini yüksek fiyattan düþük fiyata doðru sýralayýnýz.



SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2020
AND		list_price >  (
						SELECT	MIN(list_price)
						FROM	product.product A, product.category B
						WHERE	A.category_id = B.category_id
						AND		B.category_name = 'Receivers Amplifiers'
						)


----

SELECT	product_name, list_price 
FROM	product.product
WHERE	model_year = 2020
AND		list_price > ANY (
							SELECT	list_price
							FROM	product.product A, product.category B
							WHERE	A.category_id = B.category_id
							AND		B.category_name = 'Receivers Amplifiers'
						)



---------EXISTS


SELECT *
FROM	sale.customer
WHERE	EXISTS (SELECT 1)


SELECT *
FROM	sale.customer A
WHERE	EXISTS (
					SELECT	1
					FROM	sale.orders B
					WHERE	order_date > '2020-01-01'
					AND		A.customer_id = B.customer_id
					)

---------------

SELECT *
FROM	sale.customer A
WHERE	A.customer_id IN (
								SELECT	customer_id
								FROM	sale.orders B
								WHERE	order_date > '2020-01-01'
								)

---------

SELECT *
FROM	sale.customer A
WHERE	EXISTS (
					SELECT	1
					FROM	sale.orders B
					WHERE	order_date > '2020-01-01'
					)


-------------------

---NOT EXISTS

SELECT *
FROM	SALE.customer
WHERE	NOT EXISTS (SELECT 1)



---Yalnýzca 2020 yýlýndan önce sipariþ veren müþterilerin bilgilerini getiriniz.

SELECT *
FROM	SALE.customer A
WHERE	NOT EXISTS (
					SELECT	1
					FROM	sale.orders B
					WHERE	order_date > '2020-01-01'
					AND		A.customer_id = B.customer_id
					)

-----------

SELECT *
FROM	SALE.customer A
WHERE	customer_id NOT IN (
							SELECT	customer_id
							FROM	sale.orders B
							WHERE	order_date > '2020-01-01'
							AND		A.customer_id = B.customer_id
							)

---------


SELECT *
FROM	SALE.customer A
WHERE	NOT EXISTS (
					SELECT	1
					FROM	sale.orders B
					WHERE	order_date > '2020-01-01'
					)


-----------

SELECT *
FROM	SALE.customer A
WHERE	NOT EXISTS (
					SELECT	1
					FROM	sale.orders B
					WHERE	order_date > '2022-01-01'
					)





--Write a query that returns a list of States where 'Apple - Pre-Owned iPad 3 - 32GB - White' product is not ordered
-- 'Apple - Pre-Owned iPad 3 - 32GB - White' isimli ürünün sipariþ verilmediði state' leri döndüren bir sorgu yazýnýz. (müþterilerin state' leri üzerinden)



select	DISTINCT D.[state]
from	sale.customer D
where	not exists (
					select 11
					from product.product A,sale.orders B,sale.order_item C, sale.customer E
					where A.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White' 
					and B.order_id=C.order_id 
					and A.product_id=C.product_id 
					AND	B.customer_id = E.customer_id
					and D.state = E.state
					)


					---

select	DISTINCT D.[state]
from	sale.customer D
where	D.state NOT IN (
							select E.state
							from	product.product A,sale.orders B,sale.order_item C, sale.customer E
							where	A.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White' 
							and		B.order_id=C.order_id 
							and		A.product_id=C.product_id 
							AND		B.customer_id = E.customer_id
							)


----

SELECT DISTINCT state
FROM sale.customer
EXCEPT
SELECT DISTINCT A.state
FROM sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id AND B.order_id = C.order_id 
AND C.product_id = D.product_id AND D.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
ORDER BY 1



-----


----///////////////////////////


--Write a query that returns stock information of the products in Davi techno Retail store. 
--The BFLO Store hasn't  got any stock of that products.

--Davi techno maðazasýndaki ürünlerin stok bilgilerini döndüren bir sorgu yazýn. 
--Bu ürünlerin The BFLO Store maðazasýnda stoðu bulunmuyor.


SELECT	COUNT (DISTINCT product_id)
FROM	product.stock



SELECT  B.*
FROM	sale.store A, product.stock B
WHERE	store_name = 'Davi techno Retail'
AND		A.store_id = B.store_id
AND		B.quantity > 0
AND		NOT EXISTS (
					SELECT  Y.*
					FROM	sale.store X, product.stock Y
					WHERE	store_name = 'The BFLO Store'
					AND		X.store_id = Y.store_id
					AND		Y.quantity > 0
					AND		B.product_id = Y.product_id
					)



------------------------------

SELECT  B.*
FROM	sale.store A, product.stock B
WHERE	store_name = 'Davi techno Retail'
AND		A.store_id = B.store_id
AND		B.quantity > 0
AND		EXISTS (
					SELECT  Y.*
					FROM	sale.store X, product.stock Y
					WHERE	store_name = 'The BFLO Store'
					AND		X.store_id = Y.store_id
					AND		Y.quantity = 0
					AND		B.product_id = Y.product_id
					)


--Subquery in SELECT Statement

--Write a query that creates a new column named "total_price" calculating the total prices of the products on each order.
--order id' lere göre toplam list price larý hesaplayýn.


SELECT	DISTINCT order_id, 
		(SELECT SUM(list_price) FROM sale.order_item A) total_price
FROM	sale.order_item B



SELECT	DISTINCT order_id, 
		(SELECT SUM(list_price) FROM sale.order_item A WHERE A.order_id = B.order_id) total_price
FROM	sale.order_item B



----------////////////////////------------

------ CTE's ------

--ORDINARY CTE's

-- Query Time


--List customers who have an order prior to the last order date of a customer named Jerald Berray and are residents of the city of Austin. 

-- Jerald Berray isimli müþterinin son sipariþinden önce sipariþ vermiþ 
--ve Austin þehrinde ikamet eden müþterileri listeleyin.

WITH T1 AS 
(
SELECT	MAX(order_date) last_order
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Jerald'
AND		A.last_name = 'Berray'
)
SELECT	T1.last_order, A.order_id, A.order_date, b.*
FROM	T1, sale.orders A, sale.customer B
WHERE	T1.last_order > A.order_date
AND		A.customer_id = B.customer_id
AND		B.city = 'Austin'



---///////////


-- List all customers their orders are on the same dates with Laurel Goldammer.

-- Laurel Goldammer isimli müþterinin alýþveriþ yaptýðý tarihte/tarihlerde alýþveriþ yapan tüm müþterileri listeleyin.
-- Müþteri adý, soyadý ve sipariþ tarihi bilgilerini listeleyin.


WITH T1 AS 
(
SELECT	order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Laurel'
AND		A.last_name = 'Goldammer'
)
SELECT	B.first_name, B.last_name, A.order_date
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id = B.customer_id
AND		A.order_date = T1.order_date




-- //////

--List products their model year are 2021 and their categories other than Game, gps, or Home Theater.
-- Game, gps, or Home Theater haricindeki kategorilere ait ürünlerden sadece 2021 model yýlýna ait 
--ürünlerin isim ve fiyat bilgilerini listeleyin.



WITH T1 AS
(
SELECT *
FROM product.product
WHERE model_year = 2021
)
SELECT T1.product_name, T1.list_price
FROM T1, product.category A
WHERE T1.category_id = A.category_id AND A.category_name NOT IN ('Game', 'gps', 'Home Theater')


----------


-----////////////////////-------


--RECURSIVE CTE's 


-- Create a table with a number in each row in ascending order from 0 to 9.

-- 0'dan 9'a kadar herbir rakam bir satýrda olacak þekide bir tablo oluþturun.



WITH T1 AS 
(
	SELECT 0 RAKAM
	UNION ALL
	SELECT RAKAM + 1
	FROM	T1
	WHERE	RAKAM < 9
	)
SELECT RAKAM
FROM	T1



------//////////////////


--List the stores whose turnovers are under the average store turnovers in 2018.
--2018 yýlýnda tüm maðazalarýn ortalama cirosunun altýnda ciroya sahip maðazalarý listeleyin.

WITH T1 AS 
(
SELECT  A.store_name, SUM (C.quantity* C.list_price* (1-C.discount)) store_turnover
FROM	sale.store A, sale.orders B, sale.order_item C
WHERE	A.store_id = B.store_id 
AND		B.order_id = C.order_id
AND		B.order_date BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY
		A.store_name
), 
T2 AS 
(
SELECT AVG(store_turnover) avg_turnover
FROM T1
)
SELECT	T1.store_name, T1.store_turnover, T2.avg_turnover
FROM	T2, T1
WHERE	T1.store_turnover < T2.avg_turnover



----------------




-----------/////////////


-- Write a query that returns the net amount of their first order for customers who placed their first order after 2019-10-01.
--Ýlk sipariþini 2019-10-01 tarihinden sonra veren müþterilerin ilk sipariþlerinin net tutarýný döndürünüz.

WITH T1 AS
(
	SELECT	customer_id, MIN(order_date) first_order_date
	FROM	sale.orders
	GROUP BY
			customer_id
	HAVING
			MIN(order_date) > '2019-10-01'
) , T2 AS
(
	SELECT	T1.customer_id, MIN(A.order_id) first_order
	FROM	sale.orders A, T1 
	WHERE	A.customer_id = T1.customer_id
	GROUP BY
			T1.customer_id
)
SELECT	T2.customer_id, A.order_id, SUM(quantity*list_price*(1-discount))
FROM	T2, sale.order_item A
WHERE	T2.first_order = A.order_id
GROUP BY
		T2.customer_id, A.order_id

		;

		----------------------

		
WITH T1 AS
(
	SELECT	customer_id, MIN(order_date) first_order_date, MIN(order_id) first_order
	FROM	sale.orders
	GROUP BY
			customer_id
	HAVING
			MIN(order_date) > '2019-10-01'
) 
SELECT	T1.customer_id, A.order_id, SUM(quantity*list_price*(1-discount)) net_amount
FROM	T1, sale.order_item A
WHERE	T1.first_order = A.order_id
GROUP BY
		T1.customer_id, A.order_id