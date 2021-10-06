/*

Top 2 Users With Most Calls
https://platform.stratascratch.com/coding/2019-top-2-users-with-most-calls?

Difficulty: Medium

Return the top 2 users in each company that called the most. Output the company_id, user_id, and the user's rank. If there are multiple users in the same rank, keep all of them.

Tables:
<rc_calls>
user_id     int
datedate    time
call_id     int

<rc_users>
user_id     int
status      varchar
company_id  int

*/

-- logic: we need top 2 users that called the most
-- need: a ranking of users, ranking keeps all users with similar profiles

-- get the aggregation (count) of calls by users
WITH user_call_count AS (
    SELECT user_id, COUNT(*) AS call_count
    FROM rc_calls
    GROUP BY user_id
)

-- filter the rank up to top 2 user(s)
SELECT *
FROM (
    -- rank call count by company level for each user
    SELECT rcu.company_id,
           rcu.user_id,
           DENSE_RANK() OVER (PARTITION BY rcu.company_id
                              ORDER BY ucc.call_count DESC) AS rank
    FROM rc_users rcu
    JOIN user_call_count ucc
        ON rcu.user_id = ucc.user_id
) call_count_ranking
WHERE rank <= 2;
