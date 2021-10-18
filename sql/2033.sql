/*

Find The Most Profitable Location
https://platform.stratascratch.com/coding/2033-find-the-most-profitable-location?python=

Difficulty: Hard

Find the most profitable location. Write a query that calculates the average signup duration and average revenue for each location, and then compare these two measures together by taking the ratio of the average revenue and average duration for each location.

Your output should include the location, average duration, average revenue, and ratio. Sort your results from highest ratio to lowest.

Tables:
<signups>
signup_id               int
signup_start_date       datetime
signup_stop_date        datetime
plan_id                 int
location                varchar

<transactions>
transaction_id          int
signup_id               int
transaction_start_date  datetime
amt                     float

*/

-- objective:
-- MOST profitable location
-- FIND average signup duration, average to compute ratio

-- logic:
-- COMPUTE avg duration signup_stop_date - signup_start_date
-- AVG(duration) / signup, AVG(amt) / signup per location
-- COMPUTE ratio: avg_revenue / avg_duration
-- ORDER BY ratio

-- output:
-- location, avg_duration, avg_revenue, ratio
-- order by ratio DESC

SELECT DISTINCT location,
       avg_duration,
       avg_revenue,
       avg_revenue/avg_duration::float AS ratio
FROM (
    SELECT s2.location,
           AVG(s2.signup_stop_date - s2.signup_start_date) OVER(PARTITION BY s2.location) AS avg_duration,
           avg_revenue
    FROM signups s2
    JOIN (
        SELECT location,
               AVG(amt) OVER(PARTITION BY location) AS avg_revenue
        FROM transactions t1
        JOIN signups s1
            ON s1.signup_id = t1.signup_id
    ) t2
        ON s2.location = t2.location
) avg_metrics
ORDER BY 4 DESC
