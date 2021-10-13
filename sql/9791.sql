/*

Views Per Keyword
https://platform.stratascratch.com/coding/9791-views-per-keyword?python=

Difficulty: Hard

Tables:
<facebook_posts>
post_id                 int
poster                  int
post_text               varchar
post_keywords           varchar
post_date               datetime

facebook_post_views
post_id                 int
viewer_id               int

*/

-- objective:
-- find views each keyword has

-- assumption:
-- 1 post may have many keywords
-- for every single view -> may be attributed to many keywords
-- keywords -> what's the format?

-- logic:
-- btrim '[]' from post_keywords
-- string_to_array() turns string to an array
-- unnest() posts into individual rows with each tagged keywords
-- join the count(views) to each post_id
-- sort by highest views

-- extract keywords
SELECT UNNEST(STRING_TO_ARRAY(BTRIM(p.post_keywords, '[]#'), ',')) AS keywords,
       COALESCE(SUM(view_counts), 0) AS view_counts
FROM facebook_posts p
-- attaching views to each post_id -> keyword as well
LEFT JOIN (
    -- counts views of each post
    SELECT post_id,
           COUNT(*) as view_counts
    FROM facebook_post_views
    GROUP BY 1
) count_views
    ON p.post_id = count_views.post_id
GROUP BY 1
ORDER BY 2 DESC
