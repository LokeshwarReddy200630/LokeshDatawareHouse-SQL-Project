/*
====================================================================================================
-------------------------------------------------------------------
DDL Script : Create Bronze Tables
-------------------------------------------------------------------
Script purpose :
  This Script creates bronze tables . By dropping them if they already exists in the database
====================================================================================================
*/


DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info
(
	cust_id INT,
	cust_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gender NVARCHAR(50),
	cst_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info
(
	prd_id INT,
	prd_key NVARCHAR(100),
	prd_name NVARCHAR(100),
	prd_cost INT,
	prd_line NVARCHAR(100),
	prd_start_date DATE,
	prd_end_date DATE
);

DROP TABLE IF EXISTS bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details
(
	sales_ord_num NVARCHAR(50),
	sales_prd_key NVARCHAR(50),
	sales_cust_id INT,
	sales_order_date INT,
	sales_ship_date INT,
	sales_due_date INT,
	sales_sales INT,
	sales_quantity INT,
	sales_price INT
);

DROP TABLE IF EXISTS bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12
(
	cid NVARCHAR(50),
	bdate DATE,
	gender NVARCHAR(10)
);

DROP TABLE IF EXISTS bronze.erp_loc_a101 ;
CREATE TABLE bronze.erp_loc_a101 
(
	cid NVARCHAR(50),
	country NVARCHAR(50)
);

DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 
(
	id NVARCHAR(50),
	category NVARCHAR(50),
	subcategry NVARCHAR(50),
	maintenance NVARCHAR(50)
);

