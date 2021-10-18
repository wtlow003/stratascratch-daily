/*

Avg Order Cost During Rush Hours
https://platform.stratascratch.com/coding/2035-avg-order-cost-during-rush-hours

Difficulty: Medium

Write a query that returns the average order cost per hour during hours 3 PM -6 PM (15-18) in San Jose. For calculating time period use 'Customer placed order datetime' field. Earnings value is 'Order total' field. Order output by hour.

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
-- find avg order cost during hours 15 - 18
-- in SAN JOSE

-- logic:
-- filter orders by SAN JOSE and hours between 15 - 18
-- AVG(order_total)
-- group by rush hours
-- order by rush hours

-- output:
-- hour, avg(total_cost)

SELECT EXTRACT(HOUR FROM customer_placed_order_datetime) AS hour,
       AVG(order_total) avg_order_cost
FROM doordash_delivery
WHERE (EXTRACT(HOUR FROM customer_placed_order_datetime) BETWEEN 15 AND 17)
        AND delivery_region = 'San Jose'
GROUP BY 1
