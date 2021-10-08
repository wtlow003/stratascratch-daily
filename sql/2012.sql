/*

Viewers Turned Streamers
https://platform.stratascratch.com/coding/2012-viewers-turned-streamers

Difficulty: Hard

From users who had their first session as a viewer, how many streamer sessions have they had? Return the user id and number of sessions in descending order. In case there are users with the same number of sessions, order them by ascending user id.

Tables:
<twitch_sessions<
user_id                     int
session_start               datetime
session_end                 datetime
session_id                  int
session_type                varchar

*/

-- assumption:
-- data is clean
-- session_type is either 'viewer' or 'streamer'
-- each session must end first before another occurs, hence each row is a complete session by its own

-- logic:
-- rank each user's session by date (earliest is number 1)
-- filter for user whose first session_type = 'viewer'
-- count users with session_type = 'streamer'
-- order by num_session desc asc user id

-- count the number of session_type 'streamer'
-- if there is, means they turn into streamers
SELECT user_id,
       COUNT(*)
FROM twitch_sessions
WHERE user_id IN (
    -- we want to select the first event
    SELECT user_id
    FROM (
        -- ranking of sessions for users
        -- asc order of time
        SELECT user_id,
               session_type,
               RANK() OVER(PARTITION BY user_id ORDER BY session_start ASC) session_order
        FROM twitch_sessions
    ) session_orders
    -- filter user whose first session_type = 'viewer'
    WHERE session_order = 1
        AND session_type = 'viewer'
) AND session_type = 'streamer'
GROUP BY 1
-- order by asc user id
ORDER BY 2 DESC, 1 ASC
