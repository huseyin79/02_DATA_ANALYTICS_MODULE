
---1. solution
CREATE VIEW view3 AS
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		ROW_NUMBER() OVER (PARTITION BY A.staff_id ORDER BY order_id) ROW_NUM
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id;

SELECT E.staff_id, DATEDIFF(DAY, E.order_date, F.order_date)
FROM(SELECT C.staff_id, C.order_date, C.order_id, C.ROW_NUM
FROM	view3 C
WHERE	ROW_NUM = 3) E,
(SELECT D.staff_id, D.order_date, D.order_id, D.ROW_NUM
FROM	view3 D
WHERE	D.ROW_NUM = 4) F
WHERE E.staff_id = F.staff_id


--2. solution
create view X as
SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		--LAG(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_ord_date,
		ROW_NUMBER() OVER (PARTITION BY A.staff_id ORDER BY order_id) ROW_NUM
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id;

create view Y as
select X.staff_id,X.order_date order_date_4
from X
where ROW_NUM=4

create view Z as
select X.staff_id,X.order_date order_date_3
from X
where ROW_NUM=3

select A.staff_id,order_date_4,order_date_3, DATEDIFF(DAY,order_date_3, order_date_4) DAY_DIF
from y A, z B
where A.staff_id=B.staff_id