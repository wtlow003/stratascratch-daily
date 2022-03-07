/*

User Email Labels
https://platform.stratascratch.com/coding/10068-user-email-labels?python=

Difficulty: Medium

Find the number of emails received by each user under each built-in email label. The email labels are: 'Promotion', 'Social', and 'Shopping'. Output the user along with the number of promotion, social, and shopping mails count,.

Tables:
(google_gmail_emails)
id                      int
from_user               varchar
to_user                 varchar
day                     int
(google_gmail_labels)
email_id                int
label                   varchar

*/


-- we need count for each user, 'promotion', 'social' and 'shopping' tags
-- users are the user that RECEVIED

SELECT to_user,
       SUM(CASE WHEN label = 'Promotion' THEN 1
           ELSE 0
           END) AS promo_cnt,
       SUM(CASE WHEN label = 'Social' THEN 1
           ELSE 0
           END) AS soc_cnt,
       SUM(CASE WHEN label = 'Shopping' THEN 1
           ELSE 0
           END) AS shop_cnt
FROM google_gmail_emails e
JOIN google_gmail_labels l
    ON e.id = l.email_id
GROUP BY 1
ORDER BY 1
