-- ===========================================================================================================================
-- Time Based Analysis
-- OBJECTIVES:
-- 1- Tracking sales growth across years
-- 2- Identifying trends in products, categories or regions
-- APPROACH:
-- 1- Presenting KPIs in appropriate formats(percentage, integer ....)
-- 2- Model name was chosen instead of product name in the top 10 products query because color and size can lead the same 
--    product to appear more than once 
-- KEY FINDINGS:
-- 1- The business is growing significantly as sales in only half of 2022 are larger than 2020 and almost equal to 2021
-- 2- Only bikes were sold in 2020
-- 3- Their is a change in products performance across the three years,EX: Road-150 was the most profitable product in 
--    2020, then in 2021 and 2022 it was not present in the top 10 and Mountain-200 outperformed all products in 2021-2022
-- ===========================================================================================================================
USE advworks;
GO
SELECT TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) AS Year, DATENAME(MONTH, OrderDate) AS Month, MONTH(OrderDate)
AS MonthNumber, TRY_CAST(SUM(OrderQuantity * ProductPrice) AS INT) AS Sales FROM gold.Sales s LEFT JOIN 
gold.Products p ON p.ProductKey = s.ProductKey GROUP BY TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)), 
DATENAME(MONTH, OrderDate), MONTH(OrderDate)  ORDER BY Year, MonthNumber;
SELECT TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) AS Year, (SUM(OrderQuantity * ProductPrice)
- LAG(SUM(OrderQuantity * ProductPrice)) OVER(ORDER BY TRY_CAST(YEAR(OrderDate) AS VARCHAR(5))))
/ (LAG(SUM(OrderQuantity * ProductPrice)) OVER(ORDER BY TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)))) AS YoYChange
FROM gold.Sales s LEFT JOIN gold.Products p ON p.ProductKey =s.ProductKey GROUP BY TRY_CAST(YEAR(OrderDate) AS
VARCHAR(5));
SELECT CategoryName AS Category, TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) AS Year,
TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost)) AS INT) AS Profit FROM 
gold.Sales s LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u  ON
p.SubCategoryKey = u.SubCategoryKey LEFT JOIN gold.Categories c ON u.CategoryKey =c.CategoryKey GROUP BY
CategoryName, TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) ORDER BY Category, Year; 
WITH ProductsSalesByYear AS (SELECT ModelName, TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) AS Year,
SUM(OrderQuantity * ProductPrice) AS Sales FROM gold.Sales s LEFT JOIN gold.Products p ON p.ProductKey = s.ProductKey 
GROUP BY ModelName, TRY_CAST(YEAR(OrderDate) AS VARCHAR(5))) SELECT Year, ModelName AS ProductName, Sales FROM (SELECT Year, 
ModelName, Sales, ROW_NUMBER() OVER(PARTITION BY Year ORDER BY Sales DESC) AS Rank FROM ProductsSalesByYear) ranked
WHERE Rank <= 10;