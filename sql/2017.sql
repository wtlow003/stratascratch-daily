/*
Difficulty: Easy
Company: Ring Central

Paid Users In April 2020
How many paid users had any calls in Apr 2020?

Tables:

rc_calls

user_id int
date datetime
call_id int

rc_users

user_id int
status varchar
company_id int
*/

SELECT COUNT(DISTINCT user_id)
FROM rc_calls
WHERE user_id IN (
    SELECT user_id
    FROM rc_users
    WHERE status = 'paid'
) AND DATE_PART('month', date) = 4
