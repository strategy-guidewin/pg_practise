\
INSERT INTO customers (name, country, active, created_at) VALUES
('Alice',   'IE', TRUE,  now() - interval '400 days'),
('Bob',     'UK', FALSE, now() - interval '300 days'),
('Carol',   'IE', TRUE,  now() - interval '250 days'),
('David',   'FR', TRUE,  now() - interval '200 days'),
('Erin',    'UK', TRUE,  now() - interval '180 days'),
('Frank',   'IE', FALSE, now() - interval '150 days'),
('Grace',   'DE', TRUE,  now() - interval '120 days'),
('Helen',   'IE', TRUE,  now() - interval '100 days'),
('Ian',     'UK', TRUE,  now() - interval '90 days'),
('Jack',    'IE', TRUE,  now() - interval '60 days');

INSERT INTO orders (customer_id, status, amount, created_at) VALUES
(1, 'PAID',     120.00, now() - interval '5 days'),
(1, 'PAID',    1500.00, now() - interval '50 days'),
(1, 'REFUNDED',  80.00, now() - interval '100 days'),
(2, 'PAID',      50.00, now() - interval '2 days'),
(2, 'FAILED',   500.00, now() - interval '20 days'),
(3, 'PAID',     250.00, now() - interval '10 days'),
(3, 'REFUNDED', 300.00, now() - interval '15 days'),
(3, 'PAID',     450.00, now() - interval '40 days'),
(4, 'PENDING',  200.00, now() - interval '1 day'),
(5, 'PAID',    1100.00, now() - interval '70 days'),
(5, 'REFUNDED', 125.00, now() - interval '3 days'),
(6, 'FAILED',   700.00, now() - interval '200 days'),
(8, 'PAID',      99.00, now() - interval '8 days'),
(8, 'PAID',     100.00, now() - interval '7 days'),
(8, 'PAID',     500.00, now() - interval '6 days'),
(8, 'PAID',     501.00, now() - interval '5 days'),
(9, 'PAID',     200.00, now() - interval '35 days'),
(9, 'PAID',     300.00, now() - interval '34 days'),
(9, 'PAID',     400.00, now() - interval '33 days'),
(9, 'PAID',     500.00, now() - interval '32 days'),
(NULL, 'PAID',  999.00, now() - interval '4 days');

INSERT INTO employees (name, manager_id, department) VALUES
('CEO', NULL, 'Executive');

INSERT INTO employees (name, manager_id, department) VALUES
('Manager A', 1, 'Engineering'),
('Manager B', 1, 'Finance'),
('Engineer 1', 2, 'Engineering'),
('Engineer 2', 2, 'Engineering'),
('Analyst 1', 3, 'Finance'),
('Contractor', NULL, 'Operations'),
('Manager 10', 1, 'Operations');

INSERT INTO employees (name, manager_id, department) VALUES
('Worker A', 8, 'Operations'),
('Worker B', 8, 'Operations'),
('Worker C', 2, 'Engineering');

INSERT INTO products (name, category, price) VALUES
('Laptop', 'Hardware', 1200.00),
('Mouse', 'Hardware', 25.00),
('Keyboard', 'Hardware', 60.00),
('Database Course', 'Training', 300.00),
('Cloud Course', 'Training', 450.00);

INSERT INTO sales (product_id, quantity, sale_date) VALUES
(1,1,current_date - 5),
(1,2,current_date - 10),
(2,3,current_date - 3),
(4,1,current_date - 7),
(4,1,current_date - 15),
(5,2,current_date - 40);

INSERT INTO tickets (customer_id, status, created_at) VALUES
(1,'OPEN',now() - interval '3 days'),
(1,'CLOSED',now() - interval '20 days'),
(3,'OPEN',now() - interval '1 day'),
(5,'CLOSED',now() - interval '50 days');

INSERT INTO blocks (blocked_user_id) VALUES
(2),
(4),
(NULL);

INSERT INTO events (user_id, event_type, created_at) VALUES
(1,'LOGIN','2025-12-30 10:00:00+00'),
(1,'LOGIN','2026-01-02 10:00:00+00'),
(2,'PURCHASE','2026-05-01 11:00:00+00'),
(3,'LOGIN','2026-09-20 09:00:00+00'),
(4,'LOGOUT','2026-10-01 09:00:00+00');
