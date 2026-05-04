--KPI's requirments

SELECT * FROM pizza_sales

--1.Total revenue 
SELECT SUM(total_price) as Total_Revenue FROM pizza_sales;


--2.Average order value

SELECT * FROM pizza_sales

SELECT SUM(total_price)/ COUNT(DISTINCT order_id) as Avg_Order_Value from pizza_sales

--3.Total pizza sold
SELECT SUM(quantity) as Total_pizza_sold FROM pizza_sales

--4.Total orders

SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales

--5.Average pizzza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order from pizza_sales

--CHARTS REQUIRMENTS(Daily trends for total order)
SELECT * FROM pizza_sales

SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders 
from pizza_sales
GROUP BY DATENAME(DW, order_date)

--Monthly trends for total order

select * from pizza_sales

SELECT DATENAME(MONTH,order_date) AS Month_Name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Orders DESC

--3.percentage of sales by pizza category

SELECT * FROM pizza_sales

SELECT pizza_category,sum(total_price) as Total_Sales,sum(total_price) *100/
(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--4.percentage of sales by pizza size
select * from pizza_sales
SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) as Total_Sales,CAST(sum(total_price) *100/
(SELECT sum(total_price) from pizza_sales WHERE DATEPART(quarter,order_date)=1) AS DECIMAL (10,2)) AS PCT 
from pizza_sales
WHERE DATEPART(quarter,order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC

--6.top 5 best seller by revenue ,total quantity abd total orders

SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--7.top 5 best seller

SELECT TOP 5 pizza_name,SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--8.Bottom 5 best seller

SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC

