/*

Finding User Purchases
https://platform.stratascratch.com/coding/10322-finding-user-purchases?python=

Difficulty: Medium

Write a query that'll identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.

Tables:
<amazon_transactions>
id                      int
user_id                 int
item                    varchar
created_at              datetime
revenue                 int

*/


-- we need identify RETURNING ACTIVE USERS
-- RETURNING: make a 2nd purchase within 7 days

-- we only need user_id
SELECT DISTINCT(p.user_id)
FROM amazon_transactions p
JOIN amazon_transactions n
    ON p.user_id = n.user_id
    -- we do not need compare two same purchase
WHERE p.id <> n.id
    -- calculate the difference between two purchase dates
    AND DATEDIFF(n.created_at, p.created_at) BETWEEN 0 AND 7

