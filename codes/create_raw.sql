CREATE DATABASE IF NOT EXISTS tin_sales_raw
COMMENT 'Raw sales data imported from csv files';

--Create External customers Table
CREATE EXTERNAL TABLE IF NOT EXISTS tin_sales_raw.customers (
CustomerID int,
FirstName varchar,
MiddleInitial varchar,
LastName varchar)
COMMENT 'customers table'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/Customers2/'
TBLPROPERTIES ("skip.header.line.count"="1");

--Create External sales Table
CREATE EXTERNAL TABLE IF NOT EXISTS tin_sales_raw.sales (
OrderID int,
SalesPersonID int,
CustomerID int,
ProductID int,
Quantity int,
datetim timestamp)
COMMENT 'sales table'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/Sales2/'
TBLPROPERTIES ("skip.header.line.count"="1");

--Create External employees Table
CREATE EXTERNAL TABLE IF NOT EXISTS tin_sales_raw.employees (
EmployeeID int,
FirstName varchar,
MiddleInitial varchar,
LastName varchar,
Region varchar)
COMMENT 'employees table'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/salesdb/Employees2/'
TBLPROPERTIES ("skip.header.line.count"="1");

--Create External products Table
CREATE EXTERNAL TABLE IF NOT EXISTS tin_sales_raw.products (
ProductID int,
Name varchar,
Price decimal(8,4))
COMMENT 'products table'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/Products/'
TBLPROPERTIES ("skip.header.line.count"="1");
