/*

Spam Posts
https://platform.stratascratch.com/coding/10134-spam-posts?python=

Difficulty: Medium

Calculate the percentage of spam posts in all viewed posts by day. Note that the facebook_posts table stores all posts posted by users. The facebook_post_views table is an action table denoting if a user has viewed a post.

Tables:
<facebook_posts>
post_id                 int
poster                  int
post_text               varchar
post_keywords           varchar
post_date               datetime

<facebook_post_views>
post_id                 int
viewer_id               int

*/

-- objective:
-- % spam post in all VIEWED post by day

-- logic:
-- RIGHT join facebook_posts on facebook_post_views
-- count viewed post by day, count "spam" viewed post by day
-- JOIN on day -> get post by day, "spam" viewed post by day
-- compute percentage of spam post / total viewed post

WITH viewed_posts AS (
    SELECT p.post_id,
           p.post_keywords,
           p.post_date,
           pv.viewer_id
    FROM facebook_posts p
    RIGHT JOIN facebook_post_views pv
    ON p.post_id = pv.post_id
),

post_counts AS (
    SELECT a.post_date,
           COUNT(*) OVER(PARTITION BY a.post_date) AS total_views,
           b.spam_views
    FROM viewed_posts a
    JOIN (
        SELECT b.post_date,
               COUNT(*) AS spam_views
        FROM viewed_posts b
        WHERE post_keywords = '[#spam#]'
        GROUP BY 1
    ) b
        ON a.post_date = b.post_date
)

SELECT DISTINCT post_date,
       spam_views/total_views::float * 100 AS spam_share
FROM post_counts
