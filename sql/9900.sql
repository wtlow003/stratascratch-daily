/*

Median Salary
https://platform.stratascratch.com/coding/9900-median-salary?python=

Difficulty: Hard

Find the median employee salary of each department.
Output the department name along with the corresponding salary rounded to the nearest whole dollar.

Tables:
employee
id                  int
first_name          varchar
last_name           varchar
age                 int
sex                 varchar
employee_title      varchar
department          varchar
salary              int
target              int
bonus               int
email               varchar
city                varchar
address             varchar
manager_id          int

*/

-- objective:
-- find median salary aggregated by department

-- logic:
-- PERCENTILE_CONT(0.5) for all salary per department
-- ROUND(median salary)

-- output:
-- department, median salary

SELECT department,
       PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY salary)
FROM employee
GROUP BY 1
