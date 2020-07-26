
--*************************************
--CREATE Parquet TABLES on Train Data
--*************************************

Create Database IF NOT EXISTS tin_sales
COMMENT 'Parquet sales data imported from sales database';

--Create Parquet sales Table

CREATE TABLE IF NOT EXISTS tin_sales.sales
COMMENT 'Parquet sales table'
STORED AS Parquet
AS
SELECT * from tin_sales_raw.sales;

--Create Parquet customers Table
CREATE TABLE IF NOT EXISTS tin_sales.customers
COMMENT 'Parquet customers table'
STORED AS Parquet
AS
SELECT DISTINCT customerid, firstname, middleinitial, lastname
from tin_sales_raw.customers;

--Create Parquet employees Table
CREATE TABLE IF NOT EXISTS tin_sales.employees
COMMENT 'Parquet trains table'
STORED AS Parquet
AS
SELECT *
from tin_sales_raw.employees;

--Create Parquet products Table
CREATE TABLE IF NOT EXISTS tin_sales.products
COMMENT 'Parquet trains table'
STORED AS Parquet
AS
SELECT *
from tin_sales_raw.products;
