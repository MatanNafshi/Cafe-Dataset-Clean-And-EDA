-- View the full cleaned dataset
SELECT * FROM cafe_sales_edited;

-- Items based on the times they were bought (summing all quantities based on the item itself).
SELECT item, SUM(quantity) AS "Times Ordered"
FROM cafe_sales_edited
WHERE item NOT IN ("Unknown", "ERROR")
GROUP BY item
WITH ROLLUP -- Used to sum up everything
ORDER BY SUM(quantity);

-- How many years of data do we have (apparently, just one, 2023).
SELECT DISTINCT YEAR(trans_date)
FROM cafe_sales_edited;

-- Therefore, we ought to group by the months.
SELECT DISTINCT MONTH(trans_date)
FROM cafe_sales_edited;

-- Saw some NULLs, but this is what we did in the cleaning process.
SELECT * FROM cafe_sales_edited
WHERE MONTH(trans_date) IS NULL;

-- Let's group based of the months which are not NULL.
SELECT MONTH(trans_date), SUM(total_spent)
FROM cafe_sales_edited
WHERE MONTH(trans_date) IS NOT NULL
GROUP BY MONTH(trans_date)
ORDER BY 1 ASC;

-- Overall average spending per transaction
SELECT AVG(total_spent)
FROM cafe_sales_edited;

-- A query to find the average money of per payment method.
-- I wanted to see wether people - on average - are spending differently based on the payment method.
SELECT payment_methods, AVG(total_spent) AS "Average Money Spent Per Pay Method"
FROM cafe_sales_edited
GROUP BY payment_methods
ORDER BY 2 ASC;

-- A query to find the most profitable item types overall.
-- This helps to identify which items are bringing in the most revenue (regardless of quantity).
SELECT item, SUM(total_spent) AS "Total Revenue"
FROM cafe_sales_edited
WHERE item NOT IN ("Unknown", "ERROR")
GROUP BY item
ORDER BY "Total Revenue" DESC;

-- A query to find the most profitable location type.
-- Helps determine if Takeaway, In-store, etc., brings more money.
SELECT location, SUM(total_spent) AS "Total Revenue Per Location"
FROM cafe_sales_edited
WHERE location <> "Unknown"
GROUP BY location
ORDER BY "Total Revenue Per Location" DESC;

-- A query to find which day had the highest total revenue.
-- Useful to detect peak transaction days.
SELECT trans_date, SUM(total_spent) AS "Total Revenue Per Day"
FROM cafe_sales_edited
WHERE trans_date IS NOT NULL
GROUP BY trans_date
ORDER BY "Total Revenue Per Day" DESC
LIMIT 1;

-- A query to find the most common quantity ordered in a transaction.
-- Helps understand customer behavior and portion preference.
SELECT quantity, COUNT(*) AS "Frequency"
FROM cafe_sales_edited
GROUP BY quantity
ORDER BY "Frequency" DESC;