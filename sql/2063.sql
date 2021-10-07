/*

Change of Currency Exchange Rates
https://platform.stratascratch.com/coding/2063-change-of-currency-exchange-rates?python=

Difficulty: Easy

You are given a list of exchange rates from various currencies to US Dollars (USD) in different months. Show how the exchange rate of all the currencies changed in the first half of 2020. Output the currency code and the difference between values of the exchange rate between July 1, 2020 and January 1, 2020.

Tables:
<sf_exchange_rate>
source_currency         varchar
target_currency         varchar
exchange_rate           float
date                    datetime

*/

-- logic: self-join to get the columns side by side for diff operations, need to join on two keys to have 1:1 match
-- logic: we will also need to find exchange to USD ONLY

-- ensure that we are minus from the latest date
SELECT t1.source_currency, t2.exchange_rate - t1.exchange_rate AS difference
FROM sf_exchange_rate t1
JOIN sf_exchange_rate t2
    ON t1.source_currency = t2.source_currency
    AND t2.target_currency = t2.target_currency
-- set the date for differencing
WHERE t1.date = '2020-01-01'
      AND t2.date = '2020-07-01'
      AND t1.target_currency = 'USD'
