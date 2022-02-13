/*

Order Details
https://platform.stratascratch.com/coding/9913-order-details?python=

Difficulty: Medium

Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.

Tables:
<customers>
id                          int
first_name                  varchar
last_name                   varchar
city                        varchar
address                     varchar
phone_number                varchar

<orders>
id                          int
cust_id                     int
order_date                  datetime
order_details               varchar
total_order_cost            int

*/

/*
1. filter customers' first name for Jill and Eva
2. require order date, details and cost + first name 
3. order records based on customer id ASC
*/

SELECT first_name, order_date, order_details, total_order_cost
FROM customers c
JOIN orders o
    on c.id = o.cust_id
WHERE first_name IN ('Jill', 'Eva')
ORDER BY o.cust_id ASC
