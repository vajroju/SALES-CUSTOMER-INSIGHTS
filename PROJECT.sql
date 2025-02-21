-- Project: Sales & Customer Insights Dashboard
-- Description: This SQL project analyzes e-commerce sales data to uncover revenue trends, top-selling products, customer segmentation, and churn analysis.

-- 1️⃣ Creating the sales_data table
CREATE TABLE sales_data (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    quantity_sold INT NOT NULL,
    sales_amount DECIMAL(10,2) NOT NULL
);

-- 2️⃣ Inserting sample data
INSERT INTO sales_data (order_date, customer_id, product_name, category, quantity_sold, sales_amount) VALUES
('2024-01-05', 101, 'Laptop', 'Electronics', 1, 1200.00),
('2024-01-12', 102, 'Smartphone', 'Electronics', 2, 1600.00),
('2024-02-01', 103, 'Headphones', 'Accessories', 3, 300.00),
('2024-02-15', 104, 'Office Chair', 'Furniture', 1, 250.00),
('2024-03-10', 105, 'Laptop', 'Electronics', 2, 2400.00);

-- 3️⃣ Revenue Trends Analysis
SELECT 
    DATE_TRUNCATE('month', order_date) AS month, 
    SUM(sales_amount) AS total_revenue
FROM sales_data
GROUP BY month
ORDER BY month;

-- 4️⃣ Top-Selling Products
SELECT 
    product_name, 
    SUM(quantity_sold) AS total_sold
FROM sales_data
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 10;

-- 5️⃣ Customer Segmentation (High-Value Customers)
SELECT 
    customer_id, 
    SUM(sales_amount) AS total_spent
FROM sales_data
GROUP BY customer_id
HAVING SUM(sales_amount) > 1000
ORDER BY total_spent DESC;

-- 6️⃣ Churn Analysis (Customers Who Haven’t Purchased Recently)
SELECT 
    customer_id, 
    MAX(order_date) AS last_purchase_date
FROM sales_data
GROUP BY customer_id
HAVING MAX(order_date) < DATE_SUB(CURDATE(), INTERVAL 90 DAY);
