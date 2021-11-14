/*

Player with Longest Streak
https://platform.stratascratch.com/coding/2059-player-with-longest-streak?python=

Difficulty: Hard

You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak.


Tables:
<players_results>
player_id           int
match_date          datetime
match_result        varchar

*/

-- logic:
-- 1. combined all results into a single string
-- 2. break string into individual streaks delimited by 'L' (only keep track of consecutive wins)
-- 3. break strings in array into individual rows
-- 4. replace all agg delimiter into ''
-- 5. count the number of Ws for each valid winning streak
-- 6. rank each streak by the player
-- 7. select top ranked streak

WITH result_seqs AS (
    SELECT player_id,
           STRING_AGG(match_result, ',') AS result_seq
    FROM players_results
    GROUP BY player_id
),

retrieve_w AS (
    SELECT player_id,
           LENGTH(REPLACE(result_seq, ',', '')) AS winning_streak
    FROM (
        SELECT player_id,
               UNNEST(STRING_TO_ARRAY(result_seq, 'L')) AS result_seq
        FROM result_seqs
        ) AS retrieve_w_only
)

SELECT player_id,
       winning_streak
FROM (
    SELECT player_id,
           winning_streak,
           RANK() OVER(ORDER BY winning_streak DESC) AS streak_rank
    FROM retrieve_w
) rank_w_streak
WHERE streak_rank = 1
