


-- 2018 model ürünü olan markalarýndan hangilerinin 2019 model ürünü yoktur?
-- brand_id ve brand_name deðerlerini listeleyin



SELECT	DISTINCT A.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	model_year = 2018
AND		A.brand_id = B.brand_id

EXCEPT

SELECT	DISTINCT A.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	model_year = 2019
AND		A.brand_id = B.brand_id



------------------

--Sadece 2019 yýlýnda sipariþ verilen diðer yýllarda sipariþ verilmeyen ürünleri getiriniz.



SELECT  B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C
WHERE A.order_id = B.order_id AND B.product_id = C.product_id AND YEAR(A.order_date)=2019

EXCEPT

SELECT  B.product_id, C.product_name
FROM sale.orders A, sale.order_item B, product.product C
WHERE A.order_id = B.order_id AND B.product_id = C.product_id AND YEAR(A.order_date) <> 2019


------ CASE EXPRESSION ------

------ Simple Case Expression -----

-- Create  a new column with the meaning of the  values in the Order_Status column. 
--Order_Status isimli alandaki deðerlerin ne anlama geldiðini içeren yeni bir alan oluþturun.


-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed



SELECT	order_id, order_status,
		CASE order_status WHEN 1 THEN 'Pending'
						  WHEN 2 THEN 'Processing'
						  WHEN 3 THEN 'Rejected'
						  WHEN 4 THEN 'Completed'
		END AS order_status_mean
FROM	SALE.orders



----SEARCHED CASE EXPRESSION

SELECT	order_id, order_status,
		CASE    		  WHEN order_status = 1 THEN 'Pending'
						  WHEN order_status = 2 THEN 'Processing'
						  WHEN order_status = 3 THEN 'Rejected'
						  WHEN order_status = 4 THEN 'Completed'
		END AS order_status_mean
FROM	SALE.orders



-- ////////////

-- Create a new column that shows which email service provider ("Gmail", "Hotmail", "Yahoo" or "Other" ).
--MüþterilERÝN e-mail adreslerindeki servis saðlayýcýlarýný yeni bir sütun oluþturarak belirtiniz.


SELECT	customer_id, first_name, last_name, email, 
		CASE WHEN email LIKE '%@gmail%'THEN 'Gmail'
			 WHEN email LIKE '%@Hotmail%' THEN 'Hotmail'
			 WHEN email LIKE '%@Yahoo%' THEN 'Yahoo'
			 ELSE 'Other'
		END	AS email_serv_prov
FROM	sale.customer



-- Write a query that gives the first and last names of customers who have ordered products from the computer accessories, speakers, and mp4 player categories in the same order.
-- Ayný sipariþte hem mp4 player, hem Computer Accessories hem de Speakers kategorilerinde ürün sipariþ veren müþterileri bulunuz.




SELECT	A.customer_id, A.first_name, A.last_name, B.order_id
FROM	sale.customer A, sale.orders B, SALE.order_item C, product.product D, product.category E
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		D.category_id = E.category_id
AND		E.category_name = 'mp4 player'

INTERSECT

SELECT	A.customer_id, A.first_name, A.last_name, B.order_id
FROM	sale.customer A, sale.orders B, SALE.order_item C, product.product D, product.category E
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		D.category_id = E.category_id
AND		E.category_name = 'Computer Accessories'

INTERSECT

SELECT	A.customer_id, A.first_name, A.last_name, B.order_id
FROM	sale.customer A, sale.orders B, SALE.order_item C, product.product D, product.category E
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		D.category_id = E.category_id
AND		E.category_name = 'Speakers'



----


SELECT	A.customer_id, A.first_name, A.last_name, B.order_id,

		SUM (CASE WHEN E.category_name = 'Speakers' THEN 1 ELSE 0 END) AS speakers,
		SUM (CASE WHEN E.category_name = 'Computer Accessories' THEN 1 ELSE 0 END) AS Computer_Accessories,
		SUM (CASE WHEN E.category_name = 'mp4 player' THEN 1 ELSE 0 END) AS mp4_player

FROM	sale.customer A, sale.orders B, SALE.order_item C, product.product D, product.category E
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		D.category_id = E.category_id
GROUP BY
		A.customer_id, A.first_name, A.last_name, B.order_id
HAVING
		SUM (CASE WHEN E.category_name = 'Speakers' THEN 1 ELSE 0 END) > 0
		AND
		SUM (CASE WHEN E.category_name = 'Computer Accessories' THEN 1 ELSE 0 END)>0
		AND
		SUM (CASE WHEN E.category_name = 'mp4 player' THEN 1 ELSE 0 END)>0


-----------------


----- SUBQUERIES ----


------ SINGLE ROW SUBQUERIES ------



----///////


--Write a query that shows all employees in the store where Davis Thomas works.

-- Davis Thomas'nýn çalýþtýðý maðazadaki tüm personelleri listeleyin.


SELECT	store_id
FROM	sale.staff
WHERE	first_name = 'Davis'
AND		last_name = 'Thomas'



SELECT *
FROM sale.staff 
WHERE store_id = 1 


SELECT *
FROM sale.staff 
WHERE store_id = (
					SELECT	store_id
					FROM	sale.staff
					WHERE	first_name = 'Davis'
					AND		last_name = 'Thomas'
					);



-- /////////

-- Write a query that shows the employees for whom Charles Cussona is a first-degree manager. 
--(To which employees are Charles Cussona a first-degree manager?)
-- Charles	Cussona 'ýn yöneticisi olduðu personelleri listeleyin.



SELECT *
FROM	sale.staff
WHERE	 first_name = 'Charles'
AND		last_name = 'Cussona'



SELECT *
FROM	sale.staff
WHERE	manager_id = (
						SELECT	staff_id
						FROM	sale.staff
						WHERE	 first_name = 'Charles'
						AND		last_name = 'Cussona'
						)


--------------

--//////

--Write a query that returns the list of products that are more expensive than the product named 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'

-- 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)' isimli üründen pahalý olan ürünleri listeleyin.
-- Product id, product name, model_year, fiyat  alanlarýna ihtiyaç duyulmaktadýr.


SELECT *
FROM product.product
WHERE product_name = 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'






SELECT *
FROM product.product
WHERE list_price > 4295.98


SELECT *
FROM product.product
WHERE list_price > (
					SELECT list_price
					FROM product.product
					WHERE product_name = 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
					)


------ MULTIPLE ROW SUBQUERIES ------


--/////////////////


-- Write a query that returns customer first names, last names and order dates. 
-- The customers who are order on the same dates as Laurel Goldammer.

-- Laurel Goldammer isimli müþterinin alýþveriþ yaptýðý tarihte/tarihlerde alýþveriþ yapan tüm müþterileri listeleyin.


SELECT	order_date
FROM	sale.orders A, sale.customer B
WHERE	A.customer_id = B.customer_id
AND		B.first_name = 'Laurel'
AND		B.last_name = 'Goldammer'



SELECT	A.order_id, A.order_date, B.customer_id, B.first_name, B.last_name
FROM	sale.orders A, SALE.customer B
WHERE	A.customer_id = B.customer_id
AND		order_date IN (
							SELECT	order_date
							FROM	sale.orders A, sale.customer B
							WHERE	A.customer_id = B.customer_id
							AND		B.first_name = 'Laurel'
							AND		B.last_name = 'Goldammer'
						)


-----/////////////



--List the products that ordered in the last 10 orders in Buffalo city.
-- Buffalo þehrinde son 10 sipariþte sipariþ verilen ürünleri listeleyin.


SELECT	TOP 10 order_id
FROM	sale.orders A, sale.customer B
WHERE	A.customer_id = B.customer_id
AND		B.city = 'Buffalo'
ORDER BY
		order_id DESC



SELECT	A.product_id, B.product_name
FROM	sale.order_item A, product.product B
WHERE	A.product_id = B.product_id
AND		order_id IN (
						SELECT	TOP 10 order_id
						FROM	sale.orders A, sale.customer B
						WHERE	A.customer_id = B.customer_id
						AND		B.city = 'Buffalo'
						ORDER BY
								order_id DESC)

------ANY


SELECT	A.product_id, B.product_name
FROM	sale.order_item A, product.product B
WHERE	A.product_id = B.product_id
AND		order_id = ANY (
						SELECT	TOP 10 order_id
						FROM	sale.orders A, sale.customer B
						WHERE	A.customer_id = B.customer_id
						AND		B.city = 'Buffalo'
						ORDER BY
								order_id DESC)






