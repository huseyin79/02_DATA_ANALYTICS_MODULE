

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

--istedi�imiz tarihe ait sipari� say�s�n� nas�l getirebiliriz?


ALTER PROC sp_order_product_cnt (@day DATE) AS
BEGIN
		SELECT	COUNT(DISTINCT ORDER_ID) cnt_order
		FROM	order_tbl
		WHERE	ORDER_DATE = @day
END;


EXEC sp_order_product_cnt '2023-02-20'



----�stenilen m��terinin istenilen tarihteki sipari�lerini d�nd�ren bir prosed�r yaz�n.




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

---iki de�i�ken tan�mlay�n, 
--e�er biri di�erine e�itse iki de�eri �arp�n
--e�er de�i�ken1 de�i�ken2 ' den k���kse iki de�i�keni toplay�n
--de�i�ken2 de�i�ken1 ' den k���kse de�i�ken1' den de�i�ken2' yi ��kar�n.


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


---�stenilen tarihte verilen sipari� say�s� 2 ten k���kse 'lower than 2',
-- 2 ile 5 aras�ndaysa sipari� say�s�, 5' den b�y�kse 'upper than 5' yazd�ran bir sorgu yaz�n�z.


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

--yap�lan i�lem

--d�ng�y� sa�layacak komut


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


----clarusway kelimesinin ilk harfi b�y�k di�erlerini k���k olarak g�steren bir fonksiyon yaz�n�z.


select  UPPER (LEFT ('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))


CREATE FUNCTION sp_firstcharup()
RETURNS CHAR(9)
AS
BEGIN
		RETURN UPPER (LEFT ('clarusway', 1)) + LOWER(SUBSTRING('clarusway', 2, LEN('clarusway')))
END;


SELECT dbo.sp_firstcharup()



----istedi�im kelimenin ilk harfini b�y�k, di�erlerini k���k harfe d�n��t�ren bir fonksiyon yaz�n�z.



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



---istenilen order_id zaman�nda teslim edilmi� ise id numaras�n� 'ON TIME' etiketiyle tablo �eklinde g�steren bir fonksiyon.



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



















