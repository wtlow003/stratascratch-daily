/*

City with Most Customers
https://platform.stratascratch.com/coding/2079-city-with-most-customers?python=

Difficulty: Medium

For each city, find the number of rides in August 2021 that were not paid for using promotional codes. 
Output the city or cities where this number was the highest.

Tables:
(lyft_orders)
order_id                int
customer_id             varchar
driver_id               varchar
country                 varchar
city                    varchar

(lyft_payments)
order_id                int
order_date              datetime
promo_code              bool
order_fare              float

*/

-- required: city and number of rides (in Aug 2021)
-- filter: not using promo code
-- order: yes, highest ONLY

WITH total_qualified_orders AS (
    -- 1. join orders with its payment details
    SELECT o.city, COUNT(o.order_id) total_orders
    FROM lyft_orders o
    JOIN lyft_payments p
        on o.order_id = p.order_id
    -- 2. we need to filter for month criteria and promo_code
    WHERE p.promo_code IS FALSE
        AND EXTRACT(MONTH from order_date) = 8        
        AND EXTRACT(YEAR from order_date) = 2021
    GROUP BY 1
),

-- 3. output city with the highest order count
-- NOTE: we might have city with a tie
city_rank AS (
    SELECT city,
           total_orders,
           RANK() OVER (ORDER BY total_orders DESC) AS city_rank
    FROM total_qualified_orders
)

SELECT city
FROM city_rank
WHERE city_rank = 1

