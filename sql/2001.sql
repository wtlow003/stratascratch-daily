/*

Share of Loan Balance
https://platform.stratascratch.com/coding/2001-share-of-loan-balance?python=

Difficulty: Medium

Write a query that returns the rate_type, loan_id and balance of each loan type, and a column that shows what percentage of the submission’s total balance each loan constitutes.

Tables:
<submissions>
id                      int
balance                 float
interest_rate           float
rate_type               varchar
loan_id                 int

*/


-- objective:
-- find the % of each loan on the basis of the overall rate_type's balance

-- assumption:
-- "balance of each loan type" = "balance of each loan(rate_type)"

-- logic:
-- sum(balance) for each rate_type AS total_balance
-- join total_balance on each loan's balance ON rate_type

-- output:
-- rate_type, loan_id, balance, % of the total balance for the specific rate_type
SELECT s.rate_type,
       s.loan_id,
       s.balance,
       -- computing % of balance / total_balance
       (s.balance / rate_balances.total_balance)::float AS pct_total_balance
FROM submissions s
JOIN (
    -- summing balance for each rate_type
    SELECT rate_type,
           SUM(balance) AS total_balance
    FROM submissions
    GROUP BY 1
) rate_balances
    ON s.rate_type = rate_balances.rate_type
ORDER BY 1,3
