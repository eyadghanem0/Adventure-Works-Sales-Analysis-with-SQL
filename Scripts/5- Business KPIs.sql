-- ===========================================================================================================================
-- Business KPIs
-- OBJECTIVES:
-- 1- Presenting KPIs of the business to assess performance
-- 2- Presenting measures and calculations from the facts table
-- 3- Combining sales data with products, customers and regions
-- APPROACH:
-- 1- Presenting KPIs in appropriate formats(percentage, integer ....)
-- 2- Model name was chosen instead of product name in the top 10 products query because color and size can lead the same 
--    product to appear more than once 
-- KEY FINDINGS:
-- 1- The success of the business was concluded from its KPIs
-- 2- Certain products are clearly dominant in terms of profit
-- ===========================================================================================================================
USE advworks;
GO
SELECT COUNT(OrderNumber) AS TotalOrders ,SUM(OrderQuantity) AS QuantitySold, TRY_CAST((SUM(OrderQuantity * ProductPrice)) AS INT) 
AS TotalSales, TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost)) AS INT) AS TotalProfit,
TRY_CAST(TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost) / 
SUM(OrderQuantity * ProductPrice) * 100) AS DECIMAL(10,2)) AS VARCHAR(10)) + '%' AS ProfitMargin FROM gold.Sales s
LEFT JOIN gold.Products p ON p.ProductKey = s.ProductKey;
SELECT Country, TRY_CAST((SUM(OrderQuantity * ProductPrice)) AS INT) AS Sales FROM gold.Sales s LEFT JOIN 
gold.Territories t ON s.TerritoryKey = t.TerritoryKey LEFT JOIN gold.Products p ON p.ProductKey = s.ProductKey 
GROUP BY Country ORDER BY Sales DESC;
SELECT CategoryName AS Category, SubCategoryName AS SubCategory,  
TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost)) AS INT) AS Profit FROM 
gold.Sales s LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u  ON
p.SubCategoryKey = u.SubCategoryKey LEFT JOIN gold.Categories c ON u.CategoryKey =c.CategoryKey GROUP BY
SubCategoryName, CategoryName ORDER BY Profit DESC; 
SELECT TRY_CAST((AVG(ProductPrice)) AS DECIMAL(10,2)) AS AvgProductPrice, 
TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost) / SUM(OrderQuantity)) AS DECIMAL(10,2))
AS AvgProfitPerUnit FROM gold.Products p LEFT JOIN gold.Sales s ON s.ProductKey = p.ProductKey;
SELECT CategoryName AS Category, TRY_CAST(TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost)
/ SUM(OrderQuantity * ProductPrice) * 100) AS DECIMAL(10,2)) AS VARCHAR(10)) + '%'  AS ProfitMargin,
TRY_CAST((AVG(ProductPrice)) AS DECIMAL(10,2)) AS AvgProductPrice, COUNT(OrderNumber) AS OrdersCount FROM
gold.Sales s LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u  ON
p.SubCategoryKey = u.SubCategoryKey LEFT JOIN gold.Categories c ON u.CategoryKey = c.CategoryKey GROUP BY CategoryName
ORDER BY ProfitMargin DESC;
SELECT TOP 10 FirstName + ' ' + LastName AS CustomerName, COUNT(OrderNumber) AS OrdersCount FROM gold.Sales s LEFT JOIN
gold.Customers c ON s.CustomerKey = c.CustomerKey GROUP BY FirstName + ' ' + LastName ORDER BY OrdersCount DESC; 
SELECT TOP 10 ModelName AS ProductName, TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost)) AS INT)
AS Profit, COUNT(OrderNumber) AS OrdersCount FROM gold.Sales s LEFT JOIN
gold.Products p  ON s.ProductKey=p.ProductKey  GROUP BY ModelName ORDER BY Profit DESC; 