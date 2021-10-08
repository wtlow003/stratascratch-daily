/*


Rank Variance Per Country
https://platform.stratascratch.com/coding/2007-rank-variance-per-country?python&utm_source=youtube&utm_medium=click&utm_campaign=YT+description+link

Difficulty: Hard

Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.

Tables:
<fb_comments_count>
user_id                 int
created_at              datetime
number_of_comments      int

<fb_active_users>
user_id                 int
name                    varchar
status                  varchar
country                 varchar

*/

-- logic: rank countries in dec 2019 and jan 2020 seperately
-- join by country
-- compare former and latter rank
-- filter country where latter rank < former rank

-- assumption: earlier period might not have comments
-- hence we need to right join on latter summary
-- we need 1,2,3,4 no gaps in rank so dense_rank()

-- ranking summary for dec 2019
WITH dec_2019_rank AS (
    SELECT u.country,
           COUNT(*) AS no_comments,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM fb_comments_count c
    JOIN fb_active_users u
        ON c.user_id = u.user_id
    WHERE LEFT(c.created_at::varchar, 7) = '2019-12'
    GROUP BY 1
),

-- ranking summary jan 2020
jan_2020_rank AS (
    SELECT u.country,
           COUNT(*) AS no_comments,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM fb_comments_count c
    JOIN fb_active_users u
        ON c.user_id = u.user_id
    WHERE LEFT(c.created_at::varchar, 7) = '2020-01'
    GROUP BY 1
)

SELECT j.country
FROM dec_2019_rank d
RIGHT JOIN jan_2020_rank j
    ON d.country = j.country
-- filter by either earlier period is null (0 comments, so latter period with comments will boost ranking regardless) or latter rank < former rank
WHERE (j.rank < d.rank) OR d.rank IS NULL;
