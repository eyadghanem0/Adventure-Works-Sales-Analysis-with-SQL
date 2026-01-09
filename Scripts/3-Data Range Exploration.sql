-- ===========================================================================================================================
-- Data Range Exploration
-- OBJECTIVES:
-- 1- Exploring the range of dates, prices and regions
-- 2- Overview of categories, dates and customers before performing EDA(Exploratory Data Analysis)
-- APPROACH:
-- 1- Calculating the minimum and the maximum values of certain columns
-- 2- Presenting the countries where the business operates 
-- ===========================================================================================================================
USE advworks;
GO
SELECT MIN(OrderDate) AS FirstOrder, MAX(OrderDate) AS LastOrder FROM gold.Sales;
SELECT MIN(StockDate) AS FirstStockDate, MAX(StockDate) AS LastStockDate FROM gold.Sales;
SELECT SubCategoryName AS SubCategory, CategoryName AS Category FROM gold.SubCategories u LEFT JOIN 
gold.Categories c ON u.CategoryKey = c.CategoryKey GROUP BY SubCategoryName,CategoryName ORDER BY Category;
SELECT  Country,Region, Continent FROM gold.Territories ORDER BY Country;
SELECT DATEDIFF(YEAR, MIN(BirthDate), GETDATE()) AS OldestCustomer, DATEDIFF(YEAR, MAX(BirthDate), GETDATE())
AS YoungestCustomer FROM gold.Customers;
SELECT MIN(ProductPrice) AS MinimumProductPrice, MAX(ProductPrice) AS MaximumProductPrice FROM gold.Products;
SELECT MIN(AnnualIncome) AS LowestAnnualIncome, MAX(AnnualIncome) AS HighestAnnualIncome  FROM gold.Customers;