-- View the cleaned table
SELECT * FROM cafe_sales_edited;

-- ========================================
-- 1. Duplicate Check via transaction Id.
-- ========================================
SELECT trans_id, COUNT(trans_id) AS count
FROM cafe_sales_edited
GROUP BY trans_id
HAVING count > 1;

-- ========================================
-- 2. Standardize Item Names by Price
-- ========================================
SELECT DISTINCT item, price_per_unit
FROM cafe_sales_edited
WHERE item <> '';

# A short explanation:
# In this dataset, taken from Kaggle.com, There was a mapping of each item to it's price.
# I only updated the items to be what they are if and only if the price_per_unit was distinct.
UPDATE cafe_sales_edited SET item = 'Coffee' WHERE price_per_unit = 2;
UPDATE cafe_sales_edited SET item = 'Tea' WHERE price_per_unit = 1.5;
UPDATE cafe_sales_edited SET item = 'Salad' WHERE price_per_unit = 5;
UPDATE cafe_sales_edited SET item = 'Cookie' WHERE price_per_unit = 1;

-- ========================================
-- 3. Handle NULL or Empty Values
-- ========================================
SELECT quantity, COUNT(*) FROM cafe_sales_edited GROUP BY quantity ORDER BY quantity;
SELECT COUNT(*) FROM cafe_sales_edited WHERE quantity IS NULL OR quantity = '';
SELECT COUNT(*) FROM cafe_sales_edited WHERE price_per_unit IS NULL OR price_per_unit = '';
SELECT COUNT(*) FROM cafe_sales_edited WHERE total_spent IS NULL OR total_spent = '';
-- Quantity and Price per unit did not have any NULL values.

-- Therefore, I could easily calculate the values of total_spent by multiplying them:
UPDATE cafe_sales_edited
SET total_spent = quantity * price_per_unit;

-- Change total_spent to INT
ALTER TABLE cafe_sales_edited MODIFY total_spent INT;

-- ========================================
-- 4. Standardize 'location' & 'payment_methods'
-- ========================================
UPDATE cafe_sales_edited
SET location = 'Unknown'
WHERE location IN ('UNKNOWN', '');

UPDATE cafe_sales_edited
SET payment_methods = 'Unknown'
WHERE payment_methods IN ('UNKNOWN', '');

-- ========================================
-- 5. Handle 'UNKNOWN' Items
-- ========================================
UPDATE cafe_sales_edited
SET item = 'Unknown'
WHERE item IN ('UNKNOWN', '');

-- ========================================
-- 6. Transaction ID Check 
-- ========================================
-- After checking in the very first query of this file, I wanted to double check.
SELECT SUBSTRING(trans_id, 5) AS id_suffix, COUNT(*)
FROM cafe_sales_edited
GROUP BY id_suffix
HAVING COUNT(*) > 1;

-- ========================================
-- 7. Clean & Convert Date Column
-- ========================================
-- Replace placeholders
UPDATE cafe_sales_edited
SET trans_date = '01-01-1990'
WHERE trans_date IN ('ERROR', 'UNKNOWN', '');

-- Add parsed date column
ALTER TABLE cafe_sales_edited ADD trans_date_parsed DATE;

-- Parse to date format
-- There was a problem, because MySQL has it's way of converting TEXT to DATE.
-- There was a need for a new column, that would be formatted in a MySQL DATE format
-- Only then I could use that new column, and put it instead of the original column.
UPDATE cafe_sales_edited
SET trans_date_parsed = STR_TO_DATE(trans_date, '%d-%m-%Y');

-- Replace old column
ALTER TABLE cafe_sales_edited DROP COLUMN trans_date;
ALTER TABLE cafe_sales_edited RENAME COLUMN trans_date_parsed TO trans_date;

-- Set trans_date column to DATE type
ALTER TABLE cafe_sales_edited MODIFY trans_date DATE;

-- Final cleanup: remove placeholder date
-- In later thought, it wasn't needed, I could have just put a NULL value in the first place. 
UPDATE cafe_sales_edited
SET trans_date = NULL
WHERE trans_date = '1990-01-01';

-- Final view
SELECT * FROM cafe_sales_edited;


# Dataset taken from Kaggle.com
# https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training
# Thank you! feel free to use this file
# Don't hesitate to contact me via:
    # Gmail: matannaf@gamil.com
    # Linkedin: https://www.linkedin.com/in/matan-nafshi
    # Github: Github.com/MatanNafshi
