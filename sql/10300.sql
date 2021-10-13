/*

Premium vs Freemium
https://platform.stratascratch.com/coding/10300-premium-vs-freemium?python=

Difficulty: Hard

Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.

Tables:
<ms_user_dimension>
user_id             int
acc_id              int

ms_acc_dimension
acc_id              int
paying_customer     varchar

ms_download_facts
2021-10-13          datetime
user_id             int
downloads           int

*/

-- objective:
-- find downloads by paying and non-paying users
-- on a date basis
-- records should be non-paying downloads > paying downloads

-- assumption:
-- downloads varies on dates can possibly be 0 on certain dates

-- logic:
-- find downloads per user
-- filter paying and non-paying customers
-- self join on date
-- filter non-paying download > paying downlaods
-- order by earliest date

WITH downloads_by_date AS (
    SELECT d.date,
           paying_customer,
           SUM(d.downloads) AS downloads
    FROM ms_user_dimension ud
    JOIN ms_acc_dimension ad
        ON ud.acc_id = ad.acc_id
    JOIN ms_download_facts d
        ON ud.user_id = d.user_id
    GROUP BY 1,2
)

SELECT p.date,
       np.downloads AS non_paying_downloads,
       p.downloads AS paying_downloads
FROM downloads_by_date p
JOIN (
    SELECT date,
           downloads
    FROM downloads_by_date
    WHERE paying_customer = 'no'
) np
    ON p.date = np.date
WHERE p.paying_customer = 'yes'
    AND np.downloads > p.downloads
ORDER BY 1
