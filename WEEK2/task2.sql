use madhavi;
ALTER TABLE Income_Record
DROP COLUMN category_name,
DROP COLUMN financial_year;
ALTER TABLE Income_Record
ADD category_id INT,
ADD year_id INT;
ALTER TABLE Income_Record
ADD CONSTRAINT fk_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES Taxpayer(taxpayer_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id)
REFERENCES Income_Category(category_id);
ALTER TABLE Income_Record
ADD CONSTRAINT fk_year
FOREIGN KEY (year_id)
REFERENCES Financial_Year(year_id);
UPDATE Income_Record ir
JOIN Income_Category ic
ON ir.category_name = ic.category_name
SET ir.category_id = ic.category_id;
UPDATE Income_Record ir
JOIN Financial_Year fy
ON ir.financial_year = fy.financial_year
SET ir.year_id = fy.year_id;
DESCRIBE Income_Record;
INSERT INTO Income_Record(
income_id,taxpayer_id,income_source,amount,received_date,category_id,year_id)
VALUES
(100,999,'salary',50000.00,'2026-08-03',1,1);
INSERT INTO Income_Record(
income_id,taxpayer_id,income_source,amount,received_date,category_id,year_id)
VALUES
(101,1,'salary',45000.00,'2026-08-03',20,1);
INSERT INTO Income_Record(
income_id,taxpayer_id,income_source,amount,received_date,category_id,year_id)
VALUES
(102,1,'salary',45000.00,'2026-08-03',1,15);
DELETE FROM Taxpayer WHERE taxpayer_id=101;
DELETE FROM Income_Category WHERE category_id=1;

-- Part C
SELECT DISTINCT occupation FROM Taxpayer;
SELECT DISTINCT category_name FROM Income_Category;
SELECT DISTINCT year_label FROM Financial_Year;
SELECT DISTINCT income_source FROM Income_Record;

-- Part D
SELECT t.full_name FROM Taxpayer t JOIN Income_Record i ON t.taxpayer_id=i.taxpayer_id WHERE i.category_id=1
UNION
SELECT t.full_name FROM Taxpayer t JOIN Income_Record i ON t.taxpayer_id=i.taxpayer_id WHERE i.category_id=2;
SELECT income_source FROM Income_Record WHERE year_id=5
UNION
SELECT income_source FROM Income_Record WHERE year_id=6;
SELECT full_name FROM Taxpayer WHERE occupation='Teacher'
UNION
SELECT full_name FROM Taxpayer WHERE occupation='Software Engineer';

-- Part E (INTERSECT replacement)
SELECT DISTINCT t.full_name FROM Taxpayer t
WHERE t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE category_id=1)
AND t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE category_id=2);

SELECT DISTINCT t.full_name FROM Taxpayer t
WHERE t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE year_id=5)
AND t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE year_id=6);

-- Part F (EXCEPT replacement)
SELECT DISTINCT t.full_name FROM Taxpayer t
WHERE t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE category_id=1)
AND t.taxpayer_id NOT IN (SELECT taxpayer_id FROM Income_Record WHERE category_id=2);

SELECT DISTINCT t.full_name FROM Taxpayer t
WHERE t.taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE year_id=6)
AND t.taxpayer_id NOT IN (SELECT taxpayer_id FROM Income_Record WHERE year_id=5);

-- Part G
SELECT * FROM Taxpayer WHERE occupation IN (SELECT occupation FROM Taxpayer WHERE taxpayer_id IN (SELECT taxpayer_id FROM Income_Record WHERE category_id=2));
SELECT full_name FROM Taxpayer WHERE taxpayer_id IN (SELECT taxpayer_id FROM Income_Record);

-- Part H
SELECT * FROM Taxpayer WHERE taxpayer_id NOT IN (SELECT taxpayer_id FROM Income_Record);
SELECT DISTINCT occupation FROM Taxpayer WHERE occupation NOT IN (SELECT t.occupation FROM Taxpayer t JOIN Income_Record i ON t.taxpayer_id=i.taxpayer_id);

-- Part I
SELECT * FROM Taxpayer t WHERE EXISTS(SELECT 1 FROM Income_Record i WHERE i.taxpayer_id=t.taxpayer_id);
SELECT * FROM Financial_Year y WHERE EXISTS(SELECT 1 FROM Income_Record i WHERE i.year_id=y.year_id);

-- Part J
SELECT * FROM Taxpayer t WHERE NOT EXISTS(SELECT 1 FROM Income_Record i WHERE i.taxpayer_id=t.taxpayer_id);
SELECT * FROM Income_Category c WHERE NOT EXISTS(SELECT 1 FROM Income_Record i WHERE i.category_id=c.category_id);

-- Part K
SELECT * FROM Taxpayer WHERE annual_income>ANY(SELECT annual_income FROM Taxpayer WHERE occupation='Teacher');
SELECT * FROM Taxpayer WHERE annual_income>ANY(SELECT amount FROM Income_Record WHERE category_id=2);

-- Part L
SELECT * FROM Taxpayer WHERE annual_income>ALL(SELECT annual_income FROM Taxpayer WHERE occupation='Teacher');
SELECT * FROM Taxpayer WHERE annual_income>ALL(SELECT amount FROM Income_Record WHERE category_id=2);

-- Part M
SELECT * FROM Taxpayer ORDER BY full_name;
SELECT * FROM Taxpayer WHERE annual_income>800000;
SELECT * FROM Taxpayer WHERE occupation='Software Engineer';
SELECT * FROM Income_Record WHERE category_id=2;
SELECT * FROM Income_Record WHERE amount BETWEEN 500000 AND 1000000;
SELECT * FROM Taxpayer WHERE full_name LIKE 'A%';
SELECT * FROM Taxpayer WHERE is_active=TRUE;
SELECT COUNT(*) FROM Taxpayer;
SELECT MAX(annual_income) FROM Taxpayer;

-- Part N
SELECT full_name,annual_income FROM Taxpayer ORDER BY annual_income DESC LIMIT 1;
SELECT c.category_name,COUNT(*) total FROM Income_Record i JOIN Income_Category c ON i.category_id=c.category_id GROUP BY c.category_name ORDER BY total DESC LIMIT 1;
SELECT occupation,COUNT(*) FROM Taxpayer GROUP BY occupation;
SELECT COUNT(*) FROM Taxpayer WHERE is_active=TRUE;
SELECT y.year_label,COUNT(*) total FROM Income_Record i JOIN Financial_Year y ON i.year_id=y.year_id GROUP BY y.year_label ORDER BY total DESC LIMIT 1;




