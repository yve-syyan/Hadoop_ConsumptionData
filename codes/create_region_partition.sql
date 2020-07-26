CREATE TABLE IF NOT EXISTS tin_sales.product_region_sales_partition
PARTITIONED BY (region, sales_year, sales_month)
COMMENT 'Parquet partitioned sales table'
STORED AS Parquet
AS 
SELECT s.orderid, s.salespersonid, s.customerid, s.productid, p.name, p.price, s.quantity, p.price*s.quantity as sales_amount, s.datetim as order_date, em.region, year(s.datetim) as sales_year, month(s.datetim) as sales_month
FROM tin_sales.sales s JOIN tin_sales.products p ON s.productid = p.productid JOIN tin_sales.employees em ON s.salespersonid = em.employeeid