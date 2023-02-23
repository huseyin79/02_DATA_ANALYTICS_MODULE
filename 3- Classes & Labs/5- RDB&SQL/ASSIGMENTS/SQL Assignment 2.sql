CREATE DATABASE E_CommerceDB
GO

USE E_CommerceDB
GO

CREATE TABLE [Actions](
	[Visitor_ID] INT IDENTITY(1,1) PRIMARY KEY  NOT NULL,
	[Adv_Type] [VARCHAR](1) NOT NULL,
	[Action] [NVARCHAR](10) NOT NULL);

SELECT *
FROM Actions

SELECT * FROM Actions
INSERT INTO Actions ([Adv_Type], [Action])
	VALUES ('A', 'Left'),
			('A', 'Order'),
			('B', 'Left'),
			('A', 'Order'),
			('A', 'Review'),
			('A', 'Left'),
			('B', 'Left'),
			('B', 'Order'),
			('B', 'Review'),
			('A', 'Review')

CREATE VIEW action_view AS
SELECT Adv_Type, COUNT(Visitor_ID) AS Action_Cnt
FROM Actions 
GROUP BY (Adv_Type)

CREATE VIEW order_view1 AS
SELECT Adv_Type, COUNT([Action]) AS Order_Cnt
FROM Actions 
WHERE [Action]='Order'
GROUP BY (Adv_Type)

SELECT action_view.Adv_Type, CAST((1.0*Order_Cnt / Action_Cnt) AS decimal(10,2)) AS Conversion_Rate 
FROM action_view, order_view1
WHERE action_view.Adv_Type = order_view1.Adv_Type

