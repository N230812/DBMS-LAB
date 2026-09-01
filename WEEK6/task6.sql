use madhavi;
-- part A Level-1 task1
SELECT * FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
-- task2
SELECT * FROM Income_Record
WHERE amount = (
    SELECT MIN(amount)
    FROM Income_Record
);
-- task3
SELECT * FROM Income_Record
WHERE amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
-- task4
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
-- task5
SELECT * FROM Taxpayer
WHERE occupation='Business Owner';
-- Level-2 task1
SELECT *
FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
);
-- task2
SELECT DISTINCT t.*
FROM taxpayer AS t
JOIN income_record AS ir
    ON t.taxpayer_id = ir.taxpayer_id
JOIN `income_category` AS ic
    ON ir.category_id = ic.category_id
WHERE ic.category_name = 'business';
-- task3
SELECT I.*
FROM Income_Record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
WHERE F.year_label = '2025-2026';
-- task4
SELECT I.*
FROM Income_Record I
WHERE I.amount > (
    SELECT MIN(I2.amount)
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Business'
);
-- task5
SELECT I.*
FROM Income_Record I
WHERE I.amount < (
    SELECT MAX(I2.amount)
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Salary'
);
-- task6
SELECT DISTINCT T.*
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
WHERE I.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
-- task7
SELECT DISTINCT C.*
FROM Income_Category C
JOIN Income_Record I
    ON C.category_id = I.category_id;
-- task8
SELECT *
FROM Taxpayer T
WHERE T.taxpayer_id NOT IN (
    SELECT I.taxpayer_id
    FROM Income_Record I
    JOIN Income_Category C
        ON I.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);

-- Level-3 task1
SELECT DISTINCT T.*
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
WHERE I.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
-- task2
SELECT I.*
FROM Income_Record I
WHERE I.amount > (
    SELECT AVG(I2.amount)
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Business'
);
-- task3
SELECT DISTINCT T.*
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
WHERE I.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

-- task4
SELECT I.*
FROM Income_Record I
WHERE I.amount > ANY (
    SELECT I2.amount
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);
-- task5
SELECT I.*
FROM Income_Record I
WHERE I.amount > ALL (
    SELECT I2.amount
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);
-- task6
SELECT *
FROM Income_Category C
WHERE C.category_id IN (
    SELECT I.category_id
    FROM Income_Record I
    WHERE I.amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);
-- task7
SELECT F.*
FROM Financial_Year F
WHERE F.year_id IN (
    SELECT I.year_id
    FROM Income_Record I
    GROUP BY I.year_id
    HAVING SUM(I.amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT year_id,
                   SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY year_id
        ) AS T
    )
);
-- part8
SELECT T.taxpayer_id,
       T.full_name,
       SUM(I.amount) AS total_income
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
GROUP BY T.taxpayer_id, T.full_name
HAVING SUM(I.amount) > (
    SELECT AVG(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS A
);

-- task1
SELECT DISTINCT T.*
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
WHERE I.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
-- task2
SELECT DISTINCT T.*
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
WHERE I.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);
-- task3
SELECT C.*
FROM Income_Category C
JOIN Income_Record I
    ON C.category_id = I.category_id
WHERE I.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);
-- task4
SELECT *
FROM Taxpayer T
WHERE T.taxpayer_id IN (
    SELECT I.taxpayer_id
    FROM Income_Record I
    JOIN Income_Category C
        ON I.category_id = C.category_id
    WHERE C.category_name = 'Business'
)
AND T.taxpayer_id NOT IN (
    SELECT I.taxpayer_id
    FROM Income_Record I
    JOIN Income_Category C
        ON I.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);
-- task5
SELECT I.*
FROM Income_Record I
WHERE I.amount > ALL (
    SELECT I2.amount
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);
-- task6
SELECT I.*
FROM Income_Record I
WHERE I.amount > ANY (
    SELECT I2.amount
    FROM Income_Record I2
    JOIN Income_Category C
        ON I2.category_id = C.category_id
    WHERE C.category_name = 'Investment'
);
-- task7
SELECT T.taxpayer_id,
       T.full_name,
       SUM(I.amount) AS total_income
FROM Taxpayer T
JOIN Income_Record I
    ON T.taxpayer_id = I.taxpayer_id
GROUP BY T.taxpayer_id, T.full_name
HAVING SUM(I.amount) = (
    SELECT MAX(total_income)
    FROM (
        SELECT taxpayer_id,
               SUM(amount) AS total_income
        FROM Income_Record
        GROUP BY taxpayer_id
    ) AS A
);
-- part8
SELECT I.*
FROM Income_Record I
JOIN (
    SELECT category_id,
           AVG(amount) AS average_income
    FROM Income_Record
    GROUP BY category_id
) AS A
    ON I.category_id = A.category_id
WHERE I.amount > A.average_income;
SELECT * FROM Taxpayer;
SELECT * FROM Income_Record;
SELECT * FROM Income_Category;
SELECT * FROM Financial_Year;

