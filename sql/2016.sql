/*
Difficulty: Medium
Company: Postmates

Pizza Partners
How many partners have ‘pizza’ in their name which are located in Boston?
And what is the average order amount?

Tables:

postmates_orders

id int
customer_id int
courier_id int
seller_id int
order_timestamp_utc datetime
amount float
city_id int

postmates_markets

id int
name varchar
timezone varchar

postmates_partners

id int
name varchar
category varchar
*/

WITH orders_by_partners AS (
    SELECT po.seller_id, pp.name, po.city_id, po.amount
    FROM postmates_orders po
    JOIN postmates_partners pp
        ON po.seller_id = pp.id
)

SELECT name, AVG(amount)
FROM orders_by_partners
WHERE LOWER(name) LIKE '%pizza%'
    AND city_id IN (
        SELECT id
        FROM postmates_markets
        WHERE name = 'Boston'
    )
GROUP BY 1
ORDER BY 2
