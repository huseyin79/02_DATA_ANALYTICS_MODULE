

SELECT	TOP 15 *
FROM e_commerce

---A) ANALYZE THE DATA BY FINDING THE ANSWERS TO THE QUESTIONS BELOW:

-- 1. Find the top 3 customers who have the maximum count of orders.

SELECT DISTINCT A.Cust_ID, B.Customer_Name, A.Count_Order
FROM
(SELECT TOP 3 Cust_ID, COUNT(Ord_ID) Count_Order
FROM e_commerce
GROUP BY Cust_ID
ORDER BY Count_Order DESC) A
INNER JOIN e_commerce B
ON A.Cust_ID=B.Cust_ID


-- 2. Find the customer whose order took the maximum time to get shipping.

SELECT TOP 1 Ord_ID, Customer_Name, Order_Date, Ship_Date, DATEDIFF(DAY, Order_Date, Ship_Date) AS Order_Days
FROM e_commerce
ORDER BY Order_Days DESC

-- 3. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011

--A
SELECT COUNT(DISTINCT Cust_ID)
FROM e_commerce
WHERE Order_Date LIKE '%2011-01-%'

--February
SELECT COUNT(DISTINCT Cust_ID) AS Reten_February
FROM e_commerce
WHERE Order_Date LIKE '%2011-02-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

--March
SELECT COUNT(DISTINCT Cust_ID) AS Ret_March
FROM e_commerce
WHERE Order_Date LIKE '%2011-03-%' AND Cust_ID IN (
													SELECT DISTINCT Cust_ID
													FROM e_commerce
													WHERE Order_Date LIKE '%2011-01-%')

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


-- 4. Write a query to return for each user the time elapsed between the first purchasing and the third purchasing, in ascending order by Customer ID.


-- 5. Write a query that returns customers who purchased both product 11 and product 14, as well as the ratio of these products to the total number of products purchased by the customer.