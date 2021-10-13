/*

Highest Cost Orders
https://platform.stratascratch.com/coding/9915-highest-cost-orders?python=

Difficulty: Hard

Find the customer with the highest total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output their first name, total cost of their items, and the date.

For simplicity, you can assume that every first name in the dataset is unique.

Tables:
<customers>
id                  int
first_name          varchar
last_name           varchar
city                varchar
address             varchar
phone_number        varchar

<orders>
id                  int
cust_id             int
order_date          datetime
order_details       varchar
total_order_cost    int

*/

-- objective:
-- customer with the highest total order cost
-- between 2019-02-01 and 2019-05-01 (feb and may)
-- first name, total cost of items (by date), and date (> 1 orders on certain day possible)

-- assumption:
-- customer has > 1 order
-- there may be 1 more than 1 customer with largest amount purchase
-- we are interested in the highest order cost at any one date

-- logic:
-- filter date between 2019-02-01 and 2019-05-01
-- sum(total_order_cost) by cust_id
-- retrieve top cust_id by sum(total_order_cost)
-- filter orders by top cust_id
-- agg total_order_cost by date for the user
-- join customers to get first_name

-- we need first_name
SELECT c.first_name,
       cost_rank.total_cost_of_items,
       cost_rank.order_date
FROM (
    -- find the cust_id with the highest total cost
    SELECT cust_id,
           order_date,
           SUM(total_order_cost) total_cost_of_items,
           -- in case we have two customer with highest total order cost
           DENSE_RANK() OVER(ORDER BY SUM(total_order_cost) DESC) AS cost_rank
    FROM orders
    -- filter by date
    WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01'
    GROUP BY 1,2
) cost_rank
JOIN customers c
    ON cost_rank.cust_id = c.id
-- take users with highest rank
WHERE cost_rank.cost_rank = 1
