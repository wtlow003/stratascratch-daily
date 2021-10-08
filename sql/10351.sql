/*

Activity Rank
https://platform.stratascratch.com/coding/10351-activity-rank?python=

Difficulty: Hard

Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and their activity rank. Order records by the total emails in descending order. Sort users with the same number of emails in alphabetical order.
In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails.


Tables:
<google_gmail_emails>
id                      int
from_user               varchar
to_user                 varchar
day                     int

*/

-- assumption:
-- clean data
-- all ranks must be unique

-- logic:
-- count total emails sent by each user
-- rank users by the total emails sent
-- break rank by ordering total emails desc, then user_id asc

SELECT from_user,
       COUNT(*) total_emails,
       -- rank by total emails desc, user_id asc
       RANK() OVER(ORDER BY COUNT(*) DESC, from_user ASC) AS activity_rank
FROM google_gmail_emails
GROUP BY 1
