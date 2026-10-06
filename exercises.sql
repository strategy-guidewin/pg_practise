\
POSTGRESQL INTERVIEW PRACTICE LAB
=================================

Run the database, then fix these queries.

Try to explain:
1. What is wrong?
2. What incorrect result can it produce?
3. What is the corrected SQL?
4. Is the issue correctness, performance, or both?

--------------------------------------------------
1. AND / OR precedence
--------------------------------------------------

-- Requirement:
-- Return active customers in Ireland or the UK.

SELECT id, name, country, active
FROM customers
WHERE active = true
  AND country = 'IE'
   OR country = 'UK';


--------------------------------------------------
2. NOT IN and NULL
--------------------------------------------------

-- Requirement:
-- Return customers who have never placed an order.

SELECT id, name
FROM customers
WHERE id NOT IN (
    SELECT customer_id
    FROM orders
);


--------------------------------------------------
3. LEFT JOIN filter bug
--------------------------------------------------

-- Requirement:
-- Show every customer and any PAID orders they may have.

SELECT c.id,
       c.name,
       o.id AS order_id,
       o.created_at
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
WHERE o.status = 'PAID';


--------------------------------------------------
4. COUNT(*) with LEFT JOIN
--------------------------------------------------

-- Requirement:
-- Show every customer and the number of orders they have.

SELECT c.id,
       c.name,
       COUNT(*) AS order_count
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
GROUP BY c.id, c.name;


--------------------------------------------------
5. NULL comparison
--------------------------------------------------

-- Requirement:
-- Find employees who do not have a manager.

SELECT id, name
FROM employees
WHERE manager_id = NULL;


--------------------------------------------------
6. CASE order bug
--------------------------------------------------

-- Requirement:
-- Classify order values:
-- <= 100 = Small
-- > 100 and <= 1000 = Large
-- > 1000 = Very Large

SELECT id,
       amount,
       CASE
         WHEN amount > 100 THEN 'Large'
         WHEN amount > 1000 THEN 'Very Large'
         ELSE 'Small'
       END AS order_size
FROM orders;


--------------------------------------------------
7. AND / OR precedence again
--------------------------------------------------

-- Requirement:
-- Return PAID or REFUNDED orders over €100.

SELECT id,
       customer_id,
       status,
       amount
FROM orders
WHERE status = 'PAID'
  AND amount > 100
   OR status = 'REFUNDED';


--------------------------------------------------
8. Date-range logic bug
--------------------------------------------------

-- Requirement:
-- Return orders created in the last 30 days.

SELECT id, customer_id, created_at
FROM orders
WHERE created_at <= now() - interval '30 days';


--------------------------------------------------
9. "No recent orders" logic bug
--------------------------------------------------

-- Requirement:
-- Return customers who have placed no orders in the last 30 days.

SELECT c.id, c.name
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
WHERE o.created_at < now() - interval '30 days'
   OR o.created_at IS NULL;


--------------------------------------------------
10. SUM with LEFT JOIN
--------------------------------------------------

-- Requirement:
-- Show every customer and total value of their PAID orders.
-- Customers with no paid orders should display 0.

SELECT c.id,
       c.name,
       SUM(o.amount) AS total_paid
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
WHERE o.status = 'PAID'
GROUP BY c.id, c.name;


--------------------------------------------------
11. Inclusive range
--------------------------------------------------

-- Requirement:
-- Return orders with an amount between €100 and €500 inclusive.

SELECT id, amount
FROM orders
WHERE amount > 100
  AND amount < 500;


--------------------------------------------------
12. Conditions that cannot be true on one row
--------------------------------------------------

-- Requirement:
-- Return customers who have at least one PAID order
-- and at least one REFUNDED order.

SELECT DISTINCT c.id, c.name
FROM customers c
JOIN orders o
  ON o.customer_id = c.id
WHERE o.status = 'PAID'
  AND o.status = 'REFUNDED';


--------------------------------------------------
13. NULL semantics with <>
--------------------------------------------------

-- Requirement:
-- Return employees whose manager is not employee 8.
-- Employees with no manager should also be returned.

SELECT id, name, manager_id
FROM employees
WHERE manager_id <> 8;


--------------------------------------------------
14. Aggregate in WHERE
--------------------------------------------------

-- Requirement:
-- Return customers with more than 3 orders.

SELECT c.id,
       c.name,
       COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
WHERE COUNT(o.id) > 3
GROUP BY c.id, c.name;


--------------------------------------------------
BONUS 1. Latest order per customer
--------------------------------------------------

-- Requirement:
-- Return one row per customer containing the latest order,
-- including amount.

SELECT customer_id,
       MAX(created_at) AS latest_order,
       amount
FROM orders
GROUP BY customer_id, amount;


--------------------------------------------------
BONUS 2. Function on indexed column
--------------------------------------------------

-- Requirement:
-- Return all events created during 2026.

SELECT *
FROM events
WHERE EXTRACT(YEAR FROM created_at) = 2026;

-- This returns the right rows.
-- The question is: why might this be worse for an index on created_at?


--------------------------------------------------
BONUS 3. Duplicate-producing join
--------------------------------------------------

-- Requirement:
-- Return each product once if it has had a sale in the last 30 days.

SELECT p.id, p.name
FROM products p
JOIN sales s
  ON s.product_id = p.id
WHERE s.sale_date >= CURRENT_DATE - 30;
