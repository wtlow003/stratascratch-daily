/*

Lowest Revenue Generated Restaurants
https://platform.stratascratch.com/coding/2036-lowest-revenue-generated-restaurants?python=

Difficulty: Hard

Write a query that returns a list of the bottom 2% revenue generating restaurants. Return a list of restaurant IDs and their total revenue from when customers placed orders in May 2020.

You can calculate the total revenue by summing the order_total column. And you should calculate the bottom 2% by partitioning the total revenue into evenly distributed buckets.

Tables:
<doordash_delivery>
customer_placed_order_datetime          datetime
placed_order_with_restaurant_datetime   datetime
driver_at_restaurant_datetime           datetime
delivered_to_consumer_datetime          datetime
driver_id                               int
restaurant_id                           int
consumer_id                             int
is_new                                  bool
delivery_region                         varchar
is_asap                                 bool
order_total                             float
discount_amount                         float
tip_amount                              float
refunded_amount                         float

*/

-- objective:
-- find restaurant and their revenue which falls in the bottom 2%

-- logic:
-- sum the total revenue for may 2020
-- ntile(total_revenue) and bottom 2%
-- filter restaurant if ntile = 1 (for ntile(50)) or ntile <= 2 (for ntile(100))

SELECT restaurant_id,
       total_revenue
FROM (
    SELECT restaurant_id,
           SUM(order_total) total_revenue,
           NTILE(50) OVER(ORDER BY SUM(order_total)) AS ntile
    FROM doordash_delivery
    WHERE EXTRACT('MONTH' FROM customer_placed_order_datetime) = 5
        AND EXTRACT('YEAR' FROM customer_placed_order_datetime) = 2020
    GROUP BY 1
) restaurant_revenue
WHERE ntile = 1
ORDER BY 2 DESC
