/*

Common Letters
https://platform.stratascratch.com/coding/9823-common-letters?python=

Difficulty: Hard

Find the top 3 most common letters across all the words from both the tables. Output the letter along with the number of occurrences and order records in descending order based on the number of occurrences.

Tables:
<google_file_store>
filename            varchar
contents            varchar

<google_word_lists>
words1              varchar
words2              varchar

*/

-- objective:
-- for all letter that appears, we want to count their occurences
-- and find the top 3

-- asssumption:
-- only look at contents, words1, words2


-- logic:
-- string_to_array and unnest() to get words in each row individually
-- union all words1, words2, words3, DO NOT REMOVE DUPLICATES
-- regext_split_string_to_array() to extract letters
-- unnest() to get letters to each row individually
-- groupby() letters and count(*)
-- order by count(*) DESC

-- groupby each letters and count(*)
SELECT letters,
      COUNT(*)
FROM (
    -- extracting letters and unnest to individual letters
    SELECT words,
           UNNEST(REGEXP_SPLIT_TO_ARRAY(words, E'\\W*')) AS letters
    FROM (
        -- extracting words and unnest to individual rows
        SELECT UNNEST(STRING_TO_ARRAY(LOWER(contents), ' ')) AS words
        FROM google_file_store
        -- union all ensures all duplicates remains
        UNION ALL
        SELECT UNNEST(STRING_TO_ARRAY(words1, ',')) AS words
        FROM google_word_lists
        UNION ALL
        SELECT UNNEST(STRING_TO_ARRAY(words2, ',')) AS words
        FROM google_word_lists
    ) AS all_words
) all_letters
-- there is an issue with extracting totally excluding punctuations
WHERE letters <> ''
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3
