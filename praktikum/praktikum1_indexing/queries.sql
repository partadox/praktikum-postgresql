-- File: queries.sql untuk Praktikum 1 - Indexing
-- Berisi query-query untuk mengukur performa dengan dan tanpa index

-- ===== QUERY UNTUK PENGUJIAN TANPA INDEX =====

-- Pastikan tidak ada index yang bisa mempengaruhi pengujian
DROP INDEX IF EXISTS idx_products_category;
DROP INDEX IF EXISTS idx_products_price;
DROP INDEX IF EXISTS idx_orders_date;
DROP INDEX IF EXISTS idx_customers_city;
DROP INDEX IF EXISTS idx_orders_customer_id;

-- Query 1: Filter berdasarkan kategori
SELECT COUNT(*) FROM products WHERE category = 'Elektronik';

-- Query 2: Filter berdasarkan range harga
SELECT * FROM products 
WHERE price BETWEEN 1000000 AND 5000000
LIMIT 100;

-- Query 3: Filter berdasarkan tanggal pesanan
SELECT o.order_id, o.customer_id, o.order_date 
FROM orders o 
WHERE o.order_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Query 4: Join tanpa index
SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
WHERE c.city = 'Jakarta'
LIMIT 100;

-- Query 5: Aggregate yang berat
SELECT p.category, COUNT(*) as total_products, AVG(p.price) as avg_price
FROM products p
GROUP BY p.category
ORDER BY total_products DESC;

-- ===== QUERY UNTUK PEMBUATAN INDEX =====

-- Index 1: B-Tree index untuk kategori produk
CREATE INDEX idx_products_category ON products(category);

-- Index 2: B-Tree index untuk range harga
CREATE INDEX idx_products_price ON products(price);

-- Index 3: B-Tree index untuk tanggal pesanan
CREATE INDEX idx_orders_date ON orders(order_date);

-- Index 4: Index untuk city pada tabel customers
CREATE INDEX idx_customers_city ON customers(city);

-- Index 5: Composite index untuk JOIN operation
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- ===== QUERY UNTUK PENGUJIAN DENGAN INDEX =====

-- Query 1: Filter berdasarkan kategori (dengan index)
EXPLAIN ANALYZE SELECT COUNT(*) FROM products WHERE category = 'Elektronik';

-- Query 2: Filter berdasarkan range harga (dengan index)
EXPLAIN ANALYZE SELECT * FROM products 
WHERE price BETWEEN 1000000 AND 5000000
LIMIT 100;

-- Query 3: Filter berdasarkan tanggal pesanan (dengan index)
EXPLAIN ANALYZE SELECT o.order_id, o.customer_id, o.order_date 
FROM orders o 
WHERE o.order_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Query 4: Join dengan index
EXPLAIN ANALYZE SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
WHERE c.city = 'Jakarta'
LIMIT 100;

-- Query 5: Aggregate dengan index
EXPLAIN ANALYZE SELECT p.category, COUNT(*) as total_products, AVG(p.price) as avg_price
FROM products p
GROUP BY p.category
ORDER BY total_products DESC;

-- ===== QUERY UNTUK INDEX LANJUTAN =====

-- Partial index untuk produk dengan stok rendah (stok < 10)
CREATE INDEX idx_products_low_stock ON products(product_id, stock_quantity) 
WHERE stock_quantity < 10;

-- Query pengujian partial index
EXPLAIN ANALYZE SELECT * FROM products 
WHERE stock_quantity < 10 
ORDER BY product_id;

-- Index menggunakan ekspresi untuk pencarian case-insensitive
CREATE INDEX idx_products_name_lower ON products(LOWER(name));

-- Query pengujian case-insensitive search
EXPLAIN ANALYZE SELECT * FROM products 
WHERE LOWER(name) LIKE '%laptop%';

-- BRIN Index untuk data berurutan (seperti timestamp)
CREATE INDEX idx_orders_date_brin ON orders USING BRIN(order_date);

-- Query pengujian BRIN index
EXPLAIN ANALYZE SELECT * FROM orders 
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31' 
ORDER BY order_date 
LIMIT 100;

-- Index untuk full-text search (jika PostgreSQL >= 9.6)
CREATE INDEX idx_products_description_gin ON products 
USING GIN(to_tsvector('english', description));

-- Query pengujian full-text search
EXPLAIN ANALYZE SELECT * FROM products 
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'quality & premium');

-- ===== QUERY UNTUK PENGUJIAN CONCURRENT =====

-- Save sebagai file terpisah untuk benchmark:
-- 1. query_before.sql tanpa index
-- 2. query_after.sql dengan index
