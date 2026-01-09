-- ===========================================================================================================================
-- Data Preparation
-- OBJECTIVES:
-- 1- Converting columns to numeric(Integer or Decimal) as suitable
-- 2- Replacing NA with NULL (missing values coorect format)
-- ===========================================================================================================================
USE advworks;
GO
UPDATE gold.Customers SET Gender = NULL WHERE Gender = 'NA';
ALTER TABLE gold.Customers ALTER COLUMN AnnualIncome INT;
GO
SELECT * FROM gold.Customers;
ALTER TABLE gold.Products ALTER COLUMN ProductCost DECIMAL(10,2);
ALTER TABLE gold.Products ALTER COLUMN ProductPrice DECIMAL(10,2);
GO
SELECT * FROM gold.Products;