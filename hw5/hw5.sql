-- ==========================================
-- Exe 9
-- ==========================================

-- Transform one-hot encoded duration columns into a single categorical column
-- This converts the binary indicators (short, medium, long) into a readable duration category

SELECT
    title,
    length,
    CASE
        WHEN short = 1 THEN 'Short'
        WHEN medium = 1 THEN 'Medium'
        WHEN long = 1 THEN 'Long'
    END AS duration
FROM films;










-- ==========================================
-- Exe 10
-- ==========================================


-- Show all records from payment table
SELECT *
FROM payment;


-- Aggregate payment total by Day of Week (0–6)
-- 0 = Sunday, 1 = Monday, ..., 6 = Saturday
SELECT 
    EXTRACT(DOW FROM payment_date) AS day_of_week,
    SUM(amount) AS total_amount
FROM payment
GROUP BY EXTRACT(DOW FROM payment_date)
ORDER BY EXTRACT(DOW FROM payment_date);


-- Aggregate payment growth rate by Month
SELECT 
    EXTRACT(MONTH FROM payment_date) AS month,
    SUM(amount) AS monthly_total,

    -- Calculate growth rate percentage compared to previous month
    (
        SUM(amount) 
        - LAG(SUM(amount), 1) OVER (ORDER BY EXTRACT(MONTH FROM payment_date))
    )
    / LAG(SUM(amount), 1) OVER (ORDER BY EXTRACT(MONTH FROM payment_date))
    * 100 AS percent_of_growth_rate

FROM payment
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY EXTRACT(MONTH FROM payment_date);

