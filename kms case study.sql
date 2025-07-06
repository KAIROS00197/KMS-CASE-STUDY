-- To create the database
CREATE DATABASE KMS;

-- Import the tables using table import wizard

USE KMS;

-- Display first five rows 
SELECT *
FROM kms_case_study
LIMIT 5;

-- 1. Which product category had the highest sales?
SELECT Product_Category, SUM(sales) AS total_sales
FROM kms_case_study
GROUP BY Product_Category
ORDER BY total_sales DESC
LIMIT 1; 						-- Product category with the highest sales is TECHNOLOGY.

-- 2. What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT Region, SUM(sales) AS total_sales
FROM kms_case_study
GROUP BY Region
ORDER BY total_sales DESC
LIMIT 3; -- Top three regions are: West, Ontario, Prarie

SELECT Region, SUM(sales) AS total_sales
FROM kms_case_study
GROUP BY Region
ORDER BY total_sales ASC -- Bottom three regions are: Nunavut, Northwest Territories, Yukon
LIMIT 3; 

-- 3. What were the total sales of appliances in Ontario?
SELECT SUM(sales) AS total_sales
FROM kms_case_study
WHERE Product_Sub_Category = "Appliances" AND Region = "Ontario"
GROUP BY REGION;

-- 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT Customer_Name, SUM(sales) AS total_sales, Customer_Segment,Product_Category
FROM kms_case_study
GROUP BY 1,3,4
ORDER BY total_sales ASC;

SELECT Customer_Name, SUM(sales) AS total_sales
FROM kms_case_study
GROUP BY Customer_Name
ORDER BY total_sales ASC;


-- 5. KMS incurred the most shipping cost using which shipping method?
SELECT Ship_Mode, SUM(Shipping_Cost) AS total_shipping_cost
FROM kms_case_study
GROUP BY Ship_Mode
ORDER BY total_shipping_cost DESC
LIMIT 1; 						-- KMS incurred the most shipping cost on Delivery Truck

-- CASE SCENERIO II
-- 6. Who are the most valuable customers, and what products or services do they typically purchase?
SELECT Customer_Name, Product_Category, SUM(Sales) AS category_revenue
FROM kms_case_study
GROUP BY Customer_Name, Product_Category
ORDER BY category_revenue DESC;

-- 7. Which small business customer had the highest sales?
SELECT Customer_Name,Customer_Segment, SUM(sales) AS total_sales
FROM kms_case_study
WHERE Customer_Segment = "Small Business"
GROUP BY Customer_Name
ORDER BY total_sales DESC
LIMIT 1; 					-- Small business customer with the highest sales is Dennis Kane

-- 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?
SELECT Customer_Name, COUNT(DISTINCT Order_ID) AS num_orders
FROM kms_case_study
WHERE Customer_Segment = 'Corporate'
  AND STR_TO_DATE(Order_Date, '%m/%d/%Y') BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY num_orders DESC
LIMIT 1;  					-- Corporate Customer placed the most number of orders in 2009 – 2012 is Adam Hart

-- 9. Which consumer customer was the most profitable one?
SELECT Customer_Name, Customer_Segment, SUM(Profit) AS total_profit
FROM kms_case_study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY total_profit DESC
LIMIT 1;

-- 10. Which customer returned items, and what segment do they belong to?
SELECT k.Customer_Name, k.Customer_Segment, COUNT(*) AS num_returns
FROM kms_case_study k
JOIN order_status o ON o.Order_ID = k.Order_ID
WHERE o.Status = 'Returned'
GROUP BY k.Customer_Name, k.Customer_Segment
ORDER BY num_returns DESC;

SELECT Order_Priority, Ship_Mode, 
       COUNT(*) AS num_orders, 
       SUM(Shipping_Cost) AS total_shipping_cost,
       AVG(Shipping_Cost) AS avg_shipping_cost
FROM kms_case_study
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, total_shipping_cost DESC;
