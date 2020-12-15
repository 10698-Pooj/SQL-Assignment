use hr;
show tables;
/*1.to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments  */
select l.location_id,l.street_address,l.city,l.state_province,c.country_name,d.department_name from countries c,locations l 
inner join departments d on l.location_id=d.location_id
group by d.department_name;
/*2.to find the name (first_name, last name), department ID and name of all the employees  */
select concat (e.first_name,e.last_name) as name ,d.department_name,d.department_id from employees e 
join departments d on e.department_id=d.department_id;
/*3.to find the name (first_name, last_name), job, department ID and name of the employees who works in London  */
select concat(e.first_name, ' ',e.last_name) as name,j.job_title as job,e.department_id,d.department_name ,l.city
from jobs j,locations l, employees e 
inner join departments d on e.department_id=d.department_id
where l.city='London';
/*4.to find the employee id, name (last_name) along with their manager_id and name (last_name) */
select employee_id ,last_name,concat(manager_id, '-',last_name) as manager_id_with_name 
from employees;
/*5.query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'  */
select concat(e.first_name, ' ',e.last_name) as name,e.hire_date from employees e
join employees r on (r.last_name='jones')
where r.hire_date< e.hire_date;
/*6.to get the department name and number of employees in the department */
select e.department_name,count(c.department_id) as COUNT
from departments e join employees c on c.department_id=e.department_id
group by e.department_name;
/*7.to display department name, name (first_name, last_name), hire date, salary of the manager for all managers 
whose experience is more than 15 years  */
select concat(first_name,' ',last_name) as Name,hire_date,salary ,(datediff(now(),hire_date))/365 as Experience 
from departments d join employees e on d.manager_id=e.manager_id
where (datediff(now(),hire_date))/365 > 15;
/*8.to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull' */
select concat(first_name,' ',last_name) as Name,salary from employees
where salary >(select salary from employees where last_name='bull');
/*9.to find the name (first_name, last_name) of all employees who works in the IT department  */
select concat(first_name,' ',last_name) as Name from employees e join departments d on e.department_id=d.department_id
where d.department_name='IT' ;
/*10.to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department*/
select concat(first_name,' ',last_name) as Name from employees
where manager_id in(select employee_id from employees where department_id
in
(select department_id from departments where location_id
in
(select location_id from locations where country_id="us")));
/*11.to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary  */
select concat(first_name,' ',last_name) as Name,salary from employees
where salary > (select avg(salary) from employees);
/*12.to find the name (first_name, last_name), and salary of the employees whose salary 
is equal to the minimum salary for their job grade */ 
select concat(first_name,' ',last_name) as Name,salary from employees
where employees.salary = (select min_salary from jobs
where employees.job_id=jobs.job_id);
/*13.to find the name (first_name, last_name), and salary of the employees who earns more than the average salary 
and works in any of the IT departments */
select concat(first_name,last_name) as Name,salary from employees
where department_id in (select department_id from departments where department_name ='IT')
and salary > (select avg(salary) from employees);
/*14.to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments*/
select concat(first_name,last_name),salary,min_salary from employees,jobs
where salary = min_salary;
/*15.to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the 
Shipping Clerk (JOB_ID = 'SH_CLERK'). 
Sort the results of the salary of the lowest to highest */
select first_name,last_name,salary
where job_id in (select job_id='sh_clerk' from jobs )