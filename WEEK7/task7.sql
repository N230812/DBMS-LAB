USE madhavi;
-- level-1 task1
CREATE OR REPLACE  VIEW 
highest_income_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_income_view;
-- task2
CREATE OR REPLACE VIEW lowest_income_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MIN(amount)
    FROM Income_Record
);
SELECT * FROM lowest_income_view;
-- task3
CREATE OR REPLACE VIEW above_average_income_view AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
SELECT * FROM above_average_income_view;
-- task4
CREATE OR REPLACE VIEW highest_income_records_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_income_records_view;
-- task5
CREATE OR REPLACE VIEW business_owner_view AS
SELECT taxpayer_id, full_name, occupation
FROM Taxpayer
WHERE occupation = 'business owner';
SELECT * FROM business_owner_view;
-- level-2 task1
CREATE OR REPLACE VIEW taxpayers_with_income AS
SELECT DISTINCT t.*
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT * FROM taxpayers_with_income;
-- task2
CREATE OR REPLACE VIEW business_income_taxpayers AS
SELECT DISTINCT t.*
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';
SELECT * FROM business_income_taxpayers;
-- task3
CREATE OR REPLACE VIEW income_2025_2026_view AS
SELECT i.*
FROM Income_Record i
INNER JOIN financial_year f
ON i.year_id = f.year_id
WHERE f.year_label = '2025-2026';
SELECT * FROM income_2025_2026_view;
-- task4
CREATE OR REPLACE VIEW greater_than_min_business_income AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT MIN(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);
SELECT * FROM greater_than_min_business_income;
-- task5
CREATE OR REPLACE VIEW less_than_max_salary_income AS
SELECT *
FROM Income_Record
WHERE amount < (
    SELECT MAX(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Salary'
);
SELECT * FROM less_than_max_salary_income;
-- task6
CREATE OR REPLACE VIEW taxpayers_above_average_income AS
SELECT DISTINCT t.taxpayer_id,
       t.full_name,
       i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
SELECT * FROM taxpayers_above_average_income;
-- task7
CREATE OR REPLACE VIEW categories_with_income AS
SELECT DISTINCT c.category_id,
       c.category_name
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id;
SELECT * FROM categories_with_income;
-- task8
CREATE OR REPLACE VIEW taxpayers_without_investment_income AS
SELECT t.taxpayer_id,
       t.full_name
FROM Taxpayer t
WHERE t.taxpayer_id NOT IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM taxpayers_without_investment_income;
-- level-3 task1
CREATE OR REPLACE VIEW highest_income_taxpayer AS
SELECT t.taxpayer_id,
       t.full_name,
       i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_income_taxpayer;
-- task2
CREATE OR REPLACE VIEW above_average_business_income AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(i.amount)
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);
SELECT * FROM above_average_business_income;
-- task3
CREATE OR REPLACE VIEW taxpayers_above_average_total AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS x
);
SELECT * FROM taxpayers_above_average_total;
-- task4
CREATE OR REPLACE VIEW greater_than_any_investment AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_any_investment;
-- task5
CREATE OR REPLACE VIEW greater_than_all_investment AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM greater_than_all_investment;
-- task6
CREATE OR REPLACE VIEW category_with_highest_income AS
SELECT DISTINCT c.category_id,
       c.category_name
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM category_with_highest_income;
-- task7
CREATE OR REPLACE VIEW highest_total_income_year AS
SELECT f.year_id,
       f.year_label,
       SUM(i.amount) AS total_income
FROM financial_year f
INNER JOIN Income_Record i
ON f.year_id = i.year_id
GROUP BY f.year_id, f.year_label
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT year_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY year_id
    ) AS x
);
SELECT * FROM highest_total_income_year;
-- task8
CREATE OR REPLACE VIEW taxpayers_total_above_average AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS x
);
SELECT * FROM taxpayers_total_above_average;
-- level-4 task1
CREATE OR REPLACE VIEW highest_individual_income_taxpayer AS
SELECT t.taxpayer_id,
       t.full_name,
       i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_individual_income_taxpayer;
-- task2
CREATE OR REPLACE VIEW taxpayers_above_overall_average AS
SELECT DISTINCT t.taxpayer_id,
       t.full_name,
       i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
SELECT * FROM taxpayers_above_overall_average;
-- task3
CREATE OR REPLACE VIEW highest_income_category AS
SELECT DISTINCT c.category_id,
       c.category_name
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_id = i.category_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
SELECT * FROM highest_income_category;
-- task4
CREATE OR REPLACE VIEW business_no_investment AS
SELECT t.taxpayer_id,
       t.full_name
FROM Taxpayer t
WHERE t.taxpayer_id IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
)
AND t.taxpayer_id NOT IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM business_no_investment;
-- task5
CREATE OR REPLACE VIEW income_greater_than_every_investment AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM income_greater_than_every_investment;
-- task6
CREATE OR REPLACE VIEW income_greater_than_any_investment AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT i.amount
    FROM Income_Record i
    INNER JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Investment'
);
SELECT * FROM income_greater_than_any_investment;
-- task7
CREATE OR REPLACE VIEW highest_total_income_taxpayers AS
SELECT t.taxpayer_id,
       t.full_name,
       SUM(i.amount) AS total_income
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name
HAVING SUM(i.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS x
);
SELECT * FROM highest_total_income_taxpayers;
-- task8
CREATE OR REPLACE VIEW income_above_category_average AS
SELECT i.*
FROM Income_Record i
INNER JOIN (
    SELECT category_id,
           AVG(amount) AS average_income
    FROM Income_Record
    GROUP BY category_id
) AS a
ON i.category_id = a.category_id
WHERE i.amount > a.average_income;
SELECT * FROM income_above_category_average;

