/*

Most Profitable Companies
https://platform.stratascratch.com/coding/9680-most-profitable-companies?python=

Difficulty: Hard

Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.

Tables:
forbes_global_2010_2014
company             varchar
sector              varchar
industry            varchar
continent           varchar
country             varchar
marketvalue         float
sales               float
profits             float
assets              float
rank                int
forbeswebpage       varchar

*/

-- objective:
-- FIND TOP 3 most profitable companies

-- assumption:
-- company can have same profits

-- output:
-- company name, profits
-- ORDER BY profits DESC

SELECT company,
       profits
FROM (
    SELECT company,
           profits,
           DENSE_RANK() OVER(ORDER BY profits DESC) profit_rank
    FROM forbes_global_2010_2014
) rank_profits
WHERE profit_rank <= 3
