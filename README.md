## Introduction
This project focuses on using SQL to analyze sales, customers demographics and product for an E-Commerce bicycle retail and manufacturing business. Raw data will be used to evaluate business performance and guide decision-making. The scripts were written in DBeaver (SQL client) and on SQL Server (local database).

## About The Datasets
The datasets represent transactional data from the online sales operations of a bicycle manufacturing and retail business. It is structured using fact and dimension tables, covering sales transactions, products, customers, and geographic information. The data spans multiple years and supports KPI calculation, time-based analysis, and customer and product segmentation.

## Instructions

- SQL scripts are included inside the "Scripts" folder, each script contains a brief explanation of objectives/approach/findings ....

- The used datsets are included in inside the "Datasets" folder as csv files


## Insights
### OBJECTIVES:
- Answering specific questions and presenting suggestions to increase profit and guide decision-making
- Increasing profit and sales in smaller subcategories (which have high profit margin) by selecting top products and prioritizing them for higher-volume sales
- Identifying the potential to introduce high-price product by analyzing customers' purchasing power and income in comparison to their purchases of expensive products
- Identifying under-performing subcategories to redirect resources into marketing or other products/subcategories
- Calculating the average of profit and orders per customer across years and comparing them with CAC numbers from marketing to evaluate marketing strategy and balance customer acquisition and retention efforts 
### Questions:
- In smaller categories, which subcategories have high profit margin and large quantity sold? 
- Which products from these subcategories are the most suitable to be prioritized?
- Do expensive products perform well in sales and is there a relationship with customers income?
- What are the 5 least profitable subcategories?
- What are the avg orders and profit per customer from 2020-2022?
### KEY FINDINGS:
- "Tires and Tubes", "Bottles and Cages" and "Gloves" were chosen based on the previous criteria. These subcategories ensure high-volume sales and high profit margin. Products from these subcategories were presented
- High-priced products are performing well which creates opportunities for adding new expensive products
- As customers income increases, their purchases of expensive products also increase (relative to customers count) and the reelationship is clear when customers count is similar (10-40 and 50-80 k$)
- Under-performing categories are "Socks", "Cleaners", "Caps", "Vests" and "Bike Racks"
- Growth depends mainly on acquisition which makes marketing and attracting new customers consistently a priority
