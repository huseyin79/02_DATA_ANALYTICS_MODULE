

SELECT *
FROM sale.order_item
ORDER BY product_id

SELECT product_id, discount, quantity
FROM sale.order_item
ORDER BY product_id, discount

CREATE VIEW assign3 AS
SELECT product_id, discount, SUM(quantity) sum_quantity
FROM sale.order_item
GROUP BY product_id, discount;

SELECT *
FROM assign3
ORDER BY product_id

CREATE VIEW assign3_1 AS
SELECT product_id, discount, sum_quantity,
LEAD (sum_quantity) OVER (PARTITION BY product_id ORDER BY product_id) next_sum_quantity 
FROM assign3;

SELECT *
FROM assign3_1
ORDER BY product_id

CREATE VIEW assign3_2 AS
SELECT *, (next_sum_quantity - sum_quantity) diff_quant_by_disc
FROM assign3_1
WHERE next_sum_quantity IS NOT NULL;

SELECT *
FROM assign3_2
ORDER BY product_id

SELECT SUM(diff_quant_by_disc) 
FROM assign3_2

--Result of the last query is -44, so a negative number. Therefore, we cannot conclude that higher discount rates led to higher number of orders.

SELECT COUNT(DISTINCT product_id)
FROM sale.order_item

--Total number of (unique) ordered products is 307. Considering that, even if the result of the previous query were +44, still we could not conclude that discount rates have a significant impact on the number of orders.
--If we want to see the affect of the discount rates on each product, here is the query:


SELECT product_id, SUM(diff_quant_by_disc) diff_by_prod, 
CASE  WHEN SUM(diff_quant_by_disc) > 0 THEN 'Positive'
 WHEN SUM(diff_quant_by_disc) < 0 THEN 'Negative'
 ELSE 'Neutral'
 END [Discount Effect]
FROM assign3_2
GROUP BY product_id
ORDER BY product_id