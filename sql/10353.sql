/*

Workers With The Highest Salaries
https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?python=

Difficulty: Medium

Find the titles of workers that earn the highest salary. Output the highest-paid title or multiple titles that share the highest salary.

Tables:
<worker>
worker_id               int
first_name              varchar
last_name               varchar
salary                  int
joining_date            datetime
department              varchar

title
worker_ref_id           int
worker_title            varchar
affected_from           datetime

*/

-- logic: join the title and worker table by worker_id and worker_ref_id
-- rank the title by the salary received the worker
-- only return the top-rank salary's title

-- assumption: there can be more than 1 title that share the highest salary
-- dense_rank() might be more appropriate

-- select title only
SELECT worker_title
FROM (
    SELECT t.worker_title,
           w.salary,
           DENSE_RANK() OVER (ORDER BY w.salary DESC) AS rank
    FROM title t
    JOIN worker w
        ON w.worker_id = t.worker_ref_id
) title_rank
-- fitler by the top-salary title given dense_rank()
WHERE title_rank.rank = 1
