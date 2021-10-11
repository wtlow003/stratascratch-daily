/*

Expensive Projects
https://platform.stratascratch.com/coding/10301-expensive-projects?python=

Difficulty: Medium

Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee . The output should include the project title and the project budget per employee as an integer. Order your list by projects with the highest budget per employee first.

Tables:
<ms_projects>
id                  int
title               varchar
budget              int

<ms_emp_projects>
emp_id              int
project_id          int

*/

-- objective:
-- calculate the amount of budget to each employee

-- assumption:
-- one employee may have multiple project budgets

-- output:
-- project title, project budget per employee

-- logic:
-- count number of employee per budget
-- compute budget / no. employees
-- order budget/employee DESC

-- calculate the budget/employee
SELECT title,
       budget/no_employees::integer budget_per_emp
FROM (
    -- join the two tables first
    -- this will result in duplicates
    SELECT DISTINCT title,
           budget,
           -- find the total employee per project
           COUNT(*) OVER(PARTITION BY title) no_employees
    FROM ms_projects
    JOIN ms_emp_projects
        ON ms_projects.id = ms_emp_projects.project_id
) budget_emps
-- sort them by desc order
ORDER BY 2 DESC
