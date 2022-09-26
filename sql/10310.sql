/*

Class Performance
https://platform.stratascratch.com/coding/10310-class-performance?code_type=10310

Difficulty: Medium


You are given a table containing assignment scores of students in a class. Write a query that identifies the largest difference in total score  of all assignments.
Output just the difference in total score (sum of all 3 assignments) between a student with the highest score and a student with the lowest score.

Tables:
(box_scores)
id          int
student     varchar
assignment1 int
assignment2 int
assignment3 int

*/

WITH total_scores AS (
    SELECT student, SUM(score) AS total_score
    FROM (
        SELECT student, assignment1 AS score
        FROM box_scores
        UNION
        SELECT student, assignment2 AS score
        FROM box_scores
        UNION
        SELECT student, assignment3 AS score
        FROM box_scores
    ) AS total_scores
    GROUP BY 1
)

SELECT MAX(total_score) - MIN(total_score) AS difference_in_score
FROM total_scores
