/*

Cities With The Most Expensive Homes
https://platform.stratascratch.com/coding/10315-cities-with-the-most-expensive-homes?python=

Difficulty: Medium

Write a query that identifies cities with higher than average home prices when compared to the national average. Output the city names.

Tables:
<zillow_transactions>
id                  int
state               varchar
city                varchar
street_address      varchar
mkt_price           int

*/

-- logic: we need to find the national average of houses
-- we need to find the average home prices by city for comparison
-- filter for cities that > national average
-- return city names `city`

-- subquery
-- we only need the city name
SELECT city
FROM zillow_transactions
GROUP BY 1
-- agg avg func > the avg nation wide
HAVING AVG(mkt_price) > (
    SELECT AVG(mkt_price)
    FROM zillow_transactions
)
-- just returning back the city in desc order of avg cost
ORDER BY AVG(mkt_price) DESC;
