----------------------------------------------------------------------------------------------------
-- Select Version:
SELECT version();

----------------------------------------------------------------------------------------------------
-- Create Table
DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);

-- List Tables (cli)
\dt

----------------------------------------------------------------------------------------------------
SELECT * FROM cars;

----------------------------------------------------------------------------------------------------
-- Single Insertion
INSERT INTO cars (brand, model, year)
VALUES ('Ford', 'Mustang', 1964);

----------------------------------------------------------------------------------------------------
-- Multiple Insertions
INSERT INTO cars (brand, model, year)
VALUES
  ('Volvo', 'p1800', 1968),
  ('BMW', 'M1', 1978),
  ('Toyota', 'Celica', 1975);

-- INSERT 0 3 (return from Postgre)

----------------------------------------------------------------------------------------------------
SELECT brand, year FROM cars;
SELECT * FROM cars;

----------------------------------------------------------------------------------------------------
-- ALTER Tables/Add Column
ALTER TABLE cars
ADD color VARCHAR(255);

----------------------------------------------------------------------------------------------------
-- UPDATE table
UPDATE cars
SET color = 'red'
WHERE brand = 'Volvo';

UPDATE cars
SET color = 'white', year = 1970
WHERE brand = 'Toyota';

----------------------------------------------------------------------------------------------------
-- ALTER TABLE
-- Numbers can always be converted to text, but text can't always be converted to numbers
ALTER TABLE cars
ALTER COLUMN year TYPE VARCHAR(4);

----------------------------------------------------------------------------------------------------
-- DROP COLUMN
ALTER TABLE cars
DROP COLUMN color;

----------------------------------------------------------------------------------------------------
-- DELETE
-- DELETE FROM cars; --> Delete all records
DELETE FROM cars
WHERE brand = 'Volvo';

----------------------------------------------------------------------------------------------------
-- TRUNCATE TABLE
-- delete all records
TRUNCATE TABLE cars;

----------------------------------------------------------------------------------------------------
--DROP TABLE
DROP TABLE cars;

----------------------------------------------------------------------------------------------------
-- WHERE Clause Operators
-- =	Equal to
-- <	Less than
-- >	Greater than
-- <=	Less than or equal to
-- >=	Greater than or equal to
-- <>	Not equal to
-- !=	Not equal to
-- LIKE	Check if a value matches a pattern (case sensitive)
-- ILIKE	Check if a value matches a pattern (case insensitive)
-- AND	Logical AND
-- OR	Logical OR
-- IN	Check if a value is between a range of values
-- BETWEEN	Check if a value is between a range of values
-- IS NULL	Check if a value is NULL
-- NOT	Makes a negative result e.g. NOT LIKE, NOT IN, NOT BETWEEN


SELECT * FROM orders WHERE order_date > '2023-05-05';
SELECT * FROM products WHERE category_id = 5;
SELECT * FROM orders WHERE order_date <= '2021-07-08';
SELECT * FROM categories WHERE category_name <> 'Beverages';
SELECT * FROM categories WHERE category_name != 'Meat/Poultry';
SELECT * FROM categories WHERE category_name LIKE 'D%';
SELECT * FROM categories WHERE category_name ILIKE 'c%';
SELECT * FROM products WHERE category_id = 4 AND price = 32.00;
SELECT * FROM products WHERE category_id = 8 OR price = 9.50;
SELECT * FROM categories WHERE category_name IN ('Beverages', 'Grains/Cereals', 'Meat/Poultry');
SELECT * FROM orders WHERE order_date BETWEEN '2021-07-05' AND '2021-07-09';
SELECT * FROM categories WHERE description IS NOT NULL;
SELECT * FROM categories WHERE category_name NOT LIKE 'C%';
SELECT * FROM categories WHERE category_name NOT ILIKE 'p%';
SELECT * FROM orders WHERE order_date NOT BETWEEN '2021-07-08' AND '2023-05-05';

----------------------------------------------------------------------------------------------------
-- Specify Columns
SELECT product_name, unit FROM products;

-- DISTINCT
SELECT DISTINCT category_id from testproducts;

--COUNT
SELECT COUNT(DISTINCT category_id) from testproducts;

----------------------------------------------------------------------------------------------------
-- WHERE CLAUSE
SELECT customer_name FROM customers WHERE customer_id = 3;
SELECT customer_name FROM customers WHERE customer_id >= 70;
SELECT customer_name FROM customers WHERE contact_name = 'Ana Trujillo';

----------------------------------------------------------------------------------------------------
-- ORDER BY
-- Numeric
SELECT * FROM products ORDER BY price;
SELECT * FROM products ORDER BY price DESC;

-- Alphabetical
SELECT * FROM products ORDER BY product_name;
SELECT * FROM products ORDER BY product_name DESC;

----------------------------------------------------------------------------------------------------
-- LIMIT
SELECT * FROM products ORDER BY price LIMIT 5;

-- OFFSET
-- start at 16th cheapest product, get 5
SELECT * FROM products ORDER BY price LIMIT 5 OFFSET 15;

----------------------------------------------------------------------------------------------------
-- MIN
SELECT MIN(price) FROM products;

-- MAX
SELECT MAX(price) FROM products;

----------------------------------------------------------------------------------------------------
-- ALIAS
SELECT MIN(price) AS lowest_price FROM products;
SELECT MAX(price) AS "highest price" FROM products;
SELECT customer_id id FROM customers;

-- Concat
SELECT product_name || unit AS product FROM products;
SELECT product_name || ' ' || unit AS product FROM products;

----------------------------------------------------------------------------------------------------
-- COUNT
SELECT COUNT(customer_id) FROM customers WHERE country = 'Germany';

-- SUM
SELECT SUM(quantity) FROM order_details;

-- AVG
SELECT AVG(price) FROM products;
-- AVG to 2 decimal points
SELECT AVG(price)::NUMERIC(10,2) FROM products; 

----------------------------------------------------------------------------------------------------
-- Starts With
SELECT * FROM customers WHERE customer_name LIKE 'A%';

-- Ends With
SELECT * FROM customers WHERE customer_name LIKE '%a';

-- Contains (case sensitive)
SELECT * FROM customers WHERE customer_name LIKE '%a%';

-- Contains (case insensitive)
SELECT * FROM customers WHERE customer_name ILIKE '%A%';

-- Wildcard (_)
SELECT * FROM customers WHERE city LIKE 'L_nd__';
SELECT * FROM customers WHERE country LIKE '_ana%';

-- IN (list of WHERE clause)
SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');

-- Negation
SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');

-- IN (SELECT)
-- In records from SELECT statment
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders);
SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- Between
-- Numeric
SELECT * FROM Products WHERE Price BETWEEN 10 AND 15;
-- Text
SELECT * FROM Products WHERE product_name BETWEEN 'Pavlova' AND 'Tofu' ORDER BY product_name;
-- Date
SELECT * FROM orders WHERE order_date BETWEEN '2023-04-12' AND '2023-05-05';

----------------------------------------------------------------------------------------------------
-- Joins
-- INNER JOIN -> matching records in both tables
-- JOIN parsed to INNER JOIN at statement execution
SELECT product_id, product_name, category_name FROM products INNER JOIN categories ON products.category_id = categories.category_id;
SELECT testproduct_id, product_name, category_name FROM testproducts JOIN categories ON testproducts.category_id = categories.category_id;

-- LEFT JOIN
-- All records from 'left' table, and matching records from 'right' table
-- 0 records from right side if no match
-- LEFT JOIN parsed to LEFT OUTER JOIN at statment execution
SELECT testproduct_id, product_name, category_name FROM testproducts LEFT JOIN categories ON testproducts.category_id = categories.category_id;

-- RIGHT JOIN
-- All records from 'right' table, and matching records from 'left' table
-- 0 records from left side if no match
SELECT testproduct_id, product_name, category_name FROM testproducts RIGHT JOIN categories ON testproducts.category_id = categories.category_id;

-- FULL JOIN
-- ALL records from both tables, regardless of match. If no match, NULL.
-- FULL JOIN == FULL OUTER JOIN
SELECT testproduct_id, product_name, category_name FROM testproducts FULL JOIN categories ON testproducts.category_id = categories.category_id;

-- CROSS JOIN
-- Match ALL records from 'left' table with EACH record of 'right' table.
-- For each left table entry, all right table entries
-- CROSS PRODUCT!
SELECT testproduct_id, product_name, category_name FROM testproducts CROSS JOIN categories;

----------------------------------------------------------------------------------------------------
-- UNION
-- Combine result sets from two or more queries
-- Rules:
-- 1. Result sets MUST have same number of columns
-- 2. Columns MUST have same data types
-- 3. Columns MUST be in same order
SELECT product_id, product_name FROM products UNION SELECT testproduct_id, product_name FROM testproducts ORDER BY product_id;

-- UNION vs UNION ALL
-- UNION ALL shows duplicates
SELECT product_id FROM products UNION SELECT testproduct_id FROM testproducts ORDER BY product_id; 
-- 77 Rows
SELECT product_id FROM products UNION ALL SELECT testproduct_id FROM testproducts ORDER BY product_id;
-- 87 rows

----------------------------------------------------------------------------------------------------
-- GROUP BY CLAUSE
-- Often used with aggregate functions such as COUNT(), MAX(), MIN(), AVG(), SUM()
-- Group result set by one or more columns
SELECT COUNT(customer_id), country FROM customers GROUP BY country;

-- GROUP BY with JOIN
SELECT customers.customer_name, COUNT(orders.order_id) FROM orders LEFT JOIN customers ON orders.customer_id = customers.customer_id GROUP BY customer_name;

----------------------------------------------------------------------------------------------------
-- HAVING Clause
-- WHERE cannot be used with aggregate functions.
-- Countries that have at least 5 customers
SELECT COUNT(customer_id), country FROM customers GROUP BY country HAVING COUNT(customer_id) > 5 ORDER BY country;
-- Orders that have a total price of $400 or more
SELECT order_details.order_id, SUM(products.price) FROM order_details LEFT JOIN products ON order_details.product_id = products.product_id GROUP BY order_id HAVING SUM(products.price) > 400.00;
-- Customers that have ordered $1000 or more
SELECT customers.customer_name, SUM(products.price) FROM order_details LEFT JOIN products ON order_details.product_id = products.product_id LEFT JOIN orders ON order_details.order_id = orders.order_id LEFT JOIN customers ON orders.customer_id = customers.customer_id GROUP BY customer_name HAVING SUM(products.price) > 1000.00;

----------------------------------------------------------------------------------------------------
-- EXISTS
-- test the existence of any record in a sub query
-- Returns TRUE if sub query returns one or more records
-- Find customers that have at least one order in the orders table:
SELECT customers.customer_name FROM customers WHERE EXISTS (SELECT order_id FROM orders WHERE customer_id = customers.customer_id);
SELECT customers.customer_name FROM customers WHERE NOT EXISTS (SELECT order_id FROM orders WHERE customer_id = customers.customer_id);

----------------------------------------------------------------------------------------------------
-- ANY Operator
-- Comparison between single column value and range of other values
-- Boolean result
-- Returns TRUE if ANY of the sub query values meets the condition
SELECT product_name 
FROM products 
WHERE product_id = ANY (
  SELECT product_id 
  FROM order_details 
  WHERE quantity > 120
);

----------------------------------------------------------------------------------------------------
-- ALL Operator
-- Boolean result
-- Returns TRUE if ALL of the sub query values meet the condition
-- used with SELECT, WHERE and HAVING statments
-- List the products if ALL records in order_details have a quantity larger than 10
SELECT product_name 
FROM products 
WHERE product_id = ALL (
  SELECT product_id 
  FROM order_details 
  WHERE quantity > 10
);

----------------------------------------------------------------------------------------------------
-- CASE Expression
-- IF/Else-If block
-- Once a condition is true, stop reading and return the result
-- If no conditions are true, return ELSE clause
-- If there is no ELSE clause, return NULL
SELECT product_name, 
CASE 
  WHEN price < 10 THEN 'Low price product' 
  WHEN price > 50 THEN 'High price product' 
  ELSE 'Normal product' 
END 
FROM products;

-- With Alias
-- After END keyword
SELECT product_name,
CASE
  WHEN price < 10 THEN 'Low price product'
  WHEN price > 50 THEN 'High price product'
ELSE
  'Normal product'
END AS "price category"
FROM products;