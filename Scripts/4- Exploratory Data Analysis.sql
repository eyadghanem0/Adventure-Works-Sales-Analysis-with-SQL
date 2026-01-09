-- ===========================================================================================================================
-- Exploratory Data Analysis
-- OBJECTIVES:
-- 1- Presenting customers data to understand the targeted audience
-- 2- Further comprehension of the data before KPIs and insights analysis
-- 3- Results can support the marketing department to enhance performance and decisions
-- APPROACH:
-- 1- Grouping values to ensure the simplicity and the readability of the outcomes
-- 2- Using customers count to determine their distribution
-- ===========================================================================================================================
USE advworks;
GO
WITH AgeCalculation AS (SELECT CustomerKey, DATEDIFF(YEAR, BirthDate, (SELECT MIN(OrderDate) FROM gold.Sales s WHERE
s.CustomerKey = c.CustomerKey)) AS Age FROM  gold.Customers c WHERE c.BirthDate IS NOT NULL) 
SELECT CASE WHEN Age BETWEEN 40 AND  49 THEN '40s' WHEN Age BETWEEN 50 AND 59 THEN '50s' WHEN Age BETWEEN 60 AND 69 THEN
'60s' WHEN Age BETWEEN 70 AND 79 THEN '70s' ELSE '+80' END AS AgeGroup, COUNT(DISTINCT CustomerKey) AS CustomersCount FROM
AgeCalculation GROUP BY CASE WHEN Age BETWEEN 40 AND  49 THEN '40s' WHEN Age BETWEEN 50 AND 59 THEN '50s' WHEN Age
BETWEEN 60 AND 69 THEN '60s' WHEN Age BETWEEN 70 AND 79 THEN '70s' ELSE '+80' END ORDER BY AgeGroup;
SELECT CASE WHEN AnnualIncome BETWEEN 10000 AND 40000 THEN '10-40K$' WHEN AnnualIncome BETWEEN 50000 AND 80000 THEN
'50-80K$' WHEN AnnualIncome BETWEEN 90000 AND 120000 THEN '90-120K$' WHEN AnnualIncome BETWEEN 130000 AND 170000 THEN 
'130-170K$' END AS AnnualIncomeGroup, COUNT(DISTINCT CustomerKey) AS CustomersCount FROM gold.Customers GROUP BY
CASE WHEN AnnualIncome BETWEEN 10000 AND 40000 THEN '10-40K$' WHEN AnnualIncome BETWEEN 50000 AND 80000 THEN
'50-80K$' WHEN AnnualIncome BETWEEN 90000 AND 120000 THEN '90-120K$' WHEN AnnualIncome BETWEEN 130000 AND 170000 THEN 
'130-170K$' END ORDER BY CustomersCount DESC;
SELECT EducationLevel, Occupation, COUNT(DISTINCT CustomerKey) AS CustomersCount FROM gold.Customers GROUP BY 
EducationLevel, Occupation ORDER BY EducationLevel;
SELECT Country,COUNT(DISTINCT CustomerKey) AS CustomersCount  FROM gold.Sales s LEFT JOIN 
gold.Territories t ON s.TerritoryKey = t.TerritoryKey GROUP BY Country ORDER BY Country;