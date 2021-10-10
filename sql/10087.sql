/*

Find all posts which were reacted to with a heart
https://platform.stratascratch.com/coding/10087-find-all-posts-which-were-reacted-to-with-a-heart?python=

Difficulty: Medium

Find all posts which were reacted to with a heart.

Tables:
<facebook_reactions>
poster                  int
friend                  int
reaction                varchar
date_day                int
post_id                 int

<facebook_posts>
post_id                 int
poster                  int
post_text               varchar
post_keywords           varchar
post_date               datetime

*/

-- objective:
-- find post that has has reaction="heart"

-- assumption:
-- post can have many reactions, but we just need "heart"
-- one post can have many hearts by different users
-- we just need distinct post_id

-- logic:
-- find reaction='heart'
-- find the post_id that associates with it
-- filter the post is in the post_id

-- select all details about the post
SELECT *
FROM facebook_posts fp
WHERE fp.post_id IN (
    -- find reaction='heart'
    SELECT DISTINCT post_id
    FROM facebook_reactions
    WHERE reaction='heart'
)
