/*

Highest Salary In Department
https://platform.stratascratch.com/coding/9897-highest-salary-in-department?python=

Difficulty: Medium

Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.

Tables:
[employee]
id                      int
first_name              varchar
last_name               varchar
age                     int
sex                     varchar
employee_title          varchar
department              varchar
salary                  int
target                  int
bonus                   int
email                   varchar
city                    varchar
address                 varchar
manager_id              int

*/

/*

1. find employee highest salary per department
2. department name, employee first name and salary

*/

SELECT department, first_name, salary
FROM (
    SELECT department,
           first_name,
           salary,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) salary_rank
    FROM employee
    ) AS rank_salary
WHERE salary_rank = 1


