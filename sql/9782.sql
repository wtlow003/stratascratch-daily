/*

Customer Revenue In March
https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?python=

Difficulty: Medium

Calculate the total revenue from each customer in March 2019.

Output the revenue along with the customer id and sort the results based on the revenue in descending order.

Tables:
<orders>
id                  int
cust_id             int
order_date          datetime
order_details       varchar
total_order_cost    int

*/

-- objective:
-- total revenue for each customer in March 2019

-- assumption:
-- customer may not have any revenue ($0)

-- logic:
-- sum(total_order_cost) by cust_id
-- left join orders on cust_id
-- coalesce total revenue with 0 if null
-- order by revenue DESC

-- ouput: cust_id and total_revenue
SELECT DISTINCT o.cust_id,
       -- ensure we factor in all customer
       COALESCE(rev.total_revenue, 0) total_revenue
FROM orders o
JOIN (
    SELECT cust_id,
          SUM(total_order_cost) total_revenue
    FROM orders
    WHERE LEFT(order_date::varchar, 7) = '2019-03'
    GROUP BY 1
) rev
    ON o.cust_id = rev.cust_id
ORDER BY total_revenue DESC
