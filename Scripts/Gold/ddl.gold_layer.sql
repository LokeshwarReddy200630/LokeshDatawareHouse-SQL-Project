/*
=================================================================
DDL Code : Create Gold views
=================================================================
Code Purpose : 
    The code creates the views of the gold layer by by dropping them if they exists 
    Each view contains clean data taken from silver layer
    Gold layer represents the STAR SCHEMA (dimensions : Theoritical , facts : measurable)

Usage: These views can be queried directly for analytics and reporting
=================================================================*/
/*===============================================================
Create Table : gold.customers
=================================================================*/
DROP VIEW IF EXISTS gold.customers 
GO
CREATE VIEW gold.customers AS
SELECT
ROW_NUMBER() OVER (ORDER BY cust_id) AS customer_key,
a.cust_id AS customer_id,
a.cust_key AS customer_number,
a.cst_firstname AS first_name,
a.cst_lastname AS last_name,
a.cst_marital_status AS marital_status,
CASE WHEN a.cst_gender != 'N/A' THEN a.cst_gender 
ELSE COALESCE(b.gender,'N/A')
END AS gender,
b.bdate AS birthdate,
a.cst_create_date AS create_date
FROM silver.crm_cust_info a
LEFT JOIN silver.erp_cust_az12 b
ON a.cust_key = b.cid
/*===============================================================
Create Table : gold.products
=================================================================*/
 DROP VIEW IF EXISTS gold.products
 GO
 CREATE VIEW gold.products AS
 SELECT
 ROW_NUMBER() OVER ( ORDER BY d.prd_start_date,d.prd_key) AS product_key,
d.prd_id AS product_id,
d.prd_key AS product_number,
d.prd_name AS product_name,
d.cat_id AS category_id,
e.category,
e.subcategry AS subcategory,
d.prd_cost AS cost,
d.prd_line AS product_line,
d.prd_start_date AS product_start_date,
e.maintenance
FROM silver.crm_prd_info d
LEFT JOIN silver.erp_px_cat_g1v2 e
ON d.cat_id = e.id
WHERE d.prd_end_date IS NULL
/*===============================================================
Create Table : gold.sales
=================================================================*/
DROP VIEW IF EXISTS gold.sales
GO
CREATE VIEW gold.sales AS
SELECT
f.sales_ord_num AS order_number,
g.product_key ,
h.customer_key,
f.sales_order_date AS order_date,
f.sales_ship_date AS ship_date,
f.sales_due_date AS due_date,
f.sales_sales AS sales,
f.sales_quantity AS quantity,
f.sales_price AS price
FROM silver.crm_sales_details f
LEFT JOIN gold.products g
ON f.sales_prd_key = g.product_number
LEFT JOIN gold.customers h
ON f.sales_cust_id = h.customer_id

