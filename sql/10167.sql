/*

Total Number Of Housing Units
https://platform.stratascratch.com/coding/10167-total-number-of-housing-units?python=

Difficulty: Easy

Find the total number of housing units completed for each year. Output the year along with the total number of housings. Order the result by year in ascending order.

Table:
<housing_units_completed_us>
year            int
month           int
south           float
west            float
midwest         float
northeast       float

*/


-- logic:
-- group by year, SUM south west midwest northeast
-- order by year ASC

SELECT year,
       SUM(south + west + midwest + northeast)
FROM housing_units_completed_us
GROUP BY 1
ORDER BY 1 ASC;
