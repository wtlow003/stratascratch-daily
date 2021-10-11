/*

Distance Per Dollar
https://platform.stratascratch.com/coding/10302-distance-per-dollar?python=

Difficulty: Hard

You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. For each date, find the difference between the distance-per-dollar for that date and the average distance-per-dollar for that year-month. Distance-per-dollar is defined as the distance traveled divided by the cost of the ride.

The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).
You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

Tables:
<uber_request_logs>
request_id                  int
request_date                datetime
request_status              varchar
distance_to_travel          float
monetary_cost               float
driver_to_client_distance   float

*/

-- objective:
-- compare diff between avg distance per dollar for EACH date vs. avg distance per dollar for EACH month that the date is in

-- assumption:
-- distance and cost values applies regardless of `request_status`
-- all dates are unique in the dataset

-- output:
-- 1. year-month
-- 2. ABSOLUTE avg diff in distance per dollar, rounded to 2nd decimal e.g., xx.xx
-- 3. order by earliest request date

-- logic:
-- groupby request_date
-- divide total distance_to_travel / monetary_cost
-- groupby request_date on a yyyy-mm basics
-- divide total distance_to_travel / monetary cost
-- diff unique date's distance-per-dollar - month's distance-per-dollar
-- avg diff distance_per_dollar by yyyy-mm
-- order by earliest request date

-- computing distance-per-dollar on a daily basis
WITH daily_dpd AS (
    SELECT request_date,
           distance_to_travel/monetary_cost::float AS distance_per_dollar
    FROM uber_request_logs
),

-- compute distance-per-dollar on year-month basis
monthly_dpd AS (
    SELECT year_month,
           sum_distance_per_travel/sum_monetary_cost::float as distance_per_dollar
    FROM (
        SELECT LEFT(request_date::varchar, 7) AS year_month,
            SUM(distance_to_travel) AS sum_distance_per_travel,
            SUM(monetary_cost) AS sum_monetary_cost
        FROM uber_request_logs
        GROUP BY 1
    ) AS sum_distance_monetary
),

-- compare the daily dpd vs monthly dpd
-- compute the absolute difference
compare_monthly_daily_dpd AS (
    SELECT request_date,
           ABS(d.distance_per_dollar - m.distance_per_dollar) AS difference
    FROM daily_dpd d
    JOIN monthly_dpd m
        ON LEFT(d.request_date::varchar, 7) = m.year_month
)

-- just find the avg diff distance per dollar for each year-month
SELECT LEFT(request_date::varchar, 7) request_mnth,
       ROUND(AVG(difference)::numeric, 2) difference
FROM compare_monthly_daily_dpd
GROUP BY 1
ORDER BY 1 ASC
