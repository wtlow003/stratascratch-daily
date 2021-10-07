/*

Distances Traveled
https://platform.stratascratch.com/coding/10324-distances-traveled?python=

Difficulty: Hard

Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.

Tables:
<lyft_rides_log>
id              int
user_id         int
distance        int

<lyft_users>
id              int
name            varchar

*/


-- logic: we need find the user and their total distance travelled (sum)
-- group by on a user level
-- assumption: since we are not looking at a value, there might be a tie-breaker that we need to take care of
-- dense_rank() might be a good option

-- we need the id, name and total distance
SELECT lu.id, lu.name, user_distance.traveled_distance
FROM (
    -- this calculates the total travelled distance and compute the ranks of user based on their travelled distance
    SELECT user_id,
           SUM(distance) as traveled_distance,
           DENSE_RANK() OVER (ORDER BY SUM(distance) DESC) AS rank
    FROM lyft_rides_log
    GROUP BY user_id
) AS user_distance
JOIN lyft_users lu
    ON user_distance.user_id = lu.id
-- filter by ranking only top 10
ORDER BY user_distance.traveled_distance DESC
