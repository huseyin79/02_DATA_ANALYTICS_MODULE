

--February
CREATE VIEW February AS
(SELECT '2011-01' AS Ref_Month, COUNT(DISTINCT Cust_ID) AS Reten_February
FROM e_commerce
WHERE Order_Date LIKE '%2011-02-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%'))

SELECT *
From February
 

CREATE VIEW March AS
(SELECT '2011-01' AS Ref_Month, COUNT(DISTINCT Cust_ID) AS Ret_March
FROM e_commerce
WHERE Order_Date LIKE '%2011-03-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%'))


SELECT *
From February

Select February.Reten_February, March.*
from February, March
WHERE February.Ref_Month = MaRCH.Ref_Month

--April
SELECT COUNT(DISTINCT Cust_ID) AS Ret_April
FROM e_commerce
WHERE Order_Date LIKE '%2011-04-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--May
SELECT COUNT(DISTINCT Cust_ID) AS Ret_May
FROM e_commerce
WHERE Order_Date LIKE '%2011-05-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')


--June
SELECT COUNT(DISTINCT Cust_ID) AS Ret_June
FROM e_commerce
WHERE Order_Date LIKE '%2011-06-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--July
SELECT COUNT(DISTINCT Cust_ID) AS Ret_July
FROM e_commerce
WHERE Order_Date LIKE '%2011-07-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--August
SELECT COUNT(DISTINCT Cust_ID) AS Ret_August
FROM e_commerce
WHERE Order_Date LIKE '%2011-08-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--September
SELECT COUNT(DISTINCT Cust_ID) AS Ret_Sept
FROM e_commerce
WHERE Order_Date LIKE '%2011-09-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--October
SELECT COUNT(DISTINCT Cust_ID) AS Ret_Oct
FROM e_commerce
WHERE Order_Date LIKE '%2011-10-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--November
SELECT COUNT(DISTINCT Cust_ID) AS Ret_Nov
FROM e_commerce
WHERE Order_Date LIKE '%2011-11-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--December
SELECT COUNT(DISTINCT Cust_ID) AS Ret_Dec
FROM e_commerce
WHERE Order_Date LIKE '%2011-12-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')