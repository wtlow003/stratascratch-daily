/*

Share of Active User
https://platform.stratascratch.com/coding/2005-share-of-active-users?python=

Difficulty: Medium

Return the share of monthly active users in the United States (US). Active users are the ones with an "open" status in the table.

Tables:
<fb_active_users>
user_id             int
name                varchar
status              varchar
country             varchar

*/


-- objective:
-- find the proportion of active / non-active users in USA

-- logic:
-- find total users (US)
-- find active user (us)
-- active user (us) / total users (US)

SELECT active_users/total_users::float AS active_users_share
FROM (
    SELECT COUNT(user_id) total_users,
           SUM(CASE WHEN status = 'open' THEN 1
                 ELSE 0
                 END) active_users
    FROM fb_active_users
    WHERE country = 'USA'
) usa_user_counts
