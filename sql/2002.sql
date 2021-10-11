/*

Submission Types
https://platform.stratascratch.com/coding/2002-submission-types?python=

Difficulty: Easy

Write a query that returns the user ID of all users that have created at least one ‘Refinance’ submission and at least one ‘InSchool’ submission.

Tables:
<loans>
id                  int
user_id             int
created_at          datetime
status              varchar
type                varchar

*/

-- objective:
-- find user ID have both `Refinance` and `InSchool` submission

-- assumption:
-- not all user may have that

-- logic:
-- filter user WHERE type = 'refinance' and 'inschool'
-- self join refinance and inschool
-- distinct user_id as user may have submit more thna once for both types of submissions.

SELECT DISTINCT loans.user_id
FROM loans
JOIN (
    SELECT user_id
    FROM loans
    WHERE type = 'Refinance'
) refinance
    ON loans.user_id = refinance.user_id
JOIN (
    SELECT user_id
    FROM loans
    WHERE type = 'InSchool'
) inschool
     ON loans.user_id = inschool.user_id
