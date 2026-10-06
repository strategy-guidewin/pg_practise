\
ANSWER KEY
==========

1.
WHERE active = true
  AND country IN ('IE', 'UK');

2.
SELECT c.id, c.name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
);

3.
SELECT c.id,
       c.name,
       o.id AS order_id,
       o.created_at
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
 AND o.status = 'PAID';

4.
COUNT(o.id)

Full form:

SELECT c.id,
       c.name,
       COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
GROUP BY c.id, c.name;

5.
WHERE manager_id IS NULL;

6.
CASE
  WHEN amount > 1000 THEN 'Very Large'
  WHEN amount > 100 THEN 'Large'
  ELSE 'Small'
END

7.
WHERE status IN ('PAID', 'REFUNDED')
  AND amount > 100;

8.
WHERE created_at >= now() - interval '30 days';

9.
SELECT c.id, c.name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
      AND o.created_at >= now() - interval '30 days'
);

10.
SELECT c.id,
       c.name,
       COALESCE(SUM(o.amount), 0) AS total_paid
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
 AND o.status = 'PAID'
GROUP BY c.id, c.name;

11.
WHERE amount >= 100
  AND amount <= 500;

or:

WHERE amount BETWEEN 100 AND 500;

12.
SELECT c.id, c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
      AND o.status = 'PAID'
)
AND EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
      AND o.status = 'REFUNDED'
);

13.
PostgreSQL-specific:

WHERE manager_id IS DISTINCT FROM 8;

Portable:

WHERE manager_id <> 8
   OR manager_id IS NULL;

14.
Move aggregate predicate to HAVING:

SELECT c.id,
       c.name,
       COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 3;

BONUS 1.
PostgreSQL DISTINCT ON:

SELECT DISTINCT ON (customer_id)
       customer_id,
       created_at AS latest_order,
       amount
FROM orders
ORDER BY customer_id, created_at DESC;

BONUS 2.
EXTRACT() applies a function to the indexed column and may prevent an
efficient range scan using a normal B-tree index on created_at.

Better:

WHERE created_at >= TIMESTAMPTZ '2026-01-01 00:00:00+00'
  AND created_at <  TIMESTAMPTZ '2027-01-01 00:00:00+00';

BONUS 3.
Use EXISTS if you only need to test whether a sale exists:

SELECT p.id, p.name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.product_id = p.id
      AND s.sale_date >= CURRENT_DATE - 30
);
