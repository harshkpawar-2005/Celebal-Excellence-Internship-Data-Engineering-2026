-- Index on customers table
CREATE INDEX idx_customers_city
ON customers(city);

CREATE INDEX idx_customers_state
ON customers(state);

-- Index on products table
CREATE INDEX idx_products_category
ON products(category);

-- Index on orders table
CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(status);