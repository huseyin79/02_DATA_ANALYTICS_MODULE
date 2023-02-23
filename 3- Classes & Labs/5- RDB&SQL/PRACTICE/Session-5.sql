


---Session 5


-- Maðaza çalýþanlarýný yaptýklarý satýþlar ile birlikte listeleyin


SELECT *
FROM	sale.staff


SELECT	COUNT(DISTINCT staff_id)
FROM	sale.orders


SELECT	A. staff_id, A.first_name, A.last_name, B.*
FROM	sale.staff AS A LEFT JOIN sale.orders AS B
		ON	A.staff_id = B.staff_id



SELECT	B.staff_id, B.first_name, B.last_name, A.*
FROM	sale.orders AS A RIGHT JOIN sale.staff AS B
		ON	A.staff_id = B.staff_id


-------------

-- Ürünlerin stok miktarlarý ve sipariþ bilgilerini birlikte listeleyin


SELECT	COUNT(DISTINCT product_id)
FROM	product.stock

SELECT	COUNT(DISTINCT product_id)
FROM	sale.order_item


SELECT	DISTINCT A.product_id, A.product_name,  B.product_id AS ISINSTOCK, C.product_id AS ISORDER
FROM	product.product AS A
		FULL OUTER JOIN
		product.stock AS B
		ON	A.product_id = B.product_id
		FULL OUTER JOIN 
		sale.order_item AS C
		ON	A.product_id = C.product_id


-----------------


--stock tablosunda olmayýp product tablosunda mevcut olan ürünlerin stock tablosuna tüm storelar için kayýt edilmesi gerekiyor. 
--stoðu olmadýðý için quantity leri 0 olmak zorunda
--Ve bir product id tüm store' larýn stockuna eklenmesi gerektiði için cross join yapmamýz gerekiyor.


SELECT	COUNT(DISTINCT product_id)
FROM	product.stock



SELECT	product_id, store_id, 0 AS quantity
FROM	product.product 
		CROSS JOIN 
		sale.store
WHERE	product_id NOT IN (SELECT product_id FROM product.stock)
ORDER BY 1


----


SELECT *
FROM sale.staff

-- Çalýþan adý ve yönetici adý bilgilerini getirin

SELECT first_name, manager_id
FROM sale.staff


SELECT A.first_name AS STAFF_NAME, B.first_name AS MANAGER_NAME
FROM sale.staff AS A
	 LEFT JOIN
	 sale.staff AS B
	 ON	A.manager_id = B.staff_id



---VIEWS


CREATE VIEW sp_view1 AS
SELECT *
FROM sale.orders
WHERE	order_date BETWEEN '2019-05-02' AND '2020-05-02'


SELECT *
FROM sp_view1


--------------------------------///////////////////////////



----Advance Grouping Op.



--Having


----product tablosunda herhangi bir product id' nin çoklayýp çoklamadýðýný kontrol ediniz.


SELECT	product_id, COUNT(*) cnt_row
FROM	product.product
GROUP BY
		product_id
HAVING
		 COUNT(*) > 1


-----


SELECT	product_name, COUNT(*) cnt_row
FROM	product.product
GROUP BY
		product_name
HAVING
		 COUNT(*) > 1



SELECT *
FROM product.product
WHERE	product_name = '240GB SSD Plus SATA III 2.5 Internal SSD'



-----

--maximum list price' ý 4000' in üzerinde olan veya minimum list price' ý 500' ün altýnda olan categori id' leri getiriniz



SELECT *
FROM	product.product
ORDER BY category_id, list_price

-----------



SELECT category_id, MAX(list_price) max_price ,MIN(list_price) min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 AND MIN(list_price) < 500



SELECT category_id, MAX(A.list_price) max_price ,MIN(A.list_price) min_price
FROM product.product A
GROUP BY
	category_id
HAVING
	MAX(A.list_price)>4000
	OR
	MIN(A.list_price)<500


-----------


--Markalara ait ortalama ürün fiyatlarýný bulunuz.
--ortalama fiyatlara göre azalan sýrayla gösteriniz.



SELECT	brand_name, AVG(list_price) avg_price
FROM	product.product AS A, product.brand B
WHERE	A.brand_id = B.brand_id
GROUP BY
		brand_name
ORDER BY
		2 DESC




SELECT B.brand_name, AVG(A.list_price) avg_price
FROM product.product AS A, product.brand AS B
WHERE A.brand_id=B.brand_id
GROUP BY B.brand_name
ORDER BY AVG(A.list_price) DESC


-------


SELECT brand_name, avg(A.list_price)
FROM product.product A,product.brand B
where A.brand_id=B.brand_id
GROUP BY
	brand_name
ORDER BY
	avg(A.list_price) DESC


----------

---ortalama ürün fiyatý 1000' den yüksek olan MARKALARI getiriniz


SELECT brand_name, avg(A.list_price)
FROM product.product A,product.brand B
where A.brand_id=B.brand_id
GROUP BY
	brand_name
HAVING	avg(A.list_price) >1000
ORDER BY
	avg(A.list_price) DESC


-------------

--bir sipariþin toplam net tutarýný getiriniz. (müþterinin sipariþ için ödediði tutar)
--discount' ý ve quantity' yi ihmal etmeyiniz.


SELECT	*, list_price * quantity * (1-discount)
FROM	sale.order_item


SELECT	order_id, SUM(list_price * quantity * (1-discount)) net_amount
FROM	sale.order_item
GROUP BY
		order_id



--------------------

--State' lerin aylýk sipariþ sayýlarýný hesaplayýnýz



SELECT	A.state, YEAR(B.order_date) ORD_YEAR, MONTH(B.order_date) ORD_MONTH, COUNT(order_id)
FROM	sale.customer AS A
		INNER JOIN
		sale.orders AS B
		ON	A.customer_id = B.customer_id
GROUP BY
		A.state, YEAR(B.order_date), MONTH(B.order_date)
ORDER BY
		state, 2,3



---------------------/////////////


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



























