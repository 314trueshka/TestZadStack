USE [stack]
GO
/****** Object:  UserDefinedFunction [dbo].[gunction]    Script Date: 03.04.2021 15:25:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[gunction] 
(
	-- Add the parameters for the function here
	@poi int
)
RETURNS int
AS
BEGIN
	DECLARE @count int
	DECLARE @asum int
	DECLARE @id int
	DECLARE @parent int
	DECLARE @sum int
	SELECT @count= COUNT(Ordering.row_id) FROM (Select Orders.row_id, Orders.parent_id, SUM(OrderItems.price) as Price
	FROM Orders LEFT JOIN  OrderItems ON Orders.row_id =  OrderItems.order_id
	GROUP BY Orders.row_id,Orders.parent_id) AS Ordering
	set @id = @poi
	SELECT @sum = SUM(Ordering.parent_id) FROM (Select Orders.row_id, Orders.parent_id, SUM(OrderItems.price) as Price
	FROM Orders LEFT JOIN  OrderItems ON Orders.row_id =  OrderItems.order_id
	GROUP BY Orders.row_id,Orders.parent_id) AS Ordering WHERE Ordering.row_id = @poi
	WHILE @parent is NULL or @parent != @sum
		BEGIN
			set @id = @id+1
			IF (@id>@count)
				BREAK;
			SELECT @parent = SUM(Ordering.parent_id) FROM (Select Orders.row_id, Orders.parent_id, SUM(OrderItems.price) as Price
			FROM Orders LEFT JOIN  OrderItems ON Orders.row_id =  OrderItems.order_id
			GROUP BY Orders.row_id,Orders.parent_id) AS Ordering WHERE Ordering.row_id = @id
		END
	SELECT @asum = SUM(Ordering.Price) FROM (Select Orders.row_id, Orders.parent_id, SUM(OrderItems.price) as Price
	FROM Orders LEFT JOIN  OrderItems ON Orders.row_id =  OrderItems.order_id
	GROUP BY Orders.row_id,Orders.parent_id) AS Ordering WHERE row_id BETWEEN @poi AND @id-1
	IF (@poi = 1)
		SELECT @asum = SUM(Ordering.Price) FROM (Select Orders.row_id, Orders.parent_id, SUM(OrderItems.price) as Price
		FROM Orders LEFT JOIN  OrderItems ON Orders.row_id =  OrderItems.order_id
		GROUP BY Orders.row_id,Orders.parent_id) AS Ordering
		RETURN @asum;
	RETURN @asum
END
