/*
Task 1: Understanding the data in hand

A. Description of the Data

	I. cust_dimen: Details of all the customers
		-Customer_Name (TEXT): Name of the customer
        -Province (TEXT): Province of the customer
        -Region (TEXT): Region of the customer
        -Customer_Segment (TEXT): Segment of the customer
        -Cust_id (TEXT): Unique Customer ID
	
    II. market_fact: Details of every order item sold
		-Ord_id (TEXT): Order ID
        -Prod_id (TEXT): Prod ID
        -Ship_id (TEXT): Shipment ID
        -Cust_id (TEXT): Customer ID
        -Sales (DOUBLE): Sales from the Item sold
        -Discount (DOUBLE): Discount on the Item sold
        -Order_Quantity (INT): Order Quantity of the Item sold
        -Profit (DOUBLE): Profit from the Item sold
        -Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        -Product_Base_Margin (DOUBLE): Product Base Margin on the Item sold
        
    III. orders_dimen: Details of every order placed
		-Order_ID (INT): Order ID
        -Order_Date (TEXT): Order Date
        -Order_Priority (TEXT): Priority of the Order
        -Ord_id (TEXT): Unique Order ID
	
    IV. prod_dimen: Details of product category and sub category
		-Product_Category (TEXT): Product Category
        -Product_Sub_Category (TEXT): Product Sub Category
        -Prod_id (TEXT): Unique Product ID
	
    V. shipping_dimen: Details of shipping of orders
		-Order_ID (INT): Order ID
        -Ship_Mode (TEXT): Shipping Mode
        -Ship_Date (TEXT): Shipping Date
        -Ship_id (TEXT): Unique Shipment ID

B. The List of Primary Keys and Foreign Keys for this dataset

I. cust_dimen
		->Primary Key: Cust_id
        ->Foreign Key: NA
II. market_fact
		->Primary Key: NA
        ->Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
III. orders_dimen
		->Primary Key: Ord_id
        ->Foreign Key: NA
IV. prod_dimen
		->Primary Key: Prod_id, Product_Sub_Category
        ->Foreign Key: NA
V. shipping_dimen
		->Primary Key: Ship_id
       -> Foreign Key: NA
 */
 
/*
Task 2: Basic Analysis */

use superstores;
show tables;
/*1.display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen*/
select Customer_Name as 'Customer Name', Customer_Segment as 'Customer Segment'
from cust_dimen;
/*2.to find all the details of the customer from the table cust_dimen order by desc*/
select*from cust_dimen
order by Cust_id desc;
/*3.get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high. */
select Order_ID,Order_Date,Order_Priority
from orders_dimen
where Order_Priority = 'HIGH';
/*4.total and the average sales (display total_sales and avg_sales)*/
select sum(sales)  as total_sales,avg(sales) as avg_sales 
from market_fact;
/*5.get the maximum and minimum sales from maket_fact table*/
select max(sales),min(sales)
from market_fact;	
/*6.Display the number of customers in each region in decreasing order */			
select distinct(Region),count(Customer_name)as No_of_customers
from cust_dimen
group by Region
order by No_of_customers desc;
/*7.Find the region having maximum customers*/
select distinct(Region),count(Cust_id)as max_of_customers
from cust_dimen
group by Region
order by max_of_customers desc
limit 1;
/*8.Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased*/
SELECT c.customer_name, COUNT(*) AS no_of_tables_purchased
FROM
market_fact m
INNER JOIN
cust_dimen c ON m.cust_id = c.cust_id
WHERE
c.region = 'atlantic'
AND m.prod_id = ( SELECT prod_id FROM 	prod_dimen WHERE product_sub_category = 'tables'	)
GROUP BY m.cust_id, c.customer_name;
/*9.customers from Ontario province who own Small Business. (display the customer name, no of small business owners) */
select customer_name, customer_segment from cust_dimen
where province='ONTARIO' and customer_segment='SMALL BUSINESS';
/*10.number and id of products sold in decreasing order of products sold 
(display product id, no_of_products sold)*/
select prod_id,count(sales) as no_of_products_sold from market_fact
group by prod_id
order by no_of_products_sold desc;
/*11.Display product Id and product sub category whose product category belongs to Furniture and Technlogy*/
select prod_id,product_sub_category from prod_dimen
where product_category='FURNITURE'or product_category='TECHNOLOGY';
/*12.product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)*/
select c.product_category,m.profit 
from market_fact m
inner join prod_dimen c on c.prod_id = m.prod_id
group by c.product_category
order by m.profit desc;
/*13.the product category, product sub-category and the profit within each subcategory in three columns.   */
select c.product_category,c.product_sub_category,m.profit from prod_dimen c 
inner join market_fact m on c.prod_id=m.prod_id
group by c.product_sub_category;
/*14.Display the order date, order quantity and the sales for the order*/
select order_date,order_quantity,sales from orders_dimen,market_fact;
/*15.Display the names of the customers whose name contains the  
       i) Second letter as ‘R’        ii) Fourth letter as ‘D’*/
select customer_name from cust_dimen
where customer_name like '_r%' or customer_name like '___d%';
/*16.make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000*/
select c.cust_id,c.customer_name,c.region,p.sales from cust_dimen c,market_fact p
where c.cust_id=p.cust_id and p.sales between 1000 and 5000 ;
/*17.SQL query to find the 3rd highest sales. */
select sales as 3rd_highest from market_fact
order by sales  desc limit 2,1;
/*18. display the  region-wise no_of_shipments and the  
profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region*/
SELECT c.region, COUNT(distinct s.ship_id) AS no_of_shipments, SUM(m.profit) AS profit_in_each_region
FROM
market_fact m
INNER JOIN
cust_dimen c ON m.cust_id = c.cust_id
INNER JOIN
shipping_dimen s ON m.ship_id = s.ship_id
INNER JOIN
prod_dimen p ON m.prod_id = p.prod_id
WHERE
p.product_sub_category IN (	SELECT p.product_sub_category FROM market_fact m INNER JOIN prod_dimen p ON m.prod_id = p.prod_id
GROUP BY p.product_sub_category HAVING SUM(m.profit) <= ALL
(SELECT SUM(m.profit) AS profits FROM market_fact INNER JOIN prod_dimen p ON m.prod_id = p.prod_id GROUP BY p.product_sub_category))
GROUP BY c.region
ORDER BY profit_in_each_region DESC
