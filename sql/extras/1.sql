/*

Following question is extracted from `Ace the Data Science Interview`.

Difficulty: Easy

Assume you have the below events table on app analytics. Write a query to get the clickthrough rate per app in 2019.

Tables:
(events)
app_id          int
event_id        varchar
timestamp       datetime

*/

-- clickthrough can be defined as (click/impression)

SELECT app_id,
       SUM(IF(event_id = 'click'), 1, 0) / SUM(IF(event_id = 'impression'), 1, 0) AS ctr
FROM events
WHERE EXTRACT(YEAR from timestamp) = 2019
GROUP BY app_id
