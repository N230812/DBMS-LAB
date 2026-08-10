use madhavi;
-- Part A
show tables;
select * from Taxpayer;
select * from Income_Category;
select * from Financial_Year;
select * from Income_Record;

-- Part B level 1
SELECT COUNT(*) As
total_income_records
FROM Income_Record;

SELECT SUM(amount) AS total_income
FROM Income_Record;

SELECT AVG(amount) As average_income
FROM Income_Record;

SELECT MAX(amount) As lowest_income
FROM Income_Record;

SELECT MIN(amount) AS lowest_income
FROM Income_Record;

-- level 2

SELECT category_id,
COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY category_id;

SELECT category_id,
AVG(amount) AS average_income
FROM Income_Record
GROUP BY category_id;

SELECT category_id,
MAX(amount) AS highest_income
FROM Income_Record
GROUP BY category_id;

SELECT category_id,
MIN(amount) AS lowest_income
FROM Income_Record
GROUP BY category_id;

SELECT year_id,
SUM(amount) AS total_income
FROM Income_Record
GROUP BY year_id;

SELECT year_id,
COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY year_id;

SELECT category_id,year_id,
SUM(amount) AS total_income
FROm Income_Record
GROUP BY category_id,year_id;

-- level 3
SELECT category_id,
SUM(amount) AS total_income
FROM Income_Record
GROUP BY category_id
HAVING SUM(amount)>1000000;

SELECT category_id,
AVG(amount) AS average_income
FROM Income_Record
GROUP BY category_id
HAVING AVG(amount)>500000;

SELECT year_id,
COUNT(*) AS number_of_records
FROM Income_Record
GROUP BY year_id
HAVING COUNT(*)>3;

SELECT category_id,
SUM(amount) AS total_income
FROM Income_Record
GROUP BY category_id
ORDER BY SUM(amount) DESC;

SELECT category_id,
SUM(amount) AS total_income
FROM Income_Record
GROUP BY category_id
HAVING SUM(amount)>1000000
ORDER BY SUM(amount) DESC;

SELECT category_id,
SUM(amount) AS total_income,
AVG(amount) AS average_income
FROM Income_Record
GROUP BY category_id;

SELECT category_id,year_id,
SUM(amount) AS total_income
FROM Income_Record 
GROUP BY category_id,year_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT F.year_label,
COUNT(DISTINCT I.taxpayer_id) AS number_of_taxpayers
FROM Income_Record I
JOIN Financial_Year F
ON I.year_id = F.year_id
GROUP BY F.year_label;

-- part B real world taxation analysis

SELECT C.category_name,
SUM(I.amount) AS total_income
FROM Income_Record I
JOIN Income_Category C
ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY SUM(I.amount) DESC
LIMIT 1;

SELECT F.year_label,
SUM(I.amount) AS total_income
FROM Income_Record I
JOIN financial_Year F
ON I.year_id = F.year_id
GROUP BY F.year_label
ORDER BY SUM(I.amount) DESC
LIMIT 1;

SELECT C.category_name,
AVG(I.amount) AS average_income
FROM Income_Record I
JOIN Income_Category C
ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY AVG(I.amount) DESC
LIMIT 1;

SELECT C.category_name,
COUNT(*) AS number_of_records
FROM Income_Record I
JOIN Income_Category C
ON I.category_id = C.category_id
GROUP BY C.category_name
HAVING COUNT(*) > 2;

SELECT F.year_label,
SUM(I.amount) AS total_income
FROM Income_Record I
JOIN Financial_Year F
ON I.year_id = F.year_id
GROUP BY F.year_label
HAVING SUM(I.amount) > 1000000;

SELECT C.category_name,
COUNT(*) AS number_of_records,
SUM(I.amount) AS total_income,
AVG(I.amount) AS average_income,
MAX(I.amount) AS highest_income,
MIN(I.amount) AS lowest_income
FROM Income_Record I
JOIN Income_Category C
ON I.category_id = C.category_id
GROUP BY C.category_name;