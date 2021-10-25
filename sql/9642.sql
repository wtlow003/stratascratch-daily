/*

Find the number of unique properties
Find how many the number of different property types in the dataset.

Difficulty: Hard

Tables:
<airbnb_searches>
ds                      datetime
id_user                 varchar
ds_checkin              datetime
ds_checkout             datetime
n_searches              int
n_nights                float
n_guests_min            int
n_guests_max            int
origin_country          varchar
filter_price_min        float
filter_price_max        float
filter_room_types       varchar
filter_neighborhoods    datetime

*/

-- objective:
-- find number of different property types

SELECT DISTINCT room_types
FROM (
    SELECT UNNEST(STRING_TO_ARRAY(filter_room_types, ',')) room_types
    FROM airbnb_searches
) unique_room_types
WHERE room_types != ''
