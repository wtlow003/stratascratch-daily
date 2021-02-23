/*
Difficulty: Easy
Company: Amazon

Customer Details
Find the details of each customer regardless of whether the customer made an order not.
Output customer's first name, last name, and the city along with the corresponding order details.
Sort records based on the customer's first name and the order details in ascending order.

Tables'
Customers idint
first_name varchar
last_name varchar
city varchar
address varchar
phone_number varchar

orders
id int
cust_id int
order_date datetime
order_quantity int
order_details varchar
order_cost int
*/

SELECT c.first_name, c.last_name, c.city, o.order_details
FROM customers c
LEFT JOIN orders o
    ON c.id = o.cust_id
ORDER BY 1,4 
