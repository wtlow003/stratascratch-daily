/*

Reviews Bins on Reviews Number
https://platform.stratascratch.com/coding/9628-reviews-bins-on-reviews-number?python=

Difficulty: Medium

To better understand the effect of the review count on the price, categorize the number of reviews into the following groups along with the price.
    0 reviews: NO
    1 to 5 reviews: FEW
    6 to 15 reviews: SOME
    16 to 40 reviews: MANY
    more than 40 reviews: A LOT

Table:
<airbnb_search_details>
id                          int
price                       float
property_type               varchar
room_type                   varchar
amenities                   varchar
accommodates                int
bathrooms                   int
bed_type                    varchar
cancellation_policy         varchar
cleaning_fee                bool
city                        varchar
host_identity_verified      varchar
host_response_rate          varchar
host_since                  datetime
neighbourhood               varchar
number_of_reviews           int
review_scores_rating        float
zipcode                     int
bedrooms                    int
beds                        int

*/


-- logic:
-- create column to group number of reviews (case when)
-- display review qualification and price

SELECT CASE
    WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'FEW'
    WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'SOME'
    WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'MANY'
    WHEN number_of_reviews > 40 THEN 'A LOT'
    ELSE 'NO'
END AS reviews_qualification,
price
FROM airbnb_search_details
