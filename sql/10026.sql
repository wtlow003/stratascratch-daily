/*

Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut
https://platform.stratascratch.com/coding/10026-find-all-wineries-which-produce-wines-by-possessing-aromas-of-plum-cherry-rose-or-hazelnut?python=

Difficulty: Easy

Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut.
Output unique winery values only.

Tables:
<winemag_p1>
id                  int
country             varchar
description         varchar
designation         varchar
points              int
price               float
province            varchar
region_1            varchar
region_2            varchar
variety             varchar
winery              varchar

*/

SELECT DISTINCT winery
FROM winemag_p1
WHERE description ILIKE '%plum%' OR  description ILIKE '%cherry%' OR description ILIKE '%rose%' OR  description ILIKE '%hazelnut%'
