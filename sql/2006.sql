/*

Users Activity Per Month Day
https://platform.stratascratch.com/coding/2006-users-activity-per-month-day?python=

Difficulty: Easy

Return a distribution of users activity per day of the month

Table:
<facebook_posts>
post_id                 int
poster                  int
post_text               varchar
post_keywords           varchar
post_date               datetime

*/

-- objective:
-- select user activity per day of the month

-- logic
-- groupby day of month
-- count users

SELECT EXTRACT('day' FROM post_date) AS dom,
       COUNT(*)
FROM facebook_posts
GROUP BY 1
