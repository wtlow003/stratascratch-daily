/*

Homework Results
https://platform.stratascratch.com/coding/2075-homework-results?python=

Difficulty: Medium

Given the homework results of a group of students, calculate the average grade and the completion rate of each student. A homework is considered not completed if no grade has been assigned.
Output first name of a student, their average grade, and completion rate in percentages. Note that it's possible for several students to have the same first name but their results should still be shown separately.

Tables:
<allstate_homework>
student_id              int
homework_id             int
grade                   float

<allstate_students>
student_id              int
student_firstname       varchar
student_lastname        varchar

*/

-- problem:
-- 1. compute avg grade and completion rate for each student

-- constraint:
-- 1. student may share the same first name (we need consider last name)
-- 2. no grade = non-completion

-- output:
-- student_firstname, avg_grade, completion_rate (in %)

-- logic:
-- 1. compute completion rate, if grade = NULL, then complete = 0, else 1
-- 2. compute average grade = AVG(grade)
-- 3. output alongside the first name join to allstate_students

-- #1 compute completion rate
WITH completion_rate AS (
    SELECT student_id,
           -- ensure in percentage
           AVG(completion) * 100 AS completion_rate
    FROM (
        SELECT student_id,
               CASE
                    WHEN grade IS NULL THEN 0
                    ELSE 1
                END AS completion
        FROM allstate_homework
    ) AS completion_check
    GROUP BY 1
),

-- #2 compute average grade
average_grade AS (
    SELECT student_id,
           -- if student has not complete anything
           -- the grades is 0
           -- check assumption with interviewer
           AVG(grade) AS avg_grade
    FROM allstate_homework
    GROUP BY 1
)

-- #3 output
SELECT s.student_firstname,
       ag.avg_grade,
       cr.completion_rate
FROM allstate_students s
JOIN average_grade ag
    ON s.student_id = ag.student_id
JOIN completion_rate cr
    ON s.student_id = cr.student_id
