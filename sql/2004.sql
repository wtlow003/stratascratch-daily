/*

Number of Comments Per User in Past 30 days
https://platform.stratascratch.com/coding/2004-number-of-comments-per-user-in-past-30-days?python=

Difficulty: Easy

Return the total number of comments received for each user in the last 30 days. Assume today is 2020-02-10.

Tables:
<fb_comments_count>
user_id             int
created_at          datetime
number_of_comments  int

*/

-- objective:
-- count number of comments per user in the last 30 days 2020-02-10 - 30 days

SELECT user_id,
       SUM(number_of_comments)
FROM fb_comments_count
-- date conversion
WHERE created_at BETWEEN '2020-02-10'::date - 30 * INTERVAL '1 DAY' AND '2020-02-10'::date
GROUP BY 1
