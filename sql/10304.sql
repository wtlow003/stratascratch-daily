/*

Risky Projects
https://platform.stratascratch.com/coding/10304-risky-projects?python=

Difficult: Medium

Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.
You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K.
Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).

Tables:
<linkedin_projects>
id              int
title           varchar
budget          int
start_date      datetime
end_date        datetime

<linkedin_emp_projects>
emp_id          int
project_id      int

<linkedin_employees>
id              int
first_name      varchar
last_name       varchar
salary          int

*/

-- objective:
-- FIND projects that are at risk of overbudget
-- Overbudget: cost of all emps assigned  > budget of project

-- assumption:
-- not all projects are rated at 1 year, some are less than that
-- need to prorate (salary of emp (cost) must feedback pro-rated rate)
-- pro-rate is by days

-- logic:
-- LEFT JOIN emp_projects, employees ON projects
-- COMPUTE project duration in months
-- SUM(salary) GROUP BY projects.id
-- Pro-rate SUM(salary) based on projects.start_date, projects.end_date
-- ROUND(emp cost) to the next dollar amount

-- output:
-- project name, proj budget, prorated total employee expenses (rounded to next dollar amount)
SELECT project_title,
       project_budget,
       CEILING(emp_costs * (duration/365::float)) total_costs
FROM (
    SELECT title AS project_title,
          budget AS project_budget,
          duration,
          SUM(salary) AS emp_costs
    FROM (
        SELECT p.*,
              p.end_date - p.start_date AS duration,
              ep.emp_id,
              e.salary
        FROM linkedin_projects p
        LEFT JOIN linkedin_emp_projects ep
            ON p.id = ep.project_id
        JOIN linkedin_employees e
            ON ep.emp_id = e.id
    ) proj_infos
    GROUP BY 1, 2, 3
) costs
WHERE emp_costs * (duration/365::float) > project_budget
ORDER BY 1
