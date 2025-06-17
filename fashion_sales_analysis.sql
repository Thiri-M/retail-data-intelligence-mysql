CREATE DATABASE fashion_sales;

USE fashion_sales;

-- CREATE TABLE AND DATA LOAD: stores, products, employees, promotion, customers, transactions
-- Includes primary key, foreign key constraints and proper data types

CREATE TABLE IF NOT EXISTS stores
(
	store_id INT NOT NULL PRIMARY KEY,
    country VARCHAR(100),
    city VARCHAR(100),
    store_name VARCHAR(100),
    no_of_employees INT,
    zipcode INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stores.csv"
INTO TABLE stores
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS products
(
	product_id INT NOT NULL PRIMARY KEY,
    category VARCHAR(100),
    sub_category VARCHAR(255),
    description_EN VARCHAR(255),
    color VARCHAR(100),
    size VARCHAR(100),
    production_cost DECIMAL(10,2)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv"
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS employees
(
	employee_id INT NOT NULL PRIMARY KEY,
    store_id INT,
    employee_name VARCHAR(100),
    positions VARCHAR(100),
    FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv"
INTO TABLE employees
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS promotion
(
	start_date DATE,
    end_date DATE,
    discount DECIMAL(3,2),
    campaign VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(255)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/promotion.csv"
INTO TABLE promotion
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS customers
(
	customer_id INT NOT NULL PRIMARY KEY,
    cust_name VARCHAR(50),
    email VARCHAR(50),
    tel VARCHAR(50),
    city VARCHAR(100),
    country VARCHAR(100),
    gender VARCHAR(5),
    date_of_birth DATE,
    job_title VARCHAR(100)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv"
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS transactions
(
	invoice_id VARCHAR(100),
    line INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    size VARCHAR(100),
    color VARCHAR(100),
    unit_price DECIMAL(7,2),
    quantity INT NOT NULL,
    trn_date DATETIME,
    discount DECIMAL(3,2),
    line_total DECIMAL(10,2),
    store_id INT NOT NULL,
    employee_id INT NOT NULL,
    currency VARCHAR(10),
    sku VARCHAR(255),
    trn_type VARCHAR(50),
    payment_method VARCHAR(50),
    invoice_total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv"
INTO TABLE transactions
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- =============== BUSINESS ANALYSIS =============== --

# Q.1: Highest and Lowest Performing Stores by Sales, Average Orders Value and Sales per Employee
-- Identifies which city/store drives the most revenue
-- Calculates average order value and sales-per-employee for performance benchmarking
-- Ranks stores by total revenue

WITH sales AS
	(SELECT
		t.store_id,
		s.city,
		COUNT(t.invoice_id) AS no_of_transaction,
		SUM(t.line_total) AS total_revenue
    FROM transactions t
    JOIN stores s ON t.store_id = s.store_id
    GROUP BY t.store_id, s.city),

employee AS
	(SELECT
		s.store_id,
        COUNT(DISTINCT e.employee_id) AS no_of_employee
    FROM employees e
    JOIN stores s ON e.store_id = s.store_id
    GROUP BY s.store_id)

SELECT
	sa.store_id,
    sa.city,
    ep.no_of_employee,
    sa.no_of_transaction,
    sa.total_revenue,    
    ROUND(sa.total_revenue * 1.0 / sa.no_of_transaction, 2) AS avg_transaction_value,
    ROUND(sa.total_revenue * 1.0 / ep.no_of_employee, 2) AS sales_per_employee,
    RANK() OVER (ORDER BY sa.total_revenue DESC) AS sales_ranking
FROM sales sa
JOIN employee ep ON sa.store_id = ep.store_id;

# Q.2: Peak Sales Hours & Day per Week
-- Optimizes staff schedules
-- Targets high-traffic hours for flash promotions

SELECT 
	HOUR(trn_date) AS sales_hours,
    SUM(line_total) AS total_sales,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY sales_hours
ORDER BY total_sales DESC;

-- Highlights most profitable weekdays for inventory restock or marketing push

SELECT
    DAYOFWEEK(trn_date) AS sales_weekday,
    SUM(line_total) AS total_sales,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY sales_weekday
ORDER BY total_sales DESC;

# Q.3: Most Frequent Payment Methods
-- Understands customer payment method preferences
-- Guiding payment infrastructure experience optimization

SELECT
	t.store_id,
    s.store_name,
    t.payment_method,
    COUNT(*) AS frequency_used
FROM transactions t
JOIN stores s
ON t.store_id = s.store_id
GROUP BY t.store_id, t.payment_method
ORDER BY frequency_used, s.store_id DESC;

# Q.4: Sales vs Return per Store
-- Assesses product or store-related return issues
-- Helps detect fraud or poor product fit

SELECT
	s.store_id,
    s.store_name,
    SUM(CASE WHEN t.trn_type = "Sale" THEN t.line_total ELSE 0 END) AS total_sales,
	SUM(CASE WHEN t.trn_type = "Return" THEN t.line_total ELSE 0 END) AS total_returns,
    SUM(t.line_total) AS total_netsales
FROM transactions t
JOIN stores s
ON t.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

# Q.5: Store Manager Impact on Sales
-- Evaluates leadership effective
-- Supports HR decisions on managerial promotion

SELECT
	s.store_id,
    s.store_name,
    e.employee_name AS store_manager,
    SUM(t.line_total) AS total_sales
FROM transactions t
JOIN stores s
ON t.store_id = s.store_id
LEFT JOIN employees e
ON t.store_id = e.store_id AND e.positions = "Store Manager"
GROUP BY store_id, store_name, employee_name
ORDER BY total_sales DESC;

# Q.6: Employee Performance: Highest Sales Efficiency by Employee
-- Recognizes top performers
-- Supports incentive or training programs

SELECT 
    e.employee_id,
    e.employee_name,
    e.positions,
    s.store_name,
    s.city,
    SUM(line_total) AS totalsales,
    COUNT(DISTINCT customer_id) AS customercount,
    COUNT(invoice_id) AS transcount,
    SUM(quantity) AS totalqty,
    COUNT(DISTINCT product_id) AS no_sku
FROM transactions t
JOIN employees e ON t.employee_id = e.employee_id
JOIN stores s ON e.store_id = s.store_id
GROUP BY employee_id
ORDER BY totalsales DESC
LIMIT 5;

# Q.7: Store size vs Discount Behavior
-- Measures if large team lead to more or deeper discounts
-- Balances profitability vs conversion strategies

WITH store_size AS 
	(SELECT 
        store_id,
        COUNT(DISTINCT employee_id) AS num_employees
    FROM employees
    GROUP BY store_id),
discount_stats AS 
	(SELECT 
        t.store_id,
        COUNT(*) AS total_transactions,
        COUNT(CASE WHEN t.discount > 0 THEN 1 END) AS discounted_transactions,
        AVG(CASE WHEN t.discount > 0 THEN t.discount ELSE NULL END) AS avg_discount
    FROM transactions t
    GROUP BY t.store_id)
SELECT 
    s.store_id,
    s.num_employees,
    d.total_transactions,
    d.discounted_transactions,
    ROUND(1 * d.discounted_transactions / d.total_transactions, 2) AS discount_frequency,
    ROUND(d.avg_discount, 2) AS average_discount
FROM store_size s
JOIN discount_stats d ON s.store_id = d.store_id
ORDER BY s.num_employees DESC;

# Q.8: Customer Demographics by Product Category
-- Analyze how customer age, gender, and city relate to product category and spending power
-- Enables target product marketing and segmentation

-- Step 1: Create a CTE to enrich transaction data with customer demographics and product info
WITH customerdetails AS 
	(SELECT 
        t.customer_id,
        c.gender,
        c.city,
        p.category,
        t.line_total,
        TIMESTAMPDIFF(YEAR, date_of_birth, curdate()) AS age
    FROM transactions t
    JOIN customers c ON t.customer_id = c.customer_id
    JOIN products p ON t.product_id = p.product_id),

-- Step 2: Identify top city per category by transaction count
cityrank AS
    (SELECT 
        category,
        city,
        COUNT(*) AS transaction_count,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS ranks
    FROM customerdetails
    GROUP BY category, city)

-- Step 3: Aggregate customer insights and join with top city
SELECT 
    cd.category,

    -- Demographics
    ROUND(AVG(cd.age)) AS avg_customer_age,
    COUNT(DISTINCT cd.customer_id) AS unique_customers,

    -- Gender breakdown
    SUM(CASE WHEN cd.gender = 'M' THEN 1 ELSE 0 END) AS male_customers,
    SUM(CASE WHEN cd.gender = 'F' THEN 1 ELSE 0 END) AS female_customers,
    SUM(CASE WHEN cd.gender = 'D' THEN 1 ELSE 0 END) AS diverse_customers,

    -- Spending
    ROUND(AVG(cd.line_total),2) AS avg_transaction_value,
    SUM(cd.line_total) AS total_sales,

    -- Top city
    cr.city AS top_city

FROM customerdetails cd
LEFT JOIN cityrank cr  
    ON cd.category = cr.category AND cr.ranks = 1

GROUP BY cd.category, cr.city
ORDER BY total_sales DESC;

# Q.9: Product Performance Analysis: Highest Revenue Categories
-- Analyze categories to help prioritize perfroming product lines
-- Guides inventory planning

SELECT 
    p.category,
    SUM(t.line_total) AS revenue,
    SUM(t.quantity) AS qtysold
FROM transactions t
JOIN products p 
ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

# Q.10: Top Subcategories
-- Identifies niche products with high potential
-- Supports cross-category bundling

SELECT 
    p.sub_category,
    SUM(t.line_total) AS revenue,
    SUM(t.quantity) AS qtysold
FROM transactions t
JOIN products p 
ON t.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY revenue DESC;

# Q.11: Most Sold Product Sizes
-- Supports better demand forecasting and sizing strategy

SELECT 
	size,
    COUNT(*) AS total_sold
FROM transactions
GROUP BY size
ORDER BY total_sold DESC;

# Q.12: Most Sold Product Colors
-- Aligns product design and seasonal campaigns with buyer preference

SELECT 
	color,
    COUNT(*) AS total_sold
FROM transactions
GROUP BY color
ORDER BY total_sold DESC;

# Q.13: Profit Margin per Product (Unit Price - Production Cost)
-- Uncovers high-margin items to promote
-- Helps rebalance pricing and sourcing decisions

SELECT
	p.product_id,
    p.sub_category,
    t.unit_price,
    p.production_cost,
    t.unit_price - p.production_cost AS profit_margin
FROM transactions t
JOIN products p
ON t.product_id = p.product_id
ORDER BY p.product_id;

# Q.14: Unsold Products or Underperforming SKUs
-- Detects inventory issues
-- Identifies products for clearanace or repositioning

SELECT
	p.product_id,
    p.category,
    p.sub_category
FROM products p
LEFT JOIN transactions t
ON p.product_id = t.product_id
WHERE t.product_id IS NULL;

SELECT
	p.product_id,
    p.category,
    p.sub_category,
    COUNT(t.invoice_id) AS time_sold,
    SUM(t.quantity) AS unit_sold,
    SUM(t.line_total) AS revenue
FROM transactions t
JOIN products p
ON t.product_id = p.product_id
WHERE t.trn_type = "Sale"
GROUP BY p.product_id, p.category, p.sub_category
ORDER BY unit_sold, revenue
LIMIT 10;

# Q.15: Discounted vs Non-Discounted Revenue Share
-- Analyzes reliance on promotion to drive sales
-- Helps assess pricing strategy effectiveness

SELECT
    CASE 
        WHEN discount > 0 THEN 'Discounted'
        ELSE 'Non-Discounted'
    END AS discount_type,
    SUM(line_total) AS total_revenue,
    COUNT(*) AS num_transactions
FROM transactions
GROUP BY discount_type;

# Q.16: Monthly Campaign Activities Summary
-- Reviews campaign frequency, duration and diversity
-- Informs future marketing calendar planning

SELECT
    DATE_FORMAT(start_date, "%Y %M") AS months,
    campaign AS campaign_name,
    DATEDIFF(end_date, start_date)+1 AS period_in_days,
     COUNT(DISTINCT category) AS no_of_category,
    COUNT(DISTINCT sub_category) AS no_of_subcategory,
    start_date,
    end_date
FROM promotion
GROUP by campaign_name, period_in_days, start_date, end_date
ORDER BY start_date;