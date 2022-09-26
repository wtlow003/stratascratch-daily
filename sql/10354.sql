/*

Most Profitable Companies
https://platform.stratascratch.com/coding/10354-most-profitable-companies?code_type=10354

Difficulty: Medium

Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.

Tables:
(forbes_global_2010_2014)
company         varchar
sector          varchar
industry        varchar
continent       varchar
country         varchar
marketvalue     float
sales           float
profits         float
assets          float
rank            int
forbeswebpage   varchar

*/

SELECT company, profits
FROM (
    SELECT company, 
           profits, 
           RANK() OVER(ORDER BY profits DESC) AS profits_rank
    FROM forbes_global_2010_2014
) AS rank_profits
ORDER BY profits_rank
LIMIT 3

