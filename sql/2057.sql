/*

Weight For First Shipment
https://platform.stratascratch.com/coding/2057-weight-for-first-shipment?python=

Difficulty: Easy

Write a query to find the weight for each shipment's earliest shipment date. Output the shipment id along with the weight.

Tables:
<amazon_shipment>
shipment_id             int
sub_id                  int
weight                  int
shipment_date           datetime

*/


-- objective:
-- find weight for each shipment's earliest shipment date

-- assumption:
-- there may be more than 1 sub_id per shipment_id for earliest date

-- logic:
-- min(shipment_date) for shipment_id
-- where shipment = min(shipment_date)

SELECT s.shipment_id,
       SUM(s.weight)
FROM amazon_shipment s
JOIN (
    SELECT shipment_id,
           MIN(shipment_date) AS earliest_date
    FROM amazon_shipment
    GROUP BY 1
) earliest_shipment
    ON s.shipment_id = earliest_shipment.shipment_id
    AND s.shipment_date = earliest_shipment.earliest_date
GROUP BY 1
