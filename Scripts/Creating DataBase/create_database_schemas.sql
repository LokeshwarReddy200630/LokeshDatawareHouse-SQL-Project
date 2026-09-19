/*
=================================================
Create Database and Schemas
=================================================
Code Purpose :
  This Code creates a new database named 'LokeshDataWareHouse' by droping it , if already exists.
  Additionally , the Code set ups three schemas in the database : 'bronze' , 'silver' , and 'gold'.
** NOTE ** :
      Running this code will drop existing database named 'LokeshDataWareHouse' . 
      All the data which was in the database will be permenently deleted , so please make sure 
      there is no database named 'LokeshDataWareHouse' in your server.
================================================
*/


DROP DATABASE IF EXISTS LokeshDataWareHouse;
GO
CREATE DATABASE LokeshDataWareHouse;
GO
USE LokeshDataWareHouse;
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
