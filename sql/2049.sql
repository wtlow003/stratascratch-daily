/*

Total Order Per Status Per Service
https://platform.stratascratch.com/coding/2049-total-order-per-status-per-service?python=

Difficulty: Easy

Uber is interested in identifying gaps in their business. Calculate the count of orders for each status of each service. Your output should include the service name, status of the order, and the number of orders.

Tables:
<uber_orders>
order_date              datetime
number_of_orders        int
status_of_order         varchar
monetary_value          float
service_name            varchar

*/

-- logic: count status for each service

-- simple groupby
SELECT service_name, status_of_order, SUM(number_of_orders) AS order_sum
FROM uber_orders
GROUP BY 1, 2;
