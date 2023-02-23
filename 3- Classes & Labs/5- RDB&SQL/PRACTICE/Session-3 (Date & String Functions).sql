



SELECT 'Ali' AS [name], 'Yýlmaz' AS Last_Name, 25 AS PersonAge


SELECT	*
FROM	sale.customer



SELECT	TOP 10 *
FROM	sale.customer




SELECT	TOP 10 *
FROM	sale.customer
ORDER BY
		customer_id --ASC




SELECT	TOP 10 *
FROM	sale.customer
ORDER BY
		customer_id DESC





SELECT	TOP 10 *
FROM	sale.customer
ORDER BY
		first_name, last_name DESC


-------------


SELECT	*
FROM	sale.customer
WHERE	city = 'Austin'
		

--------


SELECT	*
FROM	sale.customer
WHERE	city = 'Austin'
		OR
		city = 'Allen'

--------


SELECT	*
FROM	sale.customer
WHERE	city IN ('Austin', 'Allen', 'Charlotte')


-----

SELECT	*
FROM	sale.customer
WHERE	city NOT IN ('Austin', 'Allen', 'Charlotte')

----


SELECT	*
FROM	sale.customer
WHERE	city != 'Austin'
		AND
		city <> 'Allen'


----------------

SELECT	*
FROM	sale.customer
WHERE	city LIKE '%usti%'



SELECT	*
FROM	sale.customer
WHERE	city LIKE '%usti_'



----Austin þehrinde kaç müþteri var?

SELECT	COUNT (*) AS cnt_customer
FROM	sale.customer
WHERE	city = 'Austin'


SELECT	COUNT (customer_id) AS cnt_customer
FROM	sale.customer
WHERE	city = 'Austin'



--
SELECT	 COUNT(DISTINCT customer_id)
FROM	sale.customer
WHERE	city = 'Allen'


SELECT	 COUNT(customer_id)
FROM	sale.customer
WHERE	city = 'Allen'


---sipariþ veren kaç farklý müþteri var?


SELECT COUNT(DISTINCT customer_id)
FROM	sale.orders



SELECT	*
FROM	sale.orders
ORDER BY 
		2 DESC


--------------------


SELECT	DISTINCT city
FROM	sale.customer

-------------


SELECT	COUNT (order_id)
FROM	sale.orders
WHERE	order_date BETWEEN '2018-01-01' AND '2018-02-28'


---------------------------



---Date Functions


---GETDATE()

SELECT GETDATE()


-- Data Types


DROP TABLE t_date_time

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)


SELECT *
FROM	t_date_time


INSERT t_date_time VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())



SELECT GETDATE();

SELECT *
FROM	t_date_time


INSERT t_date_time VALUES ('13:10:15','2023-02-07','2023-02-07','2023-02-07','2023-02-07','2023-02-07')


----------------------



----


SELECT DATENAME(WEEKDAY, GETDATE())

SELECT DATENAME(MONTH, GETDATE())


SELECT DATENAME(DAYOFYEAR, GETDATE())


SELECT DATEPART(DAYOFYEAR, GETDATE())



SELECT DATEPART(MONTH, GETDATE())



SELECT DATEPART(WEEKDAY, GETDATE())


SELECT DATEPART(ISOWK, GETDATE())


SELECT GETDATE()


SELECT DATEPART(SECOND, GETDATE())


SELECT DAY(GETDATE())

SELECT MONTH(GETDATE())

SELECT YEAR(GETDATE())



------------------


SELECT	*, DATEDIFF(DAY, order_date, shipped_date) shipping_date
FROM	sale.orders



SELECT *, YEAR(order_date)
FROM	sale.orders


-----


SELECT DATEADD (HOUR, -5, GETDATE())



SELECT DATEADD (HOUR, 5, GETDATE())


SELECT DATEADD (DAY, 5, GETDATE())


-------


SELECT	*, EOMONTH(order_date)
FROM	sale.orders



---------


SELECT ISDATE('2023.02.07')

SELECT ISDATE('2023-02-07')


SELECT ISDATE('2023/02/07')

SELECT ISDATE('02-07-2023')

SELECT ISDATE('13-02-2023')


----


-----//////////////////


--Write a query returns orders that are shipped more than two days after the order date. 
--2 günden geç kargolanan sipariþlerin bilgilerini getiriniz.


SELECT *, DATEDIFF (DAY, order_date, shipped_date) DATEDIF
FROM	sale.orders
Where	DATEDIFF (DAY, order_date, shipped_date) > 2



---------STRING FUNCTIONS

SELECT LEN('CHARACTER')

SELECT CHARINDEX('H', 'CHARACTER')


SELECT CHARINDEX('HAR', 'CHARACTER')



SELECT CHARINDEX('R', 'CHARACTER')


SELECT CHARINDEX('R', 'CHARACTER', 5)


SELECT PATINDEX('%HAR%', 'CHARACTER')


SELECT PATINDEX('_HAR%', 'CHARACTER')

-------------


SELECT LEFT('CHARACTER', 1)

SELECT LEFT('CHARACTER', 3)

SELECT RIGHT('CHARACTER', 3)


SELECT SUBSTRING('CHARACTER', 1, 3)


SELECT SUBSTRING('CHARACTER', 3, 2)

SELECT SUBSTRING('CHARACTER', 3, 1)


SELECT SUBSTRING('CHARACTER', 1, LEN('CHARACTER'))

SELECT SUBSTRING('CHARACTER', 1, 9)








