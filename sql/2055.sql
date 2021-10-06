/*

Average Customers Per City
https://platform.stratascratch.com/coding/2055-average-customers-per-city?python=

Difficulty: Medium

Write a query that will return all cities with more customers than the average number of  customers of all cities. For each such city, return the country name,  the city name, and the number of customers

Tables:
<linkedin_customers>
id                  int
business_name       varchar
city_id             int

<linkedin_city>
id                  int
city_name           varchar
country_id          int

<linkedin_country>
id                  int
country_name        varchar

*/

-- logic: need find avg number of customers across all cities, find cities who have more than the global average

-- count total customers per city
WITH avg_cust_cities AS (
    SELECT city_id, COUNT(*) AS total_customers
    FROM linkedin_customers
    GROUP BY 1
)

-- selecting the country and city name, alongside total customers
SELECT lco.country_name, lci.city_name, total_customers
FROM avg_cust_cities acc
-- joins to retrieve the detail name
JOIN linkedin_city lci
    ON acc.city_id = lci.id
JOIN linkedin_country lco
    ON lci.country_id = lco.id
-- filter for city's total customers > avg across all cities
WHERE total_customers > (
    SELECT AVG(total_customers)
    FROM avg_cust_cities
);
