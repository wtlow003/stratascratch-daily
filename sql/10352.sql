/*

Users By Avg Session time
https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?python=

Difficulty: Medium

Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume an user has only 1 session per day and if there are multiple of the same events in that day, consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.

Tables:
<facebook_web_log>
user_id                 int
timestamp               datetime
action                  varchar

*/

-- logic: we need to look at each date session
-- what is the user first and last timing for the session
-- we need calculate the time difference
-- assumption: user have 1 session per day
-- consider the latest page_load and earliest_page exit
-- are we looking at minutes or seconds?

-- finding the latest page_load by user on a given day of the year
WITH latest_page_load AS (
    SELECT user_id, DATE_PART('doy', timestamp) as doy, MAX(timestamp) as latest_timestamp
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY 1, 2
),

-- find the earliest page_exit by a user on a given day of the year
earliest_page_exit AS (
    SELECT user_id, DATE_PART('doy', timestamp) as doy, MIN(timestamp) as latest_timestamp
    FROM facebook_web_log
    WHERE action = 'page_exit'
    GROUP BY 1, 2
),

-- calculate the difference between the page_exit time - page_load time
time_difference AS (
    SELECT pl.user_id, pe.latest_timestamp - pl.latest_timestamp AS time_difference
    FROM latest_page_load pl
    JOIN earliest_page_exit pe
        ON pl.user_id = pe.user_id
        AND pl.doy = pe.doy
)

-- calcuating the avg by user
SELECT user_id, AVG(time_difference) AS avg
FROM time_difference
GROUP BY 1
