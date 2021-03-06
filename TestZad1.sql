ALTER FUNCTION stack.select_orders_by_item_name (@countitmes nvarchar(255))
RETURNS TABLE 
AS
RETURN 
(
	SELECT Orders.row_id,Customers.name,COUNT(Orders.row_id) AS "items_count" 
	FROM stack.Orders,stack.Customers,stack.OrderItems WHERE stack.customers.row_id = stack.Orders.customer_id AND stack.OrderItems.name = @countitmes AND
	stack.Orders.row_id = stack.OrderItems.order_id
	GROUP BY Orders.row_id, Customers.name

);