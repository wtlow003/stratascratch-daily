/*

Accommodates-To-Bed Ratio
https://platform.stratascratch.com/coding/9624-accommodates-to-bed-ratio?python=

Difficulty: Medium

Find the average accommodates-to-beds ratio for shared rooms in each city. Sort your results by listing cities with the highest ratios


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
-- 1. find the individual accommodates2bed ratio per listing first
-- 2. avg a2b ratio by each city
-- 3. order by desc in highest ratio

SELECT city,
       AVG(a2b_ratio) AS city_a2b
FROM (
    SELECT id,
           city,
           (accommodates/beds::float) AS a2b_ratio
    FROM airbnb_search_details
    WHERE room_type = 'Shared room'
) ind_ratio
GROUP BY 1
ORDER BY city_a2b DESC
