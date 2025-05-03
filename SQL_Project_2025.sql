-- Initial data exploration --------------------------------------------
-- 1. Visualize the data
SELECT *
FROM sales_first;

desc sales_first;

SELECT COUNT(*) row_number
FROM sales_first;


-- 1b) Check the DATE column ----------------------------------------
SELECT MIN(date_column), MAX(date_column)
FROM sales_first;


SELECT *
FROM sales_first
WHERE EXTRACT(MONTH FROM date_column) <> month;


SELECT *
from sales_first
WHERE date_column IS NULL OR TRIM(date_column) = ''
order by date_column;

-- 2. First, validate the string-type columns --------------------------
-- Beverage brand has errors
SELECT DISTINCT beverage_brand
FROM sales_first order by beverage_brand;

--Region has errors
SELECT DISTINCT region
FROM sales_first order by region;


-- 2a) Check for missing or null values ---------------------------------------
SELECT * 
FROM sales_first 
WHERE region IS NULL OR TRIM(region) = '';

SELECT * 
FROM sales_first 
WHERE beverage_brand IS NULL  OR TRIM(beverage_brand)= '';


-- Check for duplicate rows
SELECT *
FROM sales_first
GROUP BY id, retailer_id, date_column, month, region, state_id,
        beverage_brand, price_per_unit, units_sold
HAVING COUNT(*) > 1;

--We observe formatting errors in some values
--No missing or null values found 
--No duplicate rows found


-- 2b)Let's check the region errors ---------------------------------------
SELECT region, COUNT(region)
FROM sales_first
WHERE region in ('northeast','Northeast','North-east',
                 'South','south', 'Midwest', 'Mid-west')
GROUP BY region;


--  Let's check the beverage_brand errors 

SELECT beverage_brand, COUNT(beverage_brand)
FROM sales_first
WHERE beverage_brand IN(' Sprite','Sprite','Dasani Water',
                        'DasaniWater', 'Diet Coke','DietCoke')
GROUP BY beverage_brand;


-- The brands and regions with the most records will be used as the correct formatting reference
-- Also, we see that the issue is formatting, not duplicates



-- 3. Validate the numeric-type columns ----------------------------------------
----------------------- column state_id -----------------------------
SELECT * 
FROM sales_first 
WHERE state_id IS NULL OR TRIM(state_id) = ''
ORDER BY date_column;


SELECT state_id, count(DISTINCT state_id) distintos
FROM sales_first
group by state_id
order by state_id;


SELECT
    COUNT(state_id) AS cantidad,
    COUNT(DISTINCT state_id) AS distintos,
    MIN(state_id) AS minimo,
    MAX(state_id) AS maximo,
    ROUND(AVG(state_id),2) AS promedio,
    ROUND(MEDIAN(state_id),2) AS mediana,
    ROUND(STDDEV(state_id),2) AS desviacion_estandar
FROM sales_first;


----------------------- column id -----------------------------
SELECT * 
FROM sales_first 
WHERE id IS NULL OR TRIM(id) = ''
ORDER BY date_column;

SELECT id, count(DISTINCT id) distintos
FROM sales_first
group by id
order by id;

SELECT
    COUNT(id) AS cantidad,
    COUNT(DISTINCT id) AS distintos,
    MIN(id) AS minimo,
    MAX(id) AS maximo,
    ROUND(AVG(id),2) AS promedio,
    ROUND(MEDIAN(id),2) AS mediana,
    ROUND(STDDEV(id),2) AS desviacion_estandar
FROM sales_first;


----------------------- column retailer_id -------------------------
SELECT * 
FROM sales_first 
WHERE retailer_id IS NULL OR TRIM(retailer_id) = ''
ORDER BY date_column;

SELECT retailer_id, count(DISTINCT retailer_id) distintos
FROM sales_first
group by retailer_id
order by retailer_id;

SELECT
    COUNT(retailer_id) AS cantidad,
    COUNT(DISTINCT retailer_id) AS distintos,
    MIN(retailer_id) AS minimo,
    MAX(retailer_id) AS maximo,
    ROUND(AVG(retailer_id),2) AS promedio,
    ROUND(MEDIAN(retailer_id),2) AS mediana,
    ROUND(STDDEV(retailer_id),2) AS desviacion_estandar
FROM sales_first;


----------------------- column month -----------------------------
SELECT * 
FROM sales_first 
WHERE month IS NULL OR TRIM(month) = ''
ORDER BY date_column;

SELECT month, count(DISTINCT month) distintos
FROM sales_first
group by month
order by month;

SELECT month, count( month)
FROM sales_first
group by month
order by month;

SELECT
    COUNT(month) AS cantidad,
    COUNT(DISTINCT month) AS distintos,
    MIN(month) AS minimo,
    MAX(month) AS maximo,
    ROUND(AVG(month),2) AS promedio,
    ROUND(MEDIAN(month),2) AS mediana,
    ROUND(STDDEV(month),2) AS desviacion_estandar
FROM sales_first;


----------------------- column price_per_unit -----------------------------
SELECT * 
FROM sales_first 
WHERE price_per_unit IS NULL OR TRIM(price_per_unit) = ''
ORDER BY date_column;

SELECT price_per_unit, count(DISTINCT price_per_unit) distintos
FROM sales_first
group by price_per_unit
order by price_per_unit;

SELECT
    COUNT(price_per_unit) AS cantidad,
    COUNT(DISTINCT price_per_unit) AS distintos,
    MIN(price_per_unit) AS minimo,
    MAX(price_per_unit) AS maximo,
    ROUND(AVG(price_per_unit),2) AS promedio,
    ROUND(MEDIAN(price_per_unit),2) AS mediana,
    ROUND(STDDEV(price_per_unit),2) AS desviacion_estandar
FROM sales_first;


----------------------- column units_sold -----------------------------
SELECT * 
FROM sales_first 
WHERE units_sold IS NULL OR TRIM(units_sold) = ''
ORDER BY date_column;

SELECT units_sold, count(DISTINCT units_sold) distintos
FROM sales_first
group by units_sold
order by units_sold;


SELECT
    COUNT(units_sold) AS cantidad,
    COUNT(DISTINCT units_sold) AS distintos,
    MIN(units_sold) AS minimo,
    MAX(units_sold) AS maximo,
    ROUND(AVG(units_sold),2) AS promedio,
    ROUND(MEDIAN(units_sold),2) AS mediana,
    ROUND(STDDEV(units_sold),2) AS desviacion_estandar
FROM sales_first;


SELECT month ,beverage_brand, ROUND(AVG(units_sold),2)
FROM sales_validados
WHERE units_sold IS NOT NULL
GROUP BY month, beverage_brand
ORDER BY month;


SELECT * 
FROM sales_validados
WHERE month = 2
ORDER BY month;

-- State_id is fine, no duplicates, nulls, or formatting issues
-- Retailer_ID is fine, no duplicates, nulls, or formatting issues
-- ID is fine, no duplicates, nulls, or formatting issues
-- Month is fine, no duplicates, nulls, or formatting issues
-- Price per unit needs decimal formatting adjustment
-- We have 4 null values in the units_sold column (consider how to handle them)






