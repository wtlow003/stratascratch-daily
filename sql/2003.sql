/*

Recent Refinance Submissions
https://platform.stratascratch.com/coding/2003-recent-refinance-submissions?python=

Difficulty: Medium

Write a query that joins this submissions table to the loans table and returns the total loan balance on each user’s most recent ‘Refinance’ submission. Return all users and the balance for each of them.

Tables:
<loans>
id              int
user_id         int
created_at      datetime
status          varchar
type            varchar

<submissions>
id              int
balance         float
interest_rate   float
rate_type       varchar
loan_id         int

*/

-- objective:
-- 1. total loan balance on the most RECENT 'Refinance' submission
-- 2. Return all users and balance

-- assumption:
-- not all users have make the first payment for the 'Refinance submission'
-- status should be 'offer_accepted' -> means they start the loan already

-- logic:
-- need latest date on 'refinance' for each user
-- retrieve loan_id and user_id
-- join submission on loan_id and user_id

-- getting user_id and balance
SELECT latest_refinance.user_id,
       balance
FROM (
    -- for each loan submission, we want see the date vs the latest submission date for Refinance
    SELECT DISTINCT user_id,
           created_at,
           id,
           MAX(created_at) OVER(PARTITION BY user_id) AS latest_date
    FROM loans
    WHERE type = 'Refinance'
) latest_refinance
JOIN submissions s
    ON latest_refinance.id = s.loan_id
-- ensure that the latest refinance submission is observed
WHERE latest_refinance.created_at = latest_refinance.latest_date
