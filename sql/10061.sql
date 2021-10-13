/*

Popularity of Hack
https://platform.stratascratch.com/coding/10061-popularity-of-hack?python=

Difficulty: Easy

Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. Luckily the user IDs of employees completing the surveys were stored.
Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

Tables:
<facebook_employees>
id                  int
location            varchar
age                 int
gender              varchar
is_senior           bool

facebook_hack_survey
employee_id         int
age                 int
gender              varchar
popularity          int

*/

-- objective:
-- average popularity per office

-- logic:
-- join employee and survey by id = employee_id
-- avg(popularity) by location

SELECT location,
       AVG(popularity)
FROM facebook_employees e
JOIN facebook_hack_survey h
    ON e.id = h.employee_id
GROUP BY 1
