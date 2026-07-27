/*
====================================================
Project: SQL Joins Practice
Author: Mary Iyanuoluwa Amos
Dataset: Parks and Recreation

Description:
This project contains 30 SQL practice questions completed
while learning SQL using MySQL.

Topics Covered:
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- SELF JOIN
- Multiple Table Joins
- Aggregate Functions
- GROUP BY
- HAVING
- Subqueries
====================================================
*/

-- 1. Return the first name, last name, age, and salary of all employees.

select a.first_name, a.last_name, age, salary
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id;

-- 2. Show all employees together with their occupation.

select a.first_name, a.last_name, occupation
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id;

-- 3. Display employees whose salary is greater than 60,000 along with their gender.

select a.first_name, a.last_name, salary, gender
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id
where salary > 60000;

-- 4. Show the first name, last name, and department ID for employees who exist in both tables.
select a.first_name, a.last_name, dept_id
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id;

-- 5. Find all female employees and display their salaries.
select a.first_name, a.last_name, a.gender, b.salary
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id
where a.gender = 'female';

-- 6. Show all employees from the demographics table, even if they do not have salary information.
select a.first_name, a.last_name, salary
from employee_demographics a
left join employee_salary b
on a.employee_id = b.employee_id;

-- 7. Display all employees and their department IDs, including employees without departments.
select a.first_name, a.last_name, dept_id
from employee_demographics a
left join employee_salary b
on a.employee_id = b.employee_id;

-- 8. Find employees who do not have matching salary records.
select a.first_name, a.last_name
from employee_demographics a
left join employee_salary b
on a.employee_id = b.employee_id
where salary is null;

-- 9. Show all salary records, including employees who may not exist in the demographics table.
select b.first_name, b.last_name
from employee_demographics a
right join employee_salary b
on a.employee_id = b.employee_id;

-- 10. Find salary records that do not have matching demographic information.
select b.employee_id, b.first_name, b.last_name
from employee_demographics a
right join employee_salary b
on a.employee_id = b.employee_id
where a.employee_id is null;

-- 11. Using the employee salary table, pair employees with employees that have higher employee IDs than them.
select a.employee_id id1, a.first_name emp1, b.employee_id id2, b.first_name emp2
from employee_salary a
join employee_salary b
on a.employee_id < b.employee_id;

-- 12. Create a query showing employees and another employee who joined “after” them based on employee ID.
select a.employee_id id1, a.first_name earlier_employee, b.employee_id id2, b.first_name later_employee
from employee_demographics a
join employee_demographics b
on a.employee_id < b.employee_id;

-- 13. Show: employee first name, occupation, department name using all three tables together.
select a.first_name, b.occupation, department_name
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id
join parks_departments c
on b.dept_id = c.department_id;

-- 14. Find all employees working in the “Finance” department.
select a.first_name
from employee_demographics a
join employee_salary b 
on a.employee_id = b.employee_id
join parks_departments c
on b.dept_id = c.department_id
where c.department_name = 'Finance';

-- 15. Display employee names, salaries, and department names sorted by salary from highest to lowest.
select a.first_name, a.last_name, salary, department_name
from employee_demographics a
join employee_salary b
on a.employee_id = b.employee_id
join parks_departments c
on b.dept_id = c.department_id
order by salary desc;

-- 16. Find the average salary by department name.
select department_name, avg(salary)
from employee_salary a
join parks_departments b
on a.dept_id = b.department_id
group by department_name;

-- 17. Show all departments and the employees belonging to them.
select a.first_name, a.last_name, department_name
from employee_salary a 
right join parks_departments b
on a.dept_id = b.department_id;

-- 18. Find the highest paid employee in each department.
select b.department_name, max(salary)
from employee_salary a
right join parks_departments b
on a.dept_id = b.department_id
group by b.department_name;

-- 19. Count how many employees are in each department.
select department_name, count(a.employee_id) no_of_emp
from employee_salary a
right join parks_departments b
on a.dept_id = b.department_id
group by department_name
order by no_of_emp desc;

-- 20. Find departments with average salary above 60,000
select department_name, avg(salary) avg_salary
from employee_salary a
join parks_departments b
on a.dept_id = b.department_id
group by department_name
having avg(salary) > 60000;

-- 21. List employees whose salary is above the company average salary.
select employee_id, first_name, last_name, salary
from employee_salary
where salary > (select avg(salary) from employee_salary);

-- 22. Show each employee’s first name, last name, and their department name.
select a.first_name, a.last_name, department_name
from employee_salary a
left join parks_departments b
on a.dept_id = b.department_id;

-- 23. Find all employees who earn more than 50,000 and show their department name.
select a.first_name, a.last_name, salary, department_name
from employee_salary a
left join parks_departments b
on a.dept_id = b.department_id
where salary > 50000;

-- 24. Display the number of employees in each occupation
select occupation, count(employee_id) No_of_emp
from employee_salary
group by occupation
order by No_of_emp desc;

-- 25. Find the total salary paid in each department.
select a.department_name, sum(salary) total_salary
from parks_departments a
left join employee_salary b
on a.department_id = b.dept_id
group by a.department_name
order by total_salary desc;

-- 26. Show employees who do not belong to any department.
select a.first_name, a.last_name
from employee_salary a
left join parks_departments b
on a.dept_id = b.department_id
where a.dept_id is null;

-- 27. List each department and the highest salary within it.
select a.department_name, max(salary) Highest_salary
from parks_departments a
left join employee_salary b
on a.department_id = b.dept_id
group by a.department_name
order by Highest_salary desc;

-- 28. Show the average salary for each occupation
select occupation, avg(salary) avg_salary
from employee_salary
group by occupation
order by avg_salary desc;

-- 29. Find the department with the lowest average salary.
select min(Avg_salary) Lowest_Avg_Salary
from
(select b.department_name, avg(salary) Avg_Salary
from employee_salary a
right join parks_departments b
on a.dept_id = b.department_id
group by department_name) t;

/* 30. Display all employees along with their department name, 
 but only for departments that contain the letter “e” in their name.*/
select a.first_name, a.last_name, department_name
from employee_salary a
left join parks_departments b
on a.dept_id = b.department_id
where department_name like '%e%';


