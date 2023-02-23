
SELECT *
FROM string_split('HUSE, tAYY, ZAF', ',')

SELECT ISNUMERIC('veli')

SELECT LEFT(email, PATINDEX('%@%', email)-1) 
FROM sale.customer

SELECT LEFT(EMAIL, CHARINDEX('@', email)-1)
FROM sale.customer

SELECT *, COALESCE(phone, email) contact 
FROM sale.customer

SELECT *, ISNULL(phone, email) contact 
FROM sale.customer

SELECT *, ISNULL(phone, email) contact_new
FROM sale.customer


SELECT DISTINCT product.product.product_id, sale.order_item.product_id
FROM product.product 
LEFT JOIN sale.order_item
ON product.product.product_id = sale.order_item.product_id 
WHERE sale.order_item.product_id IS NULL

SELECT COUNT(DISTINCT product.product.product_id)
FROM product.product 
LEFT JOIN sale.order_item
ON product.product.product_id = sale.order_item.product_id 
WHERE sale.order_item.product_id IS NULL


SELECT S.staff_id, SUM(B.quantity)
FROM sale.staff AS S
LEFT JOIN
sale.orders AS A
ON S.staff_id = A.staff_id
LEFT JOIN sale.order_item AS B
ON A.order_id = B.order_id
GROUP BY S.staff_id 
ORDER BY S.staff_id 

