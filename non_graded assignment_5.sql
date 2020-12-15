use sample_worker;
show databases;
create table workers(
WORKER_ID int primary key,
FIRST_NAME varchar(25),
LAST_NAME varchar(15),
SALARY decimal(18,2),
JOINING_DATE datetime,
DEPARTMENT varchar(15)
);
insert into workers
values 
(001,'Monika','Arora',100000,'2014-02-20 09:00:00','HR'),
(002,'Niharka','Verma',80000,'2014-06-11 09:00:00','Admin'),
(003,'Vishal','Singhal',300000,'2014-02-20 09:00:00','HR'),
(004,'Amitabh','Singh',500000,'2014-02-20 09:00:00','Admin'),
(005,'Vivek','Bhati',500000,'2014-06-11 09:00:00','Admin'),
(006,'Vipul','diwan',200000,'2014-06-11 09:00:00','Account'),
(007,'Satish','Kumar',75000,'2014-01-20 09:00:00','Account'),
(008,'Geethika','Chauhan',90000,'2014-04-11 09:00:00','Admin');
select*from workers;
/*1.aliasing*/
select FIRST_NAME as WORKER_NAME
from workers;
/*2.uppercase*/
select upper(FIRST_NAME) 
from workers; 
/*3.unique values*/
select distinct DEPARTMENT 
from workers;
/*4.first 3 characters of first name*/
select left(FIRST_NAME,3)
from workers;
/*5.to find the position of the alphabet (‘a’)*/
select position('a'in'Amitabh') as Position;
/*6.print the FIRST_NAME from Worker table after removing white spaces from the right side. */
select rtrim(FIRST_NAME) as FIRST_NAME
from workers;
/*7.print the DEPARTMENT from Worker table after removing white spaces from the left side. */
select ltrim(DEPARTMENT) as DEPARTMENT
from workers;
/*8.the unique values of DEPARTMENT from Worker table and prints its length*/
select distinct DEPARTMENT ,length(DEPARTMENT) as length
from workers;
/*9.to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’*/
select replace(FIRST_NAME,'a','A')
from workers;
/*10.print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME*/
select FIRST_NAME,LAST_NAME, concat(FIRST_NAME, ' ' ,LAST_NAME) as COMPLETE_NAME
from workers;
/*11.to print all Worker details from the Worker table order by FIRST_NAME Ascending*/
select* from workers
order by FIRST_NAME asc;
/*12.print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending*/
select* from workers
order by FIRST_NAME asc, DEPARTMENT desc;
/*13.print details for Workers with the first name as “Vipul” and “Satish” from Worker table*/
select * from workers
where FIRST_NAME = 'Vipul' or  FIRST_NAME = 'Satish';
/*14.print details of workers excluding first names, “Vipul” and “Satish” from Worker table. */
select * from workers
where FIRST_NAME not in ('Vipul','Satish');
/*15.print details of Workers with DEPARTMENT name as “Admin”*/
select* from workers
where DEPARTMENT="Admin";
/* 16.print details of the Workers whose FIRST_NAME contains ‘a’*/
select * from workers
where FIRST_NAME like '%a%';
/*17.print details of the Workers whose FIRST_NAME ends with ‘a’ */
select * from workers
where FIRST_NAME like '%a';
/*18.to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets*/
select * from workers
where FIRST_NAME like '%h' and length(FIRST_NAME)=6;
/*19.print details of the Workers whose SALARY lies between 100000 and 500000*/
select*from workers
where salary between 100000 and 500000;
/*20.to print details of the Workers who have joined in Feb’2014*/
select*,year(JOINING_DATE) as year from workers
where year(JOINING_DATE)=2014;
/*21.fetch the count of employees working in the department ‘Admin’*/
select count(WORKER_ID) as 'count of employees'
from workers
where DEPARTMENT='Admin';
/*22.fetch worker names with salaries >= 50000 and <= 100000*/
select FIRST_NAME,LAST_NAME,SALARY
from workers
where SALARY between 50000 and 100000;
/*23.to fetch the no. of workers for each department in the descending order*/
select WORKER_ID,DEPARTMENT
from workers
order by DEPARTMENT desc;
/*24.to show only odd rows from the table*/
select * from workers
where mod(WORKER_ID,2)<>0;
/*25.show the top 10 records of the table in terms of salary*/
select * from workers
order by SALARY desc
limit 10;
/*26.to fetch the list of employees with the same salary*/
select * from workers
where SALARY in(select SALARY from workers
group by SALARY
having count(*)>1);
/*27.query to show the second highest salary from a table*/
select max(SALARY) as second_highest from workers
where SALARY <(select max(SALARY) from workers);
/*28.fetch the departments that have less than five people in it*/
select DEPARTMENT from workers
group by DEPARTMENT
having count(*)<5;
/*29.to show all departments along with the number of people in there*/
select DEPARTMENT,count(*) as COUNT
from workers
group by DEPARTMENT;
/*30.to show the last record from a table*/
select*from workers
where WORKER_ID=(select max(WORKER_ID)from workers);
