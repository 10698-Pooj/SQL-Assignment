use hr;
show tables;
/*1.aliasing of first_name and last_name*/
select
first_name,last_name,
first_name as FirstName,
last_name as LastName
from employees;
/*2.department_id from employees table*/
select  distinct(department_id) from employees;
/*3.employees details with first_name in desc*/
select
*from employees
order by first_name desc;
/*4.details of employees with calculated PF*/
select
first_name, last_name,salary,salary*.15 PF
from employees;
/*5.employee details in ascending order*/
select employee_id,first_name,last_name,salary
from employees
order by salary asc;
/*6.total salaries payable to employees*/
select sum(salary) 
from employees;
/*7.max and min salary from employees*/
select max(salary),min(salary)
from employees;
/*8.avg salary and no.of employees*/
select avg(salary),count(employee_id)
from employees;
/*9. no.of emloyees working with company*/
select count(employee_id)
from employees;
/*10.no.of jobs available in employee table*/
select count(distinct(job_id))as job_availablity
from employees;
/*11.firstname as uppercase from employee table*/
select 
upper(first_name)
from employees;
/*12.first 3 characters of first name from employees table*/
select substring(first_name,1,3)
from employees;
/*13.remove white space first_name */
select trim(first_name) as first_name
from employees;
/*14.length of employee name*/
select first_name, last_name,length(first_name),length(last_name),length(first_name)+length(last_name)as"total length"
from employees;
/*15.first_name field does not contain any numbers*/
select first_name 
from employees 
where first_name 
like '%[0-9]%';
/*16.display employee name and salary not in range of 10000-150000*/
select first_name,last_name,salary
from employees
where salary not between 10000 and 15000;
/*17.display employee names with department 30 or 100*/
select first_name,last_name,department_id
from employees
where department_id in(30,100)
order by department_id asc;
/*18.display employee names with salary range and department 30 or 100*/
select first_name,last_name,salary,department_id
from employees
where salary not between 10000 and 15000 and department_id in(30,100);
/*19.display name and hire date from employee tables who hired in 1987*/
select first_name ,last_name,hire_date
from employees
where hire_date like'%1987%';
/*20.display first_name who have b and c in their names*/
select first_name
from employees
where first_name like '%b%'and first_name like'%c%';
/*21.display last_name,job,Salary with constraints*/
select  last_name,job_title,salary from employees,jobs
where job_title in('Programmer','Shipping Clerk') and salary not in (4500,10000,15000);
/*22.display last_name whose name have exactly 6 character*/
select last_name
from employees
where length(last_name)=6;
/*23.display last_name whose 3rd character is 'e'*/
select last_name
from employees
where last_name like '__e%';
/*24.job_id and employee_id with partial output*/
select job_id,group_concat(employee_id,'')'Employees_id'
from employees group by job_id;
/*25.to update portion of ph.no in employee table */
update employees set phone_number=replace(phone_number,'124','999')
where phone_number like'%124%';
/*26.get first_name length is >=8*/
select *, first_name 
from employees
where length(first_name) >= 8;
/*27. append @example.com to email id*/
select 
concat(email,'@example.com')as email_id
from employees;
/*28.extract last 4 characters of ph.no*/
select phone_number,
right(phone_number,4) as last_4digits
from employees;
/*29extract last word of street address*/
select street_address,
SUBSTRING_INDEX(street_address, ' ',-1) as last_word
from locations;
/*30.locations that have min street_length*/
select *
from locations
where length(street_address) <=(select min(length(street_address)) 
FROM locations);
/*31.first word from job*/
select job_title,SUBSTRING_INDEX(job_title,' ',1) as first_word
from jobs;
/*32.length of first-name and last _name with c after 2nd position*/
select first_name,last_name,length(first_name)as length
from employees
where last_name like '__c%';
/*33.display the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'*/
select first_name,length(first_name) as length
from employees
where first_name like'A%'or first_name like'J%'or first_name like'M%'
order by first_name;
/*34.display first name and salary and Format the salary to be 10 characters long, left-padded with the $ symbol*/
select first_name,lpad(salary,10,'$') as SALARY
from employees;
/*35.display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign*/
select substring(first_name,1,8) as first_8words,lpad('',salary/1000+1,'$') as salary
from employees
order by salary desc;
/*36.display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year */
select employee_id,first_name,last_name,hire_date,
day(hire_date)as day,month(hire_date)as month
from employees
where day(hire_date)=7 or month(hire_date)=7;