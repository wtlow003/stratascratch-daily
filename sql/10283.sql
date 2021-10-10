/*

Find the top-ranked songs for the past 30 years.
https://platform.stratascratch.com/coding/10283-find-the-top-ranked-songs-for-the-past-30-years?python=

Difficulty: Medium

Find all the songs that were top-ranked (at first position) at least once in the past 30 years

Tables:
<billboard_top_100_year_end>
year                                int
year_rank                           int
group_name                          varchar
artist                              varchar
song_name                           varchar
id                                  int

*/

-- objective:
-- find song that at least ranked first one time in any year
-- within the last 30 years

-- assumption:
-- the song has to be rank 1 at least once
-- song can be rank 1 for many times
-- we use song_name as the primary key

-- logic:
-- filter songs in the last 30 years
-- count the number of rank 1 in the same period
-- return all details about the song

-- select song name
SELECT DISTINCT song_name
FROM billboard_top_100_year_end
-- within the last 30 years from today's year
WHERE DATE_PART('year', CURRENT_DATE) - year <= 30
    AND year_rank = 1
