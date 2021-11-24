/*

Inactive Free Users
https://platform.stratascratch.com/coding/2018-inactive-free-users?python=

Difficulty: Easy

Return a list of users with status free who didn’t make any calls in Apr 2020.

Table:
<rc_calls>
user_id         int
date            datetime
call_id         int

<rc_users>
user_id         int
status          varchar
company_id      int

*/


-- logic:
-- filter status = 'free'
-- filter list of users in who made call in Apr 2020
-- find all users and return users who have not made a call in 2020


SELECT user_id
FROM rc_users
WHERE status = 'free'
    -- free user should not have made a call in apr 2020
    AND user_id NOT IN (
        -- users who made call in apr 2020
        SELECT DISTINCT user_id
        FROM rc_calls
        WHERE DATE_PART('year', date) = '2020'
            AND DATE_PART('month', date) = '04'
    )
