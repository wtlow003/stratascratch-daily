/*

User Growth Rate
https://platform.stratascratch.com/coding/2052-user-growth-rate?python=

Difficulty: Medium

Find the growth rate of active users for Dec 2020 to Jan 2021 for each account. The growth rate is defined as the number of users in January 2021 divided by the number of users in Dec 2020. Output the account_id and growth rate.

Tables:
<sf_events>
date                datetime
account_id          varchar
user_id             varchar

*/

-- logic: we need count users across two time period for each account_id
-- assumption: all users present are counted as active

-- growth rate: (after distinct users / before distinct users)
SELECT b.account_id, a.distinct_users/ b.distinct_users::float AS growth_rate
-- counting the distinct users before
FROM (
    SELECT account_id, COUNT(DISTINCT user_id) as distinct_users
    FROM sf_events
    -- getting the year-month
    WHERE LEFT(date::varchar, 7) = '2020-12'
    GROUP BY 1
) b
-- counting the distinct users after
JOIN (
    SELECT account_id, COUNT(DISTINCT user_id) as distinct_users
    FROM sf_events
    -- getting the year-month
    WHERE LEFT(date::varchar, 7) = '2021-01'
    GROUP BY 1
) a
ON b.account_id = a.account_id
