/*

File Contents Shuffle
https://platform.stratascratch.com/coding/9818-file-contents-shuffle?python=

Difficulty: Hard

Sort the words alphabetically in 'final.txt' and make a new file named 'wacky.txt'. Output the file contents in one column and the filename 'wacky.txt' in another column.

* If coding in python, the file contents should be contained in a list.

Tables:
<google_file_store>
filename            varchar
contents            varchar

*/

-- logic:
-- 1. filter filename for 'final.txt'
-- 2. turn content into individual words within an array
-- 3. unnest the array
-- 4. sort rows by alphabetical order
-- 5. merge rows back into 1 file content

SELECT 'wacky.txt' AS filename, STRING_AGG(words, ' ') AS contents
FROM (
    -- turn content into individual words in array
    SELECT UNNEST(STRING_TO_ARRAY(LOWER(contents), ' ')) AS words
    FROM google_file_store
    -- filter for filename = 'final.txt'
    WHERE filename = 'final.txt'
    ORDER BY words ASC
) AS order_words
