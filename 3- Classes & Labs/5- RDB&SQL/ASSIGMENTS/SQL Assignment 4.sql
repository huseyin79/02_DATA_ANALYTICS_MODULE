

-----------SESSION 12 SQL PROGRAMMING BASICS

CREATE PROCEDURE sp_order_product_cnt AS
SELECT	order_id, SUM(quantity) total_product
FROM	sale.order_item
GROUP BY	
		order_id




sp_order_product_cnt


EXEC sp_order_product_cnt


EXECUTE sp_order_product_cnt



ALTER PROC sp_order_product_cnt AS
BEGIN
	SELECT 'Welcome' [message]
END



EXEC sp_order_product_cnt


ALTER PROC sp_order_product_cnt AS
BEGIN
	SELECT 'Welcome' [message]
END



ALTER PROC sp_order_product_cnt AS
BEGIN
	PRINT 'Welcome'
END


EXEC sp_order_product_cnt


DROP PROC sp_order_product_cnt





CREATE TABLE ORDER_TBL 
(
ORDER_ID TINYINT NOT NULL,
CUSTOMER_ID TINYINT NOT NULL,
CUSTOMER_NAME VARCHAR(50),
ORDER_DATE DATE,
EST_DELIVERY_DATE DATE--estimated delivery date
);



INSERT ORDER_TBL VALUES (1, 1, 'Adam', GETDATE()-10, GETDATE()-5 ),
						(2, 2, 'Smith',GETDATE()-8, GETDATE()-4 ),
						(3, 3, 'John',GETDATE()-5, GETDATE()-2 ),
						(4, 4, 'Jack',GETDATE()-3, GETDATE()+1 ),
						(5, 5, 'Owen',GETDATE()-2, GETDATE()+3 ),
						(6, 6, 'Mike',GETDATE(), GETDATE()+5 ),
						(7, 7, 'Rafael',GETDATE(), GETDATE()+5 ),
						(8, 8, 'Johnson',GETDATE(), GETDATE()+5 )


SELECT *
FROM ORDER_TBL




CREATE TABLE ORDER_DELIVERY
(
ORDER_ID TINYINT NOT NULL,
DELIVERY_DATE DATE -- real delivery date
);


SET NOCOUNT ON 
INSERT ORDER_DELIVERY VALUES (1, GETDATE()-6 ),
				(2, GETDATE()-2 ),
				(3, GETDATE()-2 ),
				(4, GETDATE() ),
				(5, GETDATE()+2 ),
				(6, GETDATE()+3 ),
				(7, GETDATE()+5 ),
				(8, GETDATE()+5 )


SELECT *
FROM ORDER_DELIVERY

-------------



ALTER PROC sp_order_product_cnt AS
BEGIN
		SELECT MAX(ORDER_ID) last_order_id
		FROM order_tbl
END;


EXEC sp_order_product_cnt


INSERT ORDER_TBL VALUES (10,10, NULL , NULL, NULL)


SELECT *
FROM ORDER_TBL



EXEC sp_order_product_cnt


----------------------

--istediðimiz tarihe ait sipariþ sayýsýný nasýl getirebiliriz?


ALTER PROC sp_order_product_cnt (@day DATE) AS
BEGIN
		SELECT	COUNT(DISTINCT ORDER_ID) cnt_order
		FROM	order_tbl
		WHERE	ORDER_DATE = @day
END;


EXEC sp_order_product_cnt '2023-02-20'



----Ýstenilen müþterinin istenilen tarihteki sipariþlerini döndüren bir prosedür yazýn.




ALTER PROC sp_order_product_cnt (@cust_name VARCHAR(20), @day DATE = NULL) AS
BEGIN
	
		SELECT	COUNT(DISTINCT ORDER_ID) cnt_order
		FROM	order_tbl
		WHERE	customer_name = @cust_name
		AND		ORDER_DATE = @day
END;


EXEC sp_order_product_cnt 'Jack', '2023-02-17'



SELECT *
FROM ORDER_TBL


-----------------------


DECLARE @V1 INT
DECLARE @V2 INT
DECLARE @RESULT INT

SET @V1 = 5
SET @V2 = 6
SET @RESULT = @V1*@V2


SELECT @RESULT RESULT


-----


DECLARE @V1 INT = 4
DECLARE @V2 INT = 3
DECLARE @RESULT INT


SET @V1 = 5


SELECT @RESULT = @V1*@V2


PRINT @RESULT 


------------



DECLARE @V1 INT, @V2 INT, @RESULT INT


SELECT @V1 = 4, @V2 = 5, @RESULT = @V1*@V2


SELECT @RESULT RESULT


-------


DECLARE @VAR INT = 5

SELECT *
FROM	ORDER_TBL
WHERE	ORDER_ID = @VAR




--------------

DECLARE @VAR INT 

SELECT	@VAR = COUNT(ORDER_ID)
FROM	ORDER_TBL
WHERE	ORDER_DATE = '2023-02-20'

SELECT @VAR 


-----------------------------------


---IF, ELSE IF, ELSE


IF CONDITION
	PROCESS
ELSE IF CONDITION2
	PROCESS
ELSE PROCESS





IF EXISTS (SELECT 1)
	SELECT *
	FROM	 ORDER_TBL



IF NOT EXISTS (SELECT 1)
	SELECT *
	FROM	 ORDER_TBL
ELSE
	PRINT 'ANY RESULT'


---------------


DECLARE @VAR INT = 6

IF @VAR > 10
	SELECT *
	FROM ORDER_TBL
ELSE IF  @VAR = 7
	PRINT 'VAR EQUAL TO 7'
ELSE
	PRINT 'NO RESULT'



---------------

---iki deðiþken tanýmlayýn, 
--eðer biri diðerine eþitse iki deðeri çarpýn
--eðer deðiþken1 deðiþken2 ' den küçükse iki deðiþkeni toplayýn
--deðiþken2 deðiþken1 ' den küçükse deðiþken1' den deðiþken2' yi çýkarýn.


DECLARE @V1 INT , @V2 INT

DECLARE @RESULT INT

SET @V1 = 5

SET @V2 = 6

IF @V1 = @V2 
	SELECT @V1*@V2
ELSE IF @V1<@V2
	SELECT @RESULT = @V1+@V2  
ELSE
	PRINT @V1-@V2

PRINT @RESULT


---Ýstenilen tarihte verilen sipariþ sayýsý 2 ten küçükse 'lower than 2',
-- 2 ile 5 arasýndaysa sipariþ sayýsý, 5' den büyükse 'upper than 5' yazdýran bir sorgu yazýnýz.


DECLARE @DAY DATE

SET @DAY = '2023-02-17'

DECLARE @order_cnt INT

SELECT	@order_cnt = COUNT(DISTINCT ORDER_ID)
FROM	ORDER_TBL
WHERE	ORDER_DATE = @DAY

IF @order_cnt < 2
	PRINT 'lower than 2'
ELSE IF @order_cnt BETWEEN 2 AND 5
	SELECT @order_cnt
ELSE
	PRINT 'upper than 5'




CREATE PROC sp_sample_order (@DAY DATE) AS
BEGIN
	DECLARE @order_cnt INT

	SELECT	@order_cnt= COUNT(DISTINCT ORDER_ID)
	FROM	ORDER_TBL
	WHERE	ORDER_DATE = @DAY


	IF @order_cnt < 2
	PRINT 'lower than 2'
ELSE IF @order_cnt BETWEEN 2 AND 5
	SELECT @order_cnt
ELSE
	PRINT 'upper than 5'

END;


EXEC sp_sample_order '2023-02-20'


---------------------


---WHILE

--limit

--yapýlan iþlem

--döngüyü saðlayacak komut


DECLARE @COUNTER INT = 1

WHILE @COUNTER < 11
	BEGIN
		SELECT @COUNTER

		SET @COUNTER +=1
	END;



SELECT *
FROM ORDER_TBL


-------

DECLARE @ID INT = 11

WHILE @ID < 21
	BEGIN
		INSERT ORDER_TBL VALUES (@ID, @ID, NULL, NULL, NULL)

		SET @ID += 1
	END;


--------FUNCTIONS


--Scalar Valued Functions


----clarusway kelimesinin ilk harfi büyük diðerlerini küçük olarak gösteren bir fonksiyon yazýnýz.


select  UPPER (LEFT ('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))


CREATE FUNCTION sp_firstcharup()
RETURNS CHAR(9)
AS
BEGIN
		RETURN UPPER (LEFT ('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))
END;


SELECT dbo.sp_firstcharup()



----istediðim kelimenin ilk harfini büyük, diðerlerini küçük harfe dönüþtüren bir fonksiyon yazýnýz.



ALTER FUNCTION sp_firstcharup(@word VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
		RETURN UPPER (LEFT (@word, 1)) + LOWER(SUBSTRING(@word, 2, LEN(@word)))
END;


SELECT dbo.sp_firstcharup('welcome')


------------------


CREATE FUNCTION sp_init(@word VARCHAR(25))
RETURNS VARCHAR(25)
AS
BEGIN
		RETURN UPPER (LEFT (@word, 1)) + LOWER(SUBSTRING(@word, 2, LEN(@word)))
END;

select dbo.sp_init ('neverbethesameagain')

DROP FUNCTION dbo.sp_init 

CREATE FUNCTION sp_k(@word CHAR(9))
RETURNS CHAR (9)
AS
BEGIN
	return upper(left(@word,1))+lower(substring(@word,2,len(@word)))
END;


select dbo.sp_k('welcome')


DROP FUNCTION dbo.sp_k 



------------------



---Table Valued Functions


CREATE FUNCTION	fn_order_tbl1()
RETURNS TABLE
AS
	RETURN SELECT * FROM ORDER_TBL

;


SELECT * 
FROM	fn_order_tbl1()





ALTER FUNCTION	fn_order_tbl1(@DAY DATE)
RETURNS TABLE
AS
	RETURN SELECT * FROM ORDER_TBL WHERE ORDER_DATE = @DAY;




SELECT * 
FROM	fn_order_tbl1('2023-02-20')





-------------

DECLARE @table1 TABLE (ID INT , NAME VARCHAR(20))

	INSERT @table1 VALUES (1, 'Adam')

	
	SELECT *
	FROM @table1



---istenilen order_id zamanýnda teslim edilmiþ ise id numarasýný 'ON TIME' etiketiyle tablo þeklinde gösteren bir fonksiyon.



CREATE FUNCTION fn_tableval1(@order INT)

RETURNS @table TABLE (order_id INT, del_type CHAR(7))
AS
BEGIN
	INSERT	@table
	SELECT	A.ORDER_ID, 'ON TIME' del_type
	FROM	ORDER_TBL A, ORDER_DELIVERY B
	WHERE	A.EST_DELIVERY_DATE = B.DELIVERY_DATE
	AND		A.ORDER_ID = B.ORDER_ID
	AND		A.ORDER_ID = @order

	RETURN 
END;


SELECT *
FROM fn_tableval1(3)



















