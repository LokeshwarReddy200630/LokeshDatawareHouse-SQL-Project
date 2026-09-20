/*
=================================================================================
Stored Procedure : Load Silver Layer 
=================================================================================
Code Usage :
  This Stored Procedure Inserts data into bronze tables using 'BULK INSERT' before it will Truncates 
  the data in bronze tables.
Usage Example :
  EXEC bronze.load_bronze
=================================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN
DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME
BEGIN TRY
SET @batch_start_time = GETDATE()
	PRINT '===============================';
	PRINT 'Loading Silver Layer';
	PRINT '===============================';

	PRINT '-------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '-------------------------------';
	PRINT'< < ----------- > >'
	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.crm_cust_info';
		TRUNCATE TABLE silver.crm_cust_info
		PRINT '>>Inserting the data into silver.crm_cust_info';
		INSERT INTO silver.crm_cust_info (
		cust_id,
		cust_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gender,
		cst_create_date)
		SELECT
		cust_id,
		cust_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE WHEN TRIM(cst_marital_status) = 'M' THEN 'MARRIED'
			WHEN TRIM(cst_marital_status) = 'S' THEN 'SINGLE'
			ELSE 'N/A'
		END cst_marital_status,
		CASE WHEN cst_gender = 'F' THEN 'Female'
			WHEN cst_gender = 'M' THEN 'Male'
			ELSE 'N/A'
			END cst_gender,
		cst_create_date
		FROM 
		(SELECT 
		*,
		ROW_NUMBER () OVER (PARTITION BY cust_id ORDER BY cst_create_date DESC) AS rank
		FROM bronze.crm_cust_info
		WHERE cust_id IS NOT NULL
		)t
		WHERE rank =1
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.crm_prd_info';
		TRUNCATE TABLE silver.crm_prd_info
		PRINT '>>Inserting the data into silver.crm_prd_info';
		INSERT INTO silver.crm_prd_info  (
			prd_id ,
			cat_id ,
			prd_key ,
			prd_name,
			prd_cost,
			prd_line,
			prd_start_date,
			prd_end_date
			)
		SELECT
		prd_id,
		REPLACE (SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
		SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
		prd_name,
		COALESCE(prd_cost,0) AS prd_cost,
		CASE TRIM(prd_line)
		WHEN 'M' THEN 'Mountain'
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales'
		WHEN 'T' THEN 'Touring'
		ELSE 'N/A'
		END AS prd_line,
		CAST(prd_start_date AS DATE) AS prd_start_date,
		CAST(LEAD(prd_start_date) OVER( PARTITION BY prd_key ORDER BY prd_start_date)-1AS DATE) AS prd_end_date
		FROM bronze.crm_prd_info
			SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.crm_sales_details';
		TRUNCATE TABLE silver.crm_sales_details
		PRINT '>>Inserting the data into silver.crm_sales_details';
		INSERT INTO silver.crm_sales_details(
			sales_ord_num,
			sales_prd_key,
			sales_cust_id,
			sales_order_date,
			sales_ship_date,
			sales_due_date,
			sales_sales,
			sales_quantity,
			sales_price 
			)
		SELECT
		sales_ord_num,
		sales_prd_key,
		sales_cust_id,
		CASE WHEN sales_order_date =0 OR LEN(sales_order_date) != 8 THEN NULL
		ELSE CAST(CAST(sales_order_date AS VARCHAR) AS DATE)
		END AS sales_order_date,
		CASE WHEN sales_ship_date =0 OR LEN(sales_ship_date) != 8 THEN NULL
		ELSE CAST(CAST(sales_ship_date AS VARCHAR) AS DATE)
		END AS sales_ship_date,
		CASE WHEN sales_due_date =0 OR LEN(sales_due_date) != 8 THEN NULL
		ELSE CAST(CAST(sales_due_date AS VARCHAR) AS DATE)
		END AS sales_due_date,
		CASE WHEN sales_sales <=0 OR sales_sales IS NULL OR sales_sales != sales_quantity * ABS(sales_price)
		THEN  sales_quantity * ABS(sales_price)
		ELSE sales_sales
		END AS sales_sales,
		sales_quantity,
		CASE WHEN sales_price <=0 OR sales_price IS NULL
		THEN  sales_sales / NULLIF(sales_quantity,0)
		ELSE sales_price
		END AS sales_price
		FROM bronze.crm_sales_details
			SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	PRINT '-------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '-------------------------------';

	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.erp_cust_az12';
		TRUNCATE TABLE silver.erp_cust_az12
		PRINT '>>Inserting the data into silver.erp_cust_az12';
		INSERT INTO silver.erp_cust_az12(
		cid,
		bdate,
		gender
		)
		SELECT
		CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		ELSE cid
		END AS cid,
		CASE WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
		END AS bdate,
		CASE WHEN UPPER(TRIM(gender)) IN ('F' , 'FEMALE') THEN 'Female'
			WHEN UPPER(TRIM(gender)) IN ('M' , 'MALE') THEN 'Male'
		END AS gender
		FROM bronze.erp_cust_az12
			SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.erp_loc_a101';
		TRUNCATE TABLE silver.erp_loc_a101
		PRINT '>>Inserting the data into silver.erp_loc_a101';
		INSERT INTO silver.erp_loc_a101(
		cid,
		country
		)
		SELECT
		REPLACE(cid,'-','') AS cid,
		CASE 
		WHEN TRIM(country) ='DE' THEN 'Germany'
		WHEN (TRIM(country)) IN ('' ,'US','USA') THEN 'United States'
		WHEN TRIM(country) IS NULL OR TRIM(country) = '' THEN 'N/A'
		ELSE TRIM(country)
		END country
		FROM bronze.erp_loc_a101
			SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
		PRINT '>> Truncating the Table silver.erp_px_cat_g1v2';
		TRUNCATE TABLE silver.erp_px_cat_g1v2
		PRINT '>>Inserting the data into silver.erp_px_cat_g1v2';
		INSERT INTO silver.erp_px_cat_g1v2(
		id,
		category,
		subcategry,
		maintenance
		)
		SELECT
		id,
		category,
		subcategry,
		maintenance
		FROM bronze.erp_px_cat_g1v2
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'
	SET @batch_end_time = GETDATE()
	PRINT'========================================='
	PRINT 'LOADING SILVER LAYER IS COMPLETED'
	PRINT'LOAD DURATION : ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time)AS NVARCHAR) + ' seconds'
	PRINT'========================================='

	END TRY
	BEGIN CATCH
	PRINT '==================================='
	PRINT 'ERROR OCCURED AT SILVER LAYER'
	PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '==================================='
	END CATCH
END


