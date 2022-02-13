/*

New Products
https://platform.stratascratch.com/coding/10318-new-products?python=

You are given a table of product launches by company by year. 
Write a query to count the net difference between the number of products companies launched in 2020 for the first time with the number of products companies launched in the previous year. Output the name of the companies and a net difference of net products released for 2020 compared to the previous year. If a company is new or had no products in 2019, 
then any product released in 2020 would be considered as new.

Tables:
[car_launches]
year                    int
company_name            varchar
product_name            varchar

*/


/*

1. figure the net dfifference (no. comp in 2020 vs 2019)
2. if company does not exist in 2019, all launched in 2020 is NEW

Potential edge case:
1. exist in 2019 but not in 2020

*/

SELECT company_name,
       SUM(product_2020) - SUM(product_2019) AS net_difference
FROM (
    SELECT company_name,
           (CASE 
                WHEN year = 2019 THEN 1
                ELSE 0
            END) AS product_2019, 
            (CASE 
                WHEN year = 2020 THEN 1
                ELSE 0
            END) AS product_2020
    FROM car_launches
    ) AS product_counts
GROUP BY 1

