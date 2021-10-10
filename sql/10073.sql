/*

Favorite Host Nationality
https://platform.stratascratch.com/coding/10073-favorite-host-nationality?python&utm_source=youtube&utm_medium=click&utm_campaign=YT+description+link

Difficulty: Medium

For each guest reviewer, find the nationality of the reviewer’s favorite host based on the guest’s highest review score given to a host. Output the user ID of the guest along with their favorite host’s nationality.

Tables:
<airbnb_reviews>
from_user               int
to_user                 int
from_type               varchar
to_type                 varchar
review_score            int

<airbnb_hosts>
host_id                 int
nationality             varchar
gender                  varchar
age                     int

*/

-- objective:
-- find the highest review score given by each guest user
-- find the host_id given the highest review
-- output the user id and the host nationality

-- assumption:
-- each user only has 1 highest review score
-- possibly more than 1 host has the same highest review score
-- if same country we can remove the duplicated host nationality

-- logic:
-- max(review_score) per user
-- filter host_id that received that the highest id
-- output the user id and their host nationality

-- retrieve the host nationality
-- remove duplicates as well
SELECT DISTINCT u.from_user,
       h.nationality
FROM (
    -- select the particular reviews that were given the highest score for each user
    SELECT r.*
    FROM airbnb_reviews r
    JOIN (
        -- select the highest review given by each guest user
        SELECT from_user,
               MAX(review_score) AS highest_score
        FROM airbnb_reviews
        WHERE from_type = 'guest'
        GROUP BY 1
    ) highest_review_score
        ON r.from_user = highest_review_score.from_user
        AND r.review_score = highest_review_score.highest_score
    -- ensure that score remains from a guest perspective
    WHERE from_type = 'guest'
) u
JOIN airbnb_hosts h
    ON u.to_user = h.host_id
ORDER BY 1
