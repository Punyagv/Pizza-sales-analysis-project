 SELECT * FROM pizza_sales;

--Total_Revenue
SELECT SUM(total_price)AS Total_Revenue FROM pizza_sales
--Average_order_Value
SELECT  SUM(total_price)/COUNT(distinct order_id) AS Average_Order_Values FROM pizza_sales
--Total_Pizza_Sold
SELECT SUM(quantity)AS total_pizza_sold FROM pizza_sales
--Total_orders_placed
SELECT COUNT (distinct order_id)AS total_orders FROM pizza_sales
--Average _pizza_sold_per_order
SELECT CAST(CAST(SUM(quantity)AS DECIMAL(10,2))/
CAST(COUNT(distinct  order_id)AS DECIMAL(10,2))AS DECIMAL(10,2))AS average_pizza_per_order FROM pizza_sales

--Daily_trend_for_total_orders
SELECT DATENAME(dw, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(dw, order_date)
--Monthly_trend_for_total_orders
SELECT DATENAME (MONTH, order_date)AS Month_name,COUNT (DISTINCT order_id)AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY  Total_orders DESC
--Percentage_of_sales_by_pizza_category
SELECT pizza_category,SUM(total_price)AS Total_sales, SUM (total_price) *100/
(SELECT SUM (total_price) FROM pizza_sales WHERE MONTH (order_date) = 1) AS Total_percentage_sales
FROM pizza_sales
WHERE MONTH (order_date) = 1
GROUP BY pizza_category
--percentage of sales by pizza size
SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,CAST(SUM(total_price) *100/
(SELECT SUM (total_price) FROM pizza_sales WHERE DATEPART (QUARTER, order_date)=1)AS DECIMAL(10,2))AS Total_percentage_sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date)=1
GROUP BY pizza_size
ORDER BY Total_percentage_sales DESC

--Top 5 best sellers by revenue
SELECT TOP 5 pizza_name, SUM (total_price) AS Total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC

--bottom 5 pizza sellers by revenue
SELECT TOP 5 pizza_name,sum(total_price) AS Total_revenue FROM pizza_sales
GROUP BY  pizza_name
ORDER BY Total_revenue ASC
--top 5 pizza sellers by total quantity
SELECT TOP 5 pizza_name,SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC
--bottom 5 pizza sellers by total quantity
SELECT TOP 5 pizza_name,SUM (quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity ASC
--top 5 pizza sellers by total orders
SELECT TOP 5 pizza_name,COUNT  (DISTINCT  order_id) Total_orders FROM  pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC

--bottom 5 pizza sellers by total quantity
SELECT TOP 5 pizza_name,COUNT (DISTINCT order_id) Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders 
