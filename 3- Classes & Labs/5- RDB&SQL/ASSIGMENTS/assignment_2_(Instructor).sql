




-------------question 1 (Conversion Rate)






SELECT * 
FROM (
		VALUES 
				(1,'A', 'Left')
	) AS table_1 (Visitor_ID, Adv_Type, Actions)




SELECT	*
FROM (
		VALUES 
				(1,'A', 'Left'),
				(2,'A', 'Order'),
				(3,'B', 'Left'),
				(4,'A', 'Order'),
				(5,'A', 'Review'),
				(6,'A', 'Left'),
				(7,'B', 'Left'),
				(8,'B', 'Order'),
				(9,'B', 'Review'),
				(10,'A', 'Review')
		) as table_1 (Visitor_ID, Adv_Type, Actions)






SELECT	Adv_Type, 
		COUNT(*) cnt_action, 
		SUM(CASE WHEN Actions = 'Order' THEN 1 ELSE 0 END) AS cnt_order
FROM (
		VALUES 
				(1,'A', 'Left'),
				(2,'A', 'Order'),
				(3,'B', 'Left'),
				(4,'A', 'Order'),
				(5,'A', 'Review'),
				(6,'A', 'Left'),
				(7,'B', 'Left'),
				(8,'B', 'Order'),
				(9,'B', 'Review'),
				(10,'A', 'Review')
		) as table_1 (Visitor_ID, Adv_Type, Actions)
GROUP BY Adv_Type






--Result

WITH Actions As
(
SELECT	Adv_Type, 
		COUNT(*) cnt_action, 
		SUM(CASE WHEN Actions = 'Order' THEN 1 ELSE 0 END) AS cnt_order
FROM (
		VALUES 
				(1,'A', 'Left'),
				(2,'A', 'Order'),
				(3,'B', 'Left'),
				(4,'A', 'Order'),
				(5,'A', 'Review'),
				(6,'A', 'Left'),
				(7,'B', 'Left'),
				(8,'B', 'Order'),
				(9,'B', 'Review'),
				(10,'A', 'Review')
		) as table_1 (Visitor_ID, Adv_Type, Actions)
GROUP BY Adv_Type
)
SELECT	Adv_Type, 
		convert(numeric(5,2), 1.0* cnt_order/cnt_action) AS Conversion_Rate
FROM	Actions





