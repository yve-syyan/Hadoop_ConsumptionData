--*******************************************
--CREATE monthly partitions on Product_Sales
--*******************************************

--Create partitioned monthly sales

CREATE TABLE IF NOT EXISTS tin_sales.product_sales_partition
PARTITIONED BY (sales_year, sales_month)
COMMENT 'Parquet partitioned sales table'
STORED AS Parquet
AS 
SELECT s.orderid, s.salespersonid, s.customerid, s.productid, p.name, p.price, s.quantity, p.price*s.quantity as sales_amount, s.datetim as order_date, year(s.datetim) as sales_year, month(s.datetim) as sales_month
FROM tin_sales.sales s JOIN tin_sales.products p ON s.productid = p.productid;

--Create Partitioned monthly view
CREATE VIEW IF NOT EXISTS tin_sales.customer_monthly_sales_2019_partitioned_view AS
SELECT c.customerid, c.lastname, c.firstname, ps.sales_year, ps.sales_month, sum(ps.sales_amount) as lifetime_amount
FROM tin_sales.product_sales_partition ps JOIN tin_sales.customers c ON ps.customerid = c.customerid
GROUP BY c.customerid, c.lastname, c.firstname, ps.sales_year, ps.sales_month
HAVING  ps.sales_year = 2019;