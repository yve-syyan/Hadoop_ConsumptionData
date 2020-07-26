CREATE VIEW IF NOT EXISTS tin_sales.customer_monthly_sales_2019_view as
SELECT c.customerid, c.lastname, c.firstname, year(s.datetim) as Year, month(s.datetim) as Month, sum(s.quantity * p.price) as total_amount
FROM tin_sales.sales s JOIN tin_sales.customers c ON s.customerid = c.customerid JOIN tin_sales.products p ON s.productid = p.productid
GROUP BY c.customerid, c.lastname, c.firstname, year(s.datetim), month(s.datetim)
HAVING  year(s.datetim) = 2019;


--View: top_ten_customers_amount_view
--Customer id, customer last name, customer first name,
--total lifetime purchased amount

CREATE VIEW IF NOT EXISTS tin_sales.top_ten_customers_amount_view as
SELECT c.customerid, c.lastname, c.firstname, sum(s.quantity * p.price) as lifetime_amount
FROM tin_sales.sales s JOIN tin_sales.customers c ON s.customerid = c.customerid JOIN tin_sales.products p ON s.productid = p.productid
GROUP BY c.customerid, c.lastname, c.firstname
ORDER BY lifetime_amount DESC
limit 10;
