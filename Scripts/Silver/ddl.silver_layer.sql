/*
====================================================================
DDL CODE : Create Silver Tables
====================================================================
Code Purpose:
  This Code Creates Tables in the 'Silver' schema, by dropping the existing tables
====================================================================
*/
 
DROP TABLE IF EXISTS silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info
(
	cust_id INT,
	cust_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gender NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

DROP TABLE IF EXISTS silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info
(
	prd_id INT,
	prd_key NVARCHAR(100),
	prd_name NVARCHAR(100),
	prd_cost INT,
	prd_line NVARCHAR(100),
	prd_start_date DATETIME,
	prd_end_date DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

DROP TABLE IF EXISTS silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details
(
	sales_ord_num NVARCHAR(50),
	sales_prd_key NVARCHAR(50),
	sales_cust_id INT,
	sales_order_date INT,
	sales_ship_date INT,
	sales_due_date INT,
	sales_sales INT,
	sales_quantity INT,
	sales_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

DROP TABLE IF EXISTS silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12
(
	cid NVARCHAR(50),
	bdate DATE,
	gender NVARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

DROP TABLE IF EXISTS silver.erp_loc_a101 ;
CREATE TABLE silver.erp_loc_a101 
(
	cid NVARCHAR(50),
	country NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2 
(
	id NVARCHAR(50),
	category NVARCHAR(50),
	subcategry NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

