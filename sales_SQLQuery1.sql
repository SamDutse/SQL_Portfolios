--To start analyzing this data set, Lets get a glimpse of what the data is all about
SELECT 
	TOP 5 *
FROM
	Sales$

--Count the number of orders per country
SELECT 
	Country,
	COUNT(*) as Order_Count
FROM 
	Sales$
GROUP BY 
	Country
ORDER BY
	Order_Count DESC;

-- Calculating the total revenue per country:
SELECT 
	Country,
	SUM(Revenue) as Total_Revenue
FROM
	Sales$
GROUP BY
	Country
ORDER BY
	Total_Revenue DESC;

-- Checking product category with most order:
SELECT 
	Product_Category,
	COUNT(*) as Total_Product_Category_Count
FROM 
	Sales$
GROUP BY 
	Product_Category
ORDER BY
	Total_Product_Category_Count DESC;

-- Calculate the total profit per country and product category, Just selecting the top 10:
SELECT 
	top 10
	Country, 
	Product_Category, 
	SUM(Profit) as Total_Profit
FROM 
	Sales$
GROUP BY 
	Country, 
	Product_Category
ORDER BY
	Total_Profit DESC;

-- Find the top selling products by order quantity:
SELECT 
	TOP 10
	Product, 
	SUM(Order_Quantity) as Total_Quantity
FROM 
	Sales$
GROUP BY 
	Product
ORDER BY 
	Total_Quantity DESC;

-- Calculate the average profit margin per order:
SELECT 
	ROUND((SUM(Profit) / COUNT(*)), 2) as Avg_Profit_Margin
FROM 
	Sales$;

-- Calculate the total revenue and profit for each sub-category:
SELECT
	TOP 10
	Sub_Category, 
	SUM(Revenue) as Total_Revenue, 
	SUM(Profit) as Total_Profit
FROM 
	Sales$
GROUP BY 
	Sub_Category
ORDER BY
	Total_Profit DESC;

-- Calculating the total quantity ordered by sub category top 10:
SELECT
	TOP 10
	Sub_Category,
	SUM(Order_Quantity) as Total_Quantity_Ordered
FROM 
	Sales$
GROUP BY 
	Sub_Category
ORDER BY
	Total_Quantity_Ordered DESC;
