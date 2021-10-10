/*

Bikes Last Used
https://platform.stratascratch.com/coding/10176-bikes-last-used?python=

Difficulty: Easy

Find the last time each bike was in use. Output both the bike number and the date-timestamp of the bike's last use (i.e., the date-time the bike was returned). Order the results by bikes that were most recently used.

Tables:
<dc_bikeshare_q1_2012>
duration                    varchar
duration_seconds            int
start_time                  datetime
start_station               varchar
start_terminal              int
end_time                    datetime
end_station                 varchar
end_terminal                int
bike_number                 varchar
rider_type                  varchar
id                          int

*/


-- objective: for each bike, we want to find the last time it was used
-- output: bike_number, end_time
-- sequence: end_time DESC (latest)

-- assumption: all bikes are returned, no bikes are still in used (no end_time yet)

-- logic:
-- group by bike_number
-- rank() end_time DESC
-- take the top-rank (latest end time)

-- group by bike_number find the latest end_time
SELECT bike_number,
      end_time
FROM (
    SELECT bike_number,
          end_time,
          RANK() OVER(PARTITION BY bike_number ORDER BY end_time DESC) last_time_used_rank
    FROM dc_bikeshare_q1_2012
) end_time_rank
-- getting the latest end time
WHERE last_time_used_rank = 1
ORDER BY end_time DESC;

-- simpler solution
SELECT bike_number,
       MAX(end_time) AS latest_use_time
FROM dc_bikeshare_q1_2012
GROUP BY 1
ORDER BY 2 DESC
