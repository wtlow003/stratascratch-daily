/*

Comments Distribution
https://platform.stratascratch.com/coding/10297-comments-distribution?python=

Difficulty: Hard

Write a query to calculate the distribution of comments by the count of users that joined Facebook between 2018 and 2020, for the month of January 2020.

The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. Your left column in the output will be the number of comments while your right column in the output will be the number of users. Sort the output from the least number of comments to highest.

To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result.

Tables:
<fb_users>
id                  int
name                varchar
joined_at           datetime
city_id             int
device              int

<fb_comments>
user_id             int
body                varchar
created_at          datetime

*/

-- objective:
-- find the distribution of no. of comments in Jan 2020

-- assumption:
-- no. of comments might be continuous (e.g. 1, 3, 4, 5, 8...)
-- would not be filling the blanks no. of comments in the range
-- likely there a bug user post date < user join

-- logic:
-- filter for users who join between 2018 and 2020
-- filter comments where in jan 2020
-- filter comments where created_at < joined_at (fix bug)
-- count no. of comments per users -> retrieve the distribution range
-- count users no. of comments -> retrieve the distribution count
-- order by no. of comments ASC

-- join users and comments
WITH count_valid_comments_per_user AS (
    -- count the comments per user
    SELECT c.user_id,
           COUNT(c.*) no_comments
    FROM fb_comments c
    JOIN fb_users u
        ON c.user_id = u.id
    -- filter for both jan 2020 and fix bug
    WHERE (LEFT(c.created_at::varchar, 7) = '2020-01')
        AND (u.joined_at < c.created_at)
        -- filter for user join between 2018 and 2020
        AND EXTRACT('YEAR' FROM u.joined_at) BETWEEN 2018 AND 2020
    GROUP BY 1
)

-- reverse: getting distribution count for each no. comments.
SELECT no_comments,
      COUNT(*)
FROM count_valid_comments_per_user
GROUP BY 1
ORDER BY 1 ASC
