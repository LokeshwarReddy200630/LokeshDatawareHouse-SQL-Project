/*
=================================================================================
Stored Procedure : Load Bronze Layer 
=================================================================================
Script Usage :
  This Stored Procedure Inserts data into bronze tables using 'BULK INSERT' before it will Truncates 
  the data in bronze tables.
Usage Example :
  EXEC bronze.load_bronze
=================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME
BEGIN TRY
SET @batch_start_time = GETDATE()
	PRINT '===============================';
	PRINT 'Loading Bronze Layer';
	PRINT '===============================';

	PRINT '-------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '-------------------------------';
	PRINT'< < ----------- > >'
	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT'Inserting Data Into : bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;

	PRINT'Inserting Data Into : bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.crm_sales_info';
	TRUNCATE TABLE bronze.crm_sales_details;

	PRINT'Inserting Data Into : bronze.crm_sales_info';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	PRINT '-------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '-------------------------------';

	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;

	PRINT'Inserting Data Into : bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;

	PRINT'Inserting Data Into : bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'

	SET @start_time = GETDATE();
	PRINT 'Truncating Table : bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;

	PRINT'Inserting Data Into :bronze.erp_px_cat_g1v2 ';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\gonep\OneDrive\Scans\Loki RBI\Management\SQL\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	)
		SET @end_time = GETDATE();
	PRINT 'LOAD DURATION  ' + CAST(DATEDIFF(second,@start_time , @end_time)AS NVARCHAR) + ' seconds'
	PRINT'< < ----------- > >'
	SET @batch_end_time = GETDATE()
	PRINT'========================================='
	PRINT 'LOADING BRONZE LAYER IS COMPLETED'
	PRINT'LOAD DURATION : ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time)AS NVARCHAR) + ' seconds'
	PRINT'========================================='

	END TRY
	BEGIN CATCH
	PRINT '==================================='
	PRINT 'ERROR OCCURED AT BRONZE LAYER'
	PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE'+ ERROR_NUMBER();
	PRINT 'ERROR MESSAGE'+ ERROR_STATE();
	PRINT '==================================='
	END CATCH
END
