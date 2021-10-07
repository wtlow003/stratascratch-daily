/*

Questions in Second Quarter
https://platform.stratascratch.com/coding/2062-questions-in-second-quarter?python=

Difficulty: Medium

How many searches were there in the second quarter of 2021?

Tables:
<fb_searches>
date            datetime
search_id       int
user_id         int
age_group       varchar
search_query    varchar

*/

-- logic: find quarter for date and ensure we are looking into year 2021, simple group by count thereafter

-- we only want the result
SELECT result
FROM (
    -- getting the quarter and group by
    SELECT EXTRACT(QUARTER FROM date), COUNT(*) AS result
    FROM fb_searches
    -- ensure that we are only finding 2nd quarter and year 2021
    WHERE EXTRACT(QUARTER FROM date) = 2 AND EXTRACT(YEAR FROM date) = '2021'
    GROUP BY 1
) count_by_quarter
