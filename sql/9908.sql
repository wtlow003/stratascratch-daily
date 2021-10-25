/*

Customer Orders and Details
https://platform.stratascratch.com/coding/9908-customer-orders-and-details?python=

Difficulty: Medium

Find the number of orders, the number of customers, and the total cost of orders for each city. Only include cities that have made at least 5 orders and count all customers in each city even if they did not place an order.

Output each calculation along with the corresponding city name.

Tables:
<customers>
id                  int
first_name          varchar
last_name           varchar
city                varchar
address             varchar
phone_number        varchar

orders
id                  int
cust_id             int
order_date          datetime
order_details       varchar
total_order_cost    int

*/

-- objective:
-- aggregation by city

-- assumption:
-- only include cities with at least 5 orders
-- count all customers in each city even if they did not place an order

-- logic:
-- LEFT JOIN orders on customers
-- GROUPBY(city) to aggregate by city
-- COUNT(orders.id) for number of orders per city
-- COUNT(customers.id) for number of customer per city
-- COALESCE(SUM(total_order_cost)) total cost of orders, 0 if no COUNT(orders.id)

-- output:
-- city, no. orders, no. custs, total_order_cost


SELECT city,
       COUNT(o.id) AS no_orders,
       COUNT(DISTINCT c.id) AS no_customers,
       COALESCE(SUM(total_order_cost), 0) AS total_order_cost
FROM customers c
LEFT JOIN orders o
    ON c.id = o.cust_id
GROUP BY 1
HAVING COUNT(o.id) >= 5
