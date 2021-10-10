/*

Most Active Users On Messenger
https://platform.stratascratch.com/coding/10295-most-active-users-on-messenger?python=

Difficulty: Medium

Facebook Messenger stores the number of messages between users in a table named 'fb_messages'. In this table 'user1' is the sender, 'user2' is the receiver, and 'msg_count' is the number of messages exchanged between them.
Find the top 10 most active users on Facebook Messenger by counting their total number of messages sent and received. Your solution should output usernames and the count of the total messages they sent or received

Tables:
<fb_messages>
id                  int
date                datetime
user1               varchar
user2               varchar
msg_count           int

*/

-- objective:
-- find the top 10 active users based on total number of message sent and received
-- output:
-- username (user1 or user2), total interactions

-- assumption:
-- there is a possiblity of users only receiving messages
-- or only sending messages
-- so we need a set of distinct users name

-- find all the distint usernames
WITH distinct_users AS (
    SELECT *
    FROM (
        SELECT user1 AS username
        FROM fb_messages
        -- select distinct records
        UNION
        SELECT user2 AS username
        FROM fb_messages
    ) distinct_username
),

-- for all unique users, find their total sum of message sent and received
interaction_counts AS (
    SELECT du.username,
           message_sent,
           message_received,
           COALESCE(message_sent, 0) + COALESCE(message_received, 0) AS total_interaction
    FROM distinct_users du
    LEFT JOIN (
        SELECT user1, SUM(msg_count) AS message_sent
        FROM fb_messages
        GROUP BY 1
    ) msg_sent
        ON du.username = msg_sent.user1
    LEFT JOIN (
        SELECT user2, SUM(msg_count) AS message_received
        FROM fb_messages
        GROUP BY 1
    ) msg_received
        ON du.username = msg_received.user2
)

-- we rank each user based on their total_msg_count
-- and select only the top 10
SELECT username, total_interaction AS total_msg_count
FROM (
    SELECT username,
           total_interaction,
           RANK() OVER(ORDER BY total_interaction DESC) AS interaction_rank
    FROM interaction_counts
) interaction_ranking
WHERE interaction_rank < 11
