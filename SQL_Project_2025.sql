-- Exploracion inicial de los datos --------------------------------------------
-- 1. Observamos los datos
SELECT *
FROM sales_first;

desc sales_first;

SELECT COUNT(*) row_number
FROM sales_first;


-- 1b) Verificamos la columna de FECHA ----------------------------------------
SELECT MIN(date_column), MAX(date_column)
FROM sales_first;


SELECT *
FROM sales_first
WHERE EXTRACT(MONTH FROM date_column) <> month;


SELECT *
from sales_first
WHERE date_column IS NULL OR TRIM(date_column) = ''
order by date_column;

-- 2. Verificamos las columnas de tipo string primero --------------------------
-- Beverage brand tiene errores
SELECT DISTINCT beverage_brand
FROM sales_first order by beverage_brand;

-- Region tiene errores
SELECT DISTINCT region
FROM sales_first order by region;


-- 2a) Verificamos que no tengan valores vacios o nulos ------------------------
SELECT * 
FROM sales_first 
WHERE region IS NULL OR TRIM(region) = '';

SELECT * 
FROM sales_first 
WHERE beverage_brand IS NULL  OR TRIM(beverage_brand)= '';


-- Verificamos que no hayan filas duplicadas
SELECT *
FROM sales_first
GROUP BY id, retailer_id, date_column, month, region, state_id,
        beverage_brand, price_per_unit, units_sold
HAVING COUNT(*) > 1;

--Vemos que hay valores con errores de formato mal escrito
--No observamos valores nulos o vacios 
--No observamos filas duplicadas


-- 2b)Verifiquemos los errores de region ---------------------------------------
SELECT region, COUNT(region)
FROM sales_first
WHERE region in ('northeast','Northeast','North-east',
                 'South','south', 'Midwest', 'Mid-west')
GROUP BY region;


-- Verifiquemos los errores de beverage_brand 

SELECT beverage_brand, COUNT(beverage_brand)
FROM sales_first
WHERE beverage_brand IN(' Sprite','Sprite','Dasani Water',
                        'DasaniWater', 'Diet Coke','DietCoke')
GROUP BY beverage_brand;


-- Las marcas y regiones con mayor cantidad de registros son los que
-- utilizaremos como formato correcto

-- Ademas vemos que no es valor duplicado es un error en el formato.



-- 3. Verificamos las columnas de tipo numerico --------------------------------
----------------------- Columna state_id -----------------------------
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


----------------------- Columna id -----------------------------
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


----------------------- Columna retailer_id -------------------------
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


----------------------- Columna month -----------------------------
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


----------------------- Columna price_per_unit -----------------------------
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


----------------------- Columna units_sold -----------------------------
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

-- State_id esta bien, no tiene valores duplicados ni vacios ni error en el fomato.
-- Retailer_ID, no tiene valores duplicados ni vacios ni error en el fomato.
-- ID, no tiene valores duplicados ni vacios ni error en el fomato.
-- Month, no tiene valores duplicados ni vacios ni error en el fomato.
-- Price per unit necesita ajustar el formato de decimales.
-- Tenemos 4 valores nulos en la columna units_sold (pensar que hacer con eso).






