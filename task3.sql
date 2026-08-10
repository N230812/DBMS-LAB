use madhavi;
-- Part A
SHOW TABLES;
SELECT * FROM Taxpayer;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;
SELECT * FROM Income_Record;

-- Part B String Functions
SELECT UPPER(full_name) FROM Taxpayer;
SELECT LOWER(occupation) FROM Taxpayer;
SELECT full_name,LENGTH(full_name) FROM Taxpayer;
SELECT pan_number,LEFT(pan_number,4) FROM Taxpayer;
SELECT CONCAT(full_name,' - ',occupation) FROM Taxpayer;
SELECT REPLACE(category_name,'Income','Inc.') FROM Income_Category;
SELECT TRIM(full_name) FROM Taxpayer;
SELECT SUBSTRING_INDEX(full_name,' ',1) AS first_name FROM Taxpayer;
SELECT CONCAT('Taxpayer : ',full_name,' | Occupation : ',occupation) FROM Taxpayer;
SELECT * FROM Taxpayer WHERE pan_number LIKE 'AP%';

-- Part C Numeric
SELECT full_name,ROUND(annual_income) FROM Taxpayer;
SELECT full_name,ABS(annual_income-500000) FROM Taxpayer;
SELECT full_name,POWER(annual_income,2) FROM Taxpayer;
SELECT full_name,MOD(annual_income,1000) FROM Taxpayer;
SELECT full_name,ROUND(annual_income,2) FROM Taxpayer;
SELECT full_name,CEIL(annual_income),FLOOR(annual_income) FROM Taxpayer;
SELECT FLOOR(1+RAND()*100) AS random_integer;
SELECT full_name,SQRT(annual_income) FROM Taxpayer;
SELECT full_name,annual_income*1.10 AS incremented_income FROM Taxpayer;

-- Part D Date
SELECT CURDATE();
SELECT NOW();
SELECT year_label,YEAR(start_date) FROM Financial_Year;
SELECT year_label,MONTH(start_date) FROM Financial_Year;
SELECT year_label,DAY(start_date) FROM Financial_Year;
SELECT year_label,DATE_ADD(start_date,INTERVAL 1 YEAR) FROM Financial_Year;
SELECT year_label,DATE_ADD(start_date,INTERVAL 30 DAY) FROM Financial_Year;
SELECT year_label,DATE_SUB(start_date,INTERVAL 7 DAY) FROM Financial_Year;
SELECT year_label,DATEDIFF(CURDATE(),start_date) FROM Financial_Year;
SELECT * FROM Financial_Year WHERE YEAR(start_date)=YEAR(CURDATE());

-- Part E Conversion
SELECT full_name,CAST(annual_income AS SIGNED) FROM Taxpayer;
SELECT CAST(taxpayer_id AS CHAR) FROM Taxpayer;
SELECT year_label,CAST(start_date AS DATETIME) FROM Financial_Year;
SELECT full_name,CAST(annual_income AS DECIMAL(12,2)) FROM Taxpayer;
SELECT CAST(annual_income AS CHAR) FROM Taxpayer;
SELECT full_name,(CAST(annual_income AS DECIMAL(12,2))*0.10) AS estimated_tax FROM Taxpayer;
