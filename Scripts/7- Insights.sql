-- ===========================================================================================================================
-- Insights
-- OBJECTIVES:
-- 1- Answering specific questions and presenting suggestions to increase profit and guide decision-making
-- 2- Increasing profit and sales in smaller subcategories (which have high profit margin) by selecting top products and
--    prioritizing them for higher-volume sales
-- 3- Identifying the potential to introduce high-price product by analyzing customers' purchasing power and income in
--    comparison to their purchases of expensive products
-- 4- Identifying under-performing subcategories to redirect resources into marketing or other products/subcategories
-- 5- Calculating the average of profit and orders per customer across years and comparing them with CAC numbers from
--    marketing to evaluate marketing strategy and balance customer acquisition and retention efforts 
-- Questions:
-- 1- In smaller categories, which subcategories have high profit margin and large quantity sold? 
-- 2- Which products from these subcategories are the most suitable to be prioritized?
-- 3- Do expensive products perform well in sales and is there a relationship with customers' income?
-- 4- What are the 5 least profitable subcategories?
-- 5- What are the avg orders and profit per customer from 2020-2022?
-- KEY FINDINGS:
-- 1- "Tires and Tubes", "Bottles and Cages" and "Gloves" were chosen based on the previous criteria. These subcategories
--    ensure high-volume sales and high profit margin. Products from these subcategories were presented
-- 2- High-priced products are performing well which creates opportunities for adding new expensive products
-- 3- As customers income increases, their purchases of expensive products also increase (relative to customers count)
--    and the reelationship is clear when the number of customers is similar (10-40 and 50-80 k$)
-- 4- Under-performing categories are "Socks", "Cleaners", "Caps", "Vests" and "Bike Racks"
-- 5- Growth depends mainly on acquisition which makes marketing and attracting new customers consistently a priority
-- ===========================================================================================================================
USE advworks;
GO
SELECT CategoryName AS Category, SubCategoryName AS SubCategory, u.SubCategoryKey, SUM(OrderQuantity) AS QuantitySold, 
TRY_CAST(TRY_CAST((SUM( ProductPrice - ProductCost)/ SUM(ProductPrice) * 100) AS DECIMAL(10,2)) AS VARCHAR(10)) + '%'
AS ProfitMargin FROM gold.Sales s LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u ON
u.SubcategoryKey = p.SubCategoryKey LEFT JOIN gold.Categories c ON c.CategoryKey = u.CategoryKey WHERE u.CategoryKey = 3 OR 
u.CategoryKey = 4 GROUP BY SubcategoryName, u.SubCategoryKey, CategoryName ORDER BY Category, QuantitySold DESC;
SELECT ProductName, SubCategoryName AS SubCategory, SUM(OrderQuantity) AS QuantitySold, 
TRY_CAST(TRY_CAST((SUM(ProductPrice - ProductCost)/ SUM(ProductPrice) * 100) AS DECIMAL(10,2)) AS VARCHAR(10)) + '%'
AS ProfitMargin FROM gold.Sales s LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u 
ON u.SubcategoryKey = p.SubCategoryKey WHERE u.SubCategoryKey = 37 OR u.SubCategoryKey = 28 OR u.SubCategoryKey = 20
GROUP BY  ProductName, SubCategoryName ORDER BY SubCategory, QuantitySold DESC;
WITH ModelsByIncomeGroup AS (SELECT CASE WHEN AnnualIncome BETWEEN 10000 AND 40000 THEN '10-40K$' WHEN AnnualIncome BETWEEN 
50000 AND 80000 THEN'50-80K$' WHEN AnnualIncome BETWEEN 90000 AND 120000 THEN '90-120K$' WHEN AnnualIncome BETWEEN 130000 AND
170000 THEN '130-170K$' END AS AnnualIncomeGroup, ModelName AS Model, COUNT(OrderNumber) AS OrdersCount, 
TRY_CAST(AVG(ProductPrice) AS INT) AS Price FROM gold.Sales s  LEFT JOIN gold.Customers c ON c.CustomerKey = s.CustomerKey 
LEFT JOIN gold.Products p ON p.ProductKey = s.ProductKey LEFT JOIN gold.Subcategories u ON u.SubcategoryKey = p.SubCategoryKey
WHERE CategoryKey = 1 GROUP BY CASE WHEN AnnualIncome BETWEEN 10000 AND 40000 THEN '10-40K$' WHEN AnnualIncome BETWEEN 50000
AND 80000THEN '50-80K$' WHEN AnnualIncome BETWEEN 90000 AND 120000 THEN '90-120K$' WHEN AnnualIncome BETWEEN 130000 AND 170000
THEN '130-170K$' END, ModelName) SELECT AnnualIncomeGroup, Model, Price, OrdersCount FROM (SELECT AnnualIncomeGroup,
Model, Price, OrdersCount, ROW_NUMBER() OVER(PARTITION BY AnnualIncomeGroup ORDER BY Price DESC) AS Rank FROM
ModelsByIncomeGroup) ranked WHERE RANK <=5 ORDER BY Price DESC, AnnualIncomeGroup;
SELECT TOP 5 CategoryName AS Category, SubCategoryName AS SubCategory, SUM(OrderQuantity) AS QuantitySold, 
TRY_CAST(SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost) AS DECIMAL(10,2)) AS TotalProfit FROM gold.Sales s
LEFT JOIN gold.Products p ON s.ProductKey = p.ProductKey LEFT JOIN gold.Subcategories u ON u.SubcategoryKey = p.SubCategoryKey
LEFT JOIN gold.Categories c ON c.CategoryKey = u.CategoryKey GROUP BY SubcategoryName, CategoryName ORDER BY TotalProfit;
SELECT TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) AS Year, COUNT(DISTINCT CustomerKey) AS TotalCustomers,
TRY_CAST((SUM(OrderQuantity * ProductPrice - OrderQuantity * ProductCost) / COUNT(DISTINCT CustomerKey)) AS DECIMAL(10,2)) 
AS ProfitPerCustomer, TRY_CAST((COUNT(OrderNumber) * 1.0 / COUNT(DISTINCT CustomerKey)) AS DECIMAL(10,2)) AS
AvgOrdersPerCustomer FROM gold.Sales s LEFT JOIN gold.Products p ON p.ProductKey = s.ProductKey GROUP BY
TRY_CAST(YEAR(OrderDate) AS VARCHAR(5)) ORDER BY Year;

