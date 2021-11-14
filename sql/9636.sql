/*

Cheapest Neighborhoods With Real Beds And Internet
https://platform.stratascratch.com/coding/9636-cheapest-neighborhoods-with-real-beds-and-internet?python=

Difficulty: Medium

Find neighborhoods where you can sleep on a real bed in a villa with internet while paying the lowest price possible.


Tables:
<airbnb_search_details>
id                      int
price                   float
property_type           varchar
room_type               varchar
amenities               varchar
accommodates            int
bathrooms               int
bed_type                varchar
cancellation_policy     varchar
cleaning_fee            bool
city                    varchar
host_identity_verified  varchar
host_response_rate      varchar
host_since              datetime
neighbourhood           varchar
number_of_reviews       int
review_scores_rating    float
zipcode                 int
bedrooms                int
beds                    int

*/

-- logic:
-- 1. filter for internet, bed_type and property_type
-- 2. rank by price
-- 3. get the lowest price

SELECT neighbourhood
FROM (
    SELECT neighbourhood,
           RANK() OVER(ORDER BY price ASC) AS price_rank
    FROM (
        SELECT id,
               neighbourhood,
               price
        FROM airbnb_search_details
        WHERE amenities LIKE '%Wireless Internet%'
            AND property_type = 'Villa'
            AND bed_type = 'Real Bed'
    ) price_ranking
) cheapest_house
WHERE price_rank = 1
