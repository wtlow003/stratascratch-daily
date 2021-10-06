/*

Manager of the Largest Department
https://platform.stratascratch.com/coding/2060-manager-of-the-largest-department?python=

Difficulty: Medium

Given a list of a company's employees, find the name of the manager from the largest department. Output their first and last name.

Table:
<az_employees>
id                  int
first_name          varchar
last_name           varchar
department_id       int
department_name     varchar
position            varchar

*/

-- logic: count employees per department, filter for manager
-- assumption: manager is counted as one of the employee, manager can be either 'Manager' or 'Interim Manager'

-- filter for top-ranked department and select manager name
SELECT az.first_name, az.last_name
FROM (
    -- rank department by employee count
    SELECT department_id,
           employee_count,
           DENSE_RANK() OVER (ORDER BY employee_count DESC) AS rank
    FROM (
        SELECT department_id,
        COUNT(*) AS employee_count
        FROM az_employees
        GROUP BY department_id
    ) no_employees_by_department
) employee_count_rank
JOIN az_employees az
ON az.department_id = employee_count_rank.department_id
-- filter for top rank department and either manager position
WHERE employee_count_rank.rank = 1 AND az.position ILIKE '%manager%';
