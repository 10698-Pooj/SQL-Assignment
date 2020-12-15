use northwind;
show tables;
/*1.get product name and quantity/unit*/
select ProductName,QuantityPerUnit
from products;
/*2.get current product list*/
select ProductID,ProductName
from products
where Discontinued=0
order by ProductName;
/*3.get discontinued product list*/
select ProductID,ProductName,Discontinued 
from products
where Discontinued=1
order by ProductName;
/*4.get most expense and least expensive Product list (name and unit price) */
select ProductName,UnitPrice
from products
order by UnitPrice desc;
/*5.get Product list (id, name, unit price) where current products cost less than $20 */
select ProductID,ProductName,UnitPrice
from products
where UnitPrice<20 and discontinued=0
order by UnitPrice desc;
/*6.get Product list (id, name, unit price) where products cost between $15 and $25 */
select ProductID,ProductName,UnitPrice
from products
where UnitPrice between 15 and 25;
/*7.get Product list (name, unit price) of above average price */
select ProductName,UnitPrice
from products
where (UnitPrice) > (select avg(UnitPrice) from products)
order by UnitPrice;
/*8.get Product list (name, unit price) of ten most expensive products */
select ProductName,Unitprice
from products
order by UnitPrice desc
limit 10;
/*9.count current and discontinued products */
select count(ProductName)
from products
group by Discontinued;
/*10.get Product list (name, units on order , units in stock) of stock is less than the quantity on order */
select ProductName,UnitsOnOrder,UnitsInStock
from products
where (((Discontinued)=False) and ((UnitsInStock)<UnitsOnOrder));

