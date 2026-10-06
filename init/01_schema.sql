\
CREATE TABLE customers (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    country     TEXT NOT NULL,
    active      BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE orders (
    id           BIGSERIAL PRIMARY KEY,
    customer_id  BIGINT REFERENCES customers(id),
    status       TEXT,
    amount       NUMERIC(10,2) NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL
);

CREATE TABLE employees (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    manager_id  BIGINT REFERENCES employees(id),
    department  TEXT NOT NULL
);

CREATE TABLE products (
    id       BIGSERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    category TEXT NOT NULL,
    price    NUMERIC(10,2) NOT NULL
);

CREATE TABLE sales (
    id          BIGSERIAL PRIMARY KEY,
    product_id  BIGINT REFERENCES products(id),
    quantity    INTEGER NOT NULL,
    sale_date   DATE NOT NULL
);

CREATE TABLE tickets (
    id           BIGSERIAL PRIMARY KEY,
    customer_id  BIGINT REFERENCES customers(id),
    status       TEXT NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL
);

CREATE TABLE blocks (
    id               BIGSERIAL PRIMARY KEY,
    blocked_user_id  BIGINT
);

CREATE TABLE events (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT,
    event_type  TEXT NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_sales_product_id ON sales(product_id);
CREATE INDEX idx_events_created_at ON events(created_at);
