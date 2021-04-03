

SELECT OrderItems.order_id INTO Items FROM dbo.OrderItems WHERE dbo.OrderItems.name != 'Кассовый аппарат'
EXCEPT
SELECT OrderItems.order_id FROM dbo.OrderItems WHERE dbo.OrderItems.name = 'Кассовый аппарат'

SELECT DISTINCT Orders.customer_id INTO Names FROM Orders WHERE Orders.customer_id IS NOT NULL
EXCEPT
SELECT  Orders.customer_id  FROM Orders JOIN Items ON Orders.row_id = Items.order_id
WHERE dbo.Orders.registered_at>'2019-12-31'
DROP TABLE Items

SELECT Customers.name FROM Customers JOIN Names ON Customers.row_id = Names.customer_id
DROP TABLE Names
