use madhavi;
SHOW tables;
--  part-B level 1 task1
SELECT t.full_name, i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT t.full_name, c.category_name
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;
SELECT i.income_source, i.amount, f.year_label
FROM Income_Record i
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
SELECT t.full_name, t.annual_income, i.amount
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;
SELECT t.full_name,
       i.income_source,
       c.category_name,
       f.year_label
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;

-- level2
SELECT t.full_name,
       i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary';
SELECT t.full_name,
       t.occupation,
       i.income_source
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';
SELECT t.full_name,
       t.pan_number,
       f.start_date,
       f.end_date
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
SELECT t.full_name,
       t.pan_number,
       c.description
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;
SELECT t.full_name,
       t.pan_number,
       t.occupation,
       i.income_source,
       c.category_name,
       i.amount,
       f.year_label,
       f.start_date,
       f.end_date
FROM Taxpayer t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;

-- level 3
DESCRIBE Income_Record;
SELECT T.taxpayer_id, T.full_name, I.income_source, I.amount
FROM Taxpayer T
LEFT JOIN Income_Record I
ON T.taxpayer_id = I.taxpayer_id;

SELECT C.category_id,
       C.category_name,
       I.income_source,
       I.amount
FROM Income_Record I
RIGHT JOIN Income_Category C
ON I.category_id = C.category_id;

SELECT T.taxpayer_id,
       T.full_name,
       I.income_id,
       I.income_source,
       I.amount
FROM Taxpayer T
LEFT JOIN Income_Record I
ON T.taxpayer_id = I.taxpayer_id

UNION

SELECT T.taxpayer_id,
       T.full_name,
       I.income_id,
       I.income_source,
       I.amount
FROM Taxpayer T
RIGHT JOIN Income_Record I
ON T.taxpayer_id = I.taxpayer_id;

SELECT T.taxpayer_id,
       T.full_name,
       F.year_label
FROM Taxpayer T
CROSS JOIN Financial_Year F;

SELECT A.full_name AS Taxpayer1,
       B.full_name AS Taxpayer2,
       A.occupation
FROM Taxpayer A
JOIN Taxpayer B
ON A.occupation = B.occupation
AND A.taxpayer_id < B.taxpayer_id;

