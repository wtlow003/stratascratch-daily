/*
Difficulty: Easy
Company: Microsoft

Unique Users Per Client Per Month
Write a query that returns the number of unique users per client per month

Tables:

fact_events

id int
time_id datetime
user_id varchar
customer_id varchar
client_id varchar
event_type varchar
event_id int
*/

SELECT client_id, DATE_PART('month', time_id), COUNT(DISTINCT user_id)
FROM fact_events
GROUP BY 1, 2
