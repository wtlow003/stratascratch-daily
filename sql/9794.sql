/*

Words With Two Vowels
https://platform.stratascratch.com/coding/9794-words-with-two-vowels?python=

Difficulty: Hard

Find all words which contain exactly two vowels in any list in the table.

Table:
<google_word_lists>
words1              varchar
words2              varchar

*/

-- objective:
-- find words that contains 'two vowels'

-- logic:
-- turn each row into array
-- unnest each array into individual rows (so 1 word 1 row)
-- count vowel with regex_replace()


SELECT word
FROM (
    -- unnest each array into individual word
    SELECT DISTINCT UNNEST(STRING_TO_ARRAY(word, ',')) AS word
    FROM (
        -- combining two columns into rows
        SELECT words1 AS word
        FROM google_word_lists
        UNION
        SELECT words2 AS word
        FROM google_word_lists
    ) union_words
) unnest_word_arrays
-- filter words with >= 3 vowels
WHERE NOT word ~ '([aeiou].*){3}'
    -- and only keep words with 2 vowels
    AND word ~ '([aeiou].*){2}'
