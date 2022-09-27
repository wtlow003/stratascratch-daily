/*

Top 3 Wineries In The World
https://platform.stratascratch.com/coding/10042-top-3-wineries-in-the-world?code_type=10042

Difficulty: Hard

Find the top 3 wineries in each country based on the average points earned. In case there is a tie, order the wineries by winery name in ascending order. Output the country along with the best, second best, and third best wineries. If there is no second winery (NULL value) output 'No second winery' and if there is no third winery output 'No third winery'. For outputting wineries format them like this: "winery (avg_points)"

Tables:
(winemag_p1)
id              int
country         varchar
description     varchar
designation     varchar
points          int
price           float
province        varchar
region_1        varchar
region_2        varchar
variety         varchar
winery          varchar

*/

SELECT country,
       COALESCE(MAX(top_winery), 'No top winery') top_winery,
       COALESCE(MAX(second_winery), 'No second winery') second_winery,
       COALESCE(MAX(third_winery), 'No third winery') third_winery
FROM (
    SELECT country,
            CASE
                WHEN ranking = 1 THEN winery || ' (' || ROUND(avg_points) || ')'
                ELSE NULL
                END
            AS top_winery,
            CASE
                WHEN ranking = 2 THEN winery || ' (' || ROUND(avg_points) || ')'
                ELSE NULL
                END
            AS second_winery,
            CASE
                WHEN ranking = 3 THEN winery || ' (' || ROUND(avg_points) || ')'
                ELSE NULL
                END
            AS third_winery
    FROM (
        -- rank each winery by their avg in each country with the tiebreaker
        SELECT country, 
               winery, 
               avg_points, 
               DENSE_RANK() OVER(PARTITION BY country 
                                 ORDER BY avg_points DESC, winery ASC) ranking
        FROM (
            -- compute the avg points for each winery
            SELECT country, winery, AVG(points) AS avg_points
            FROM winemag_p1
            GROUP BY 1,2
        ) compute_avg_points
    ) rank_wineries
) AS select_top_3_wineries
GROUP BY 1 

