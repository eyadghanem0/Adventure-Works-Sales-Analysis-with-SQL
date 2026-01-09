-- ===========================================================================================================================
-- Database Setup
-- OBJECTIVES:
-- 1- Creating the database, the schema and the tables
-- 2- Loading the datasets into the database tables
-- APPROACH:
-- 1- Some columns cannot be loaded directly as numeric, these columns will be converted in the data cleaning script
-- 2- Sales data from 2020-2022 were gathered and organized in one facts table
-- ===========================================================================================================================
USE master;
GO
DROP DATABASE IF EXISTS advworks;
GO
CREATE DATABASE advworks;
GO
USE advworks;
GO
CREATE SCHEMA gold;
GO
CREATE TABLE gold.Sales (OrderDate DATE, StockDate DATE, OrderNumber VARCHAR(50), ProductKey INT, CustomerKey INT, 
TerritoryKey INT, OrderLineItem INT,  OrderQuantity INT);
CREATE TABLE gold.Customers (CustomerKey INT, Prefix VARCHAR(50), FirstName VARCHAR(50), LastName VARCHAR(50),
BirthDate DATE, MaritalStatus VARCHAR(50), Gender VARCHAR(50), EmailAddress VARCHAR(200), AnnualIncome VARCHAR(50),
TotalChildren INT, EducationLevel VARCHAR(50), Occupation VARCHAR(50), HomeOwner VARCHAR(50));
CREATE TABLE gold.Products (ProductKey INT, SubCategoryKey INT, ProductSKU VARCHAR(50), ProductName VARCHAR(50),
ModelName VARCHAR(50), ProductDescription VARCHAR(300), ProductColor VARCHAR(50), ProductSize VARCHAR(50),
ProductStyle VARCHAR(50), ProductCost VARCHAR(50), ProductPrice VARCHAR(50));
CREATE TABLE gold.Categories (CategoryKey INT, CategoryName VARCHAR(50));
CREATE TABLE gold.Subcategories (SubcategoryKey INT, SubcategoryName VARCHAR(50), CategoryKey INT );
CREATE TABLE gold.Territories (TerritoryKey INT, Region VARCHAR(50), Country VARCHAR(50), Continent VARCHAR(50));
BULK INSERT gold.Sales FROM 'D:\Adventure Works\AdventureWorks Sales Data 2020.csv' WITH (FIRSTROW = 2 , 
FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Sales FROM 'D:\Adventure Works\AdventureWorks Sales Data 2021.csv' WITH (FIRSTROW = 2 ,
FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Sales FROM 'D:\Adventure Works\AdventureWorks Sales Data 2022.csv' WITH (FIRSTROW = 2 ,
FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Customers FROM 'D:\Adventure Works\AdventureWorks Customer Lookup.csv' WITH (FIRSTROW = 2 ,
FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Products FROM 'D:\Adventure Works\AdventureWorks Product Lookup.csv' WITH (FIRSTROW = 2 , 
FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Categories FROM 'D:\Adventure Works\AdventureWorks Product Categories Lookup.csv' WITH 
(FIRSTROW = 2 , FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Subcategories FROM 'D:\Adventure Works\AdventureWorks Product Subcategories Lookup.csv'
WITH (FIRSTROW = 2 , FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');
BULK INSERT gold.Territories FROM 'D:\Adventure Works\AdventureWorks Territory Lookup.csv' WITH
(FIRSTROW = 2 , FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');