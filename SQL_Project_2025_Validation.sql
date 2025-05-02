-- Crear una nueva tabla en base a la original
CREATE TABLE sales_validados AS
SELECT * FROM sales_first WHERE 1=0;

-- Agregamos los valores a la tabla
INSERT INTO sales_validados
SELECT * FROM sales_first;


--TRUNCATE TABLE sales_validados;
--SELECT * FROM sales_validados;

-- Modificando/Arreglando  los datos (String)-----------------------------------
-- 1. Hacemos los cambios identificados a beverage brand -----------------------
UPDATE sales_validados
SET beverage_brand = TRIM(beverage_brand)
WHERE beverage_brand LIKE ' %';

UPDATE sales_validados
SET beverage_brand = 'Sprite'
WHERE beverage_brand = ' Sprite';

UPDATE sales_validados
SET beverage_brand = 'Dasani Water'
WHERE beverage_brand = 'DasaniWater';

UPDATE sales_validados
SET beverage_brand = 'Diet Coke'
WHERE beverage_brand = 'DietCoke';


SELECT beverage_brand, COUNT(beverage_brand)
FROM sales_validados
GROUP BY beverage_brand;


-- 1b) Hacemos los cambios identificados a region ------------------------------
UPDATE sales_validados
SET region = 'Midwest'
WHERE region = 'Mid-west';

UPDATE sales_validados
SET region = 'Northeast'
WHERE region = 'northeast';

UPDATE sales_validados
SET region = 'Northeast'
WHERE region = 'North-east';

UPDATE sales_validados
SET region = 'South'
WHERE region = 'south';



-- Modificando/Arreglando  los datos (Numeric)----------------------------------
-- 2. Hacemos los cambios identificados a price_per _unit-----------------------

UPDATE sales_validados
SET price_per_unit = ROUND(price_per_unit, 2);

select * from sales_validados;


-- 2b) Hacemos los cambios identificados a units_sold---------------------------
-- Cambiamos los valores nulos por el promedio de ese valor agrupado por brand y mes
MERGE INTO sales_validados t
USING (
  SELECT MONTH, beverage_brand, ROUND(AVG(units_sold), 2) AS promedio
  FROM sales_validados
  WHERE units_sold IS NOT NULL
  GROUP BY MONTH, beverage_brand
) prom
ON (t.MONTH = prom.MONTH AND t.beverage_brand = prom.beverage_brand)
WHEN MATCHED THEN
  UPDATE SET t.units_sold = prom.promedio
  WHERE t.units_sold IS NULL;

-- Verificamos los cambios en los valores nulos
SELECT *
FROM sales_validados
WHERE id in(5007,5871,5132,5057,5925) ;


-- Hay 1 o 2 productos por state_id
SELECT MONTH, BEVERAGE_BRAND, STATE_ID, COUNT(*) AS registros
FROM sales_first
WHERE UNITS_SOLD IS NOT NULL
GROUP BY MONTH, BEVERAGE_BRAND, STATE_ID
ORDER BY month;
 
SELECT *
FROM sales_validados;

 
-- Utilizamos unicamente brand y month para rellenar los valores vacios, ya que al agregar la capa por state_id unicamente hay 1 o 2 valores. 



-- Final Table -----------------------------------------------------------
-- Check the two tables we want to join
select * from retailer_id;

select * from state_table;

-- Create the final version of the table
CREATE TABLE sales_final AS
SELECT 
    s.ID,
    r.retailer as retailer,
    s.date_column,
    s.month,
    s.region,
    st.state as state,
    s.beverage_brand,
    s.price_per_unit,
    s.units_sold
from sales_validados s
JOIN retailer_id r on s.retailer_id = r.retailer_id
JOIN state_table st on s.state_id = st.id
ORDER BY date_column;

select * from sales_final;




--------------------------------------------------------------------------------
-- Verify the table content one last time with a table_summary
WITH p AS (
  SELECT
    PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY price_per_unit) AS p05,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY price_per_unit) AS p95
  FROM sales_final
),
base AS (
  SELECT
    sf.*,
    CASE WHEN units_sold IS NULL THEN 1 ELSE 0 END AS null_units_sold,
    CASE WHEN retailer   IS NULL THEN 1 ELSE 0 END AS null_retailer,

    CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) > 1
         THEN 1 ELSE 0 END AS is_duplicate,

    CASE WHEN price_per_unit < (SELECT p05 FROM p)
           OR price_per_unit > (SELECT p95 FROM p)
         THEN 1 ELSE 0 END AS is_outlier
  FROM sales_final sf
)
SELECT
  COUNT(*)                           AS total_rows,
  MIN(date_column)                   AS min_date,
  MAX(date_column)                   AS max_date,
  SUM(null_units_sold)               AS null_units_sold,
  ROUND(100.0 * SUM(null_units_sold) / COUNT(*), 2) AS pct_null_units_sold,
  SUM(null_retailer)                 AS nulls_retailer,
  COUNT(DISTINCT beverage_brand)     AS unique_brands,
  COUNT(DISTINCT state)              AS unique_states,
  SUM(is_duplicate)                  AS dup_rows,
  SUM(is_outlier)                    AS outlier_rows
FROM base;
  





