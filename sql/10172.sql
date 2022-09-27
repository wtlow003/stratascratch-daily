/*

Best Selling Item
https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=10172

Difficulty: Hard

Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. The best selling item is calculated using the formula (unitprice * quantity). Output the description of the item along with the amount paid.

Tables:
(online_retail)
invoiceno       varchar
stockcode       varchar
description     varchar
quantity        int
invoicedate     datetime
unitprice       float
customerid      float
country         varchar

*/

WITH calculate_total_paid AS (
    SELECT EXTRACT(MONTH FROM invoicedate) AS month, 
          description, 
          SUM(unitprice * quantity) AS total_paid
    FROM online_retail
    GROUP BY 1,2
),

rank_items AS (
    SELECT  month,
            description,
            total_paid,
            DENSE_RANK() OVER(PARTITION BY month ORDER BY total_paid DESC) AS item_rank
    FROM calculate_total_paid
)

SELECT month,
       description,
       total_paid
FROM rank_items
WHERE item_rank = 1
