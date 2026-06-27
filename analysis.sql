-- ================================================
-- PROJECT: Investment Performance Analytics
-- TOOL: SQL (SQLite)
-- DATASET: Monthly Mutual Fund Returns 2024
-- AUTHOR: Shivaling Bidaragaddi
-- DATE: June 2026
-- ================================================

-- ------------------------------------------------
-- QUERY 1: View Sample Data
-- ------------------------------------------------
SELECT * FROM "Monthly Mutual Fund Returns 2024" 
LIMIT 10;

-- ------------------------------------------------
-- QUERY 2: Total Funds in Dataset
-- ------------------------------------------------
SELECT COUNT(*) AS total_funds 
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund';

-- ------------------------------------------------
-- QUERY 3: Top 10 Funds by December 2024 Returns
-- ------------------------------------------------
SELECT Fund, Category, "Dec-24"
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
ORDER BY "Dec-24" DESC
LIMIT 10;

-- ------------------------------------------------
-- QUERY 4: Bottom 10 Funds by December 2024 Returns
-- ------------------------------------------------
SELECT Fund, Category, "Dec-24"
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
ORDER BY "Dec-24" ASC
LIMIT 10;

-- ------------------------------------------------
-- QUERY 5: Average Annual Return Per Fund
-- ------------------------------------------------
SELECT Fund, Category,
       ROUND(("Mar-24"+"Apr-24"+"May-24"+"Jun-24"+
              "Jul-24"+"Aug-24"+"Sep-24"+"Oct-24"+
              "Nov-24"+"Dec-24") / 10, 2) AS avg_return
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
ORDER BY avg_return DESC
LIMIT 10;

-- ------------------------------------------------
-- QUERY 6: Best Performing Category
-- ------------------------------------------------
SELECT Category,
       ROUND(AVG("Dec-24"), 2) AS avg_dec_return,
       COUNT(*) AS total_funds
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
GROUP BY Category
ORDER BY avg_dec_return DESC;

-- ------------------------------------------------
-- QUERY 7: Performance Exception Flag
-- Funds with unusually high Dec-24 returns (>5%)
-- Similar to exception investigation at State Street
-- ------------------------------------------------
SELECT Fund, Category, "Dec-24",
       CASE
           WHEN "Dec-24" > 5 THEN 'HIGH EXCEPTION'
           WHEN "Dec-24" < -2 THEN 'LOW EXCEPTION'
           ELSE 'NORMAL'
       END AS exception_flag
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
ORDER BY "Dec-24" DESC;

-- ------------------------------------------------
-- QUERY 8: Funds with Negative Returns (Dec-24)
-- Data quality / anomaly check
-- ------------------------------------------------
SELECT Fund, Category, "Dec-24"
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund'
AND "Dec-24" < 0
ORDER BY "Dec-24" ASC;

-- ------------------------------------------------
-- QUERY 9: Month-wise Average Market Performance
-- ------------------------------------------------
SELECT 
    ROUND(AVG("Mar-24"),2) AS Mar,
    ROUND(AVG("Apr-24"),2) AS Apr,
    ROUND(AVG("May-24"),2) AS May,
    ROUND(AVG("Jun-24"),2) AS Jun,
    ROUND(AVG("Jul-24"),2) AS Jul,
    ROUND(AVG("Aug-24"),2) AS Aug,
    ROUND(AVG("Sep-24"),2) AS Sep,
    ROUND(AVG("Oct-24"),2) AS Oct,
    ROUND(AVG("Nov-24"),2) AS Nov,
    ROUND(AVG("Dec-24"),2) AS Dec
FROM "Monthly Mutual Fund Returns 2024"
WHERE Fund != 'Fund';