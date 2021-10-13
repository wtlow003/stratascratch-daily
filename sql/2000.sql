/*

Variable vs Fixed Rates
https://platform.stratascratch.com/coding/2000-variable-vs-fixed-rates?python=

Difficulty: Medium

Write a query that returns binary description of rate type per loan_id. The results should have one row per loan_id and two columns: for fixed and variable type.

Table:
<submissions>
id                  int
balance             float
interest_rate       float
rate_type           varchar
loan_id             int

*/


-- objective:
-- true/false for variable and fixed per load_id

-- assumption:
-- binary description = 0/1

-- logic:
-- self join on loan_id to get two columns of rate_type
-- case when to insert 0/1 for both variable and fixed columns

SELECT a.loan_id,
       CASE
           WHEN a.rate_type = 'variable'
           THEN 1
           ELSE 0 END AS variable,
       CASE
           WHEN b.rate_type = 'fixed'
           THEN 1
           ELSE 0 END as fixed
FROM submissions a
JOIN submissions b
    ON a.loan_id = b.loan_id
