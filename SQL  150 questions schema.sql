-- 1. Setup Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SQLMasteryDB')
BEGIN
    CREATE DATABASE SQLMasteryDB;
END
GO

USE SQLMasteryDB;
GO

-- 2. Drop existing tables if re-running
DROP TABLE IF EXISTS customer_feedback;
DROP TABLE IF EXISTS web_logs;
DROP TABLE IF EXISTS payroll;
DROP TABLE IF EXISTS hr_roster;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Wishlist;
DROP TABLE IF EXISTS b2c_customers;
DROP TABLE IF EXISTS b2b_customers;
DROP TABLE IF EXISTS sizes;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS date_dim;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS vendors;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS tickets;
GO

-- 3. Create Tables
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(30),
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    base_salary DECIMAL(10,2),
    bonus_amount DECIMAL(10,2) NULL,
    department_id INT,
    manager_id INT NULL,
    assigned_manager VARCHAR(100) NULL,
    hire_date DATE,
    dob DATE,
    tenure INT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NULL,
    phone VARCHAR(20) NULL,
    address VARCHAR(255) NULL,
    city VARCHAR(50),
    state_code VARCHAR(10),
    account_balance DECIMAL(10,2),
    birth_date DATE,
    lifetime_spend DECIMAL(10,2)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(255),
    email VARCHAR(100),
    status VARCHAR(20),
    is_active BIT,
    last_login DATETIME,
    website_url VARCHAR(255),
    registration_date DATE
);

CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    company_name VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    retail_price DECIMAL(10,2),
    price DECIMAL(10,2),
    stock_quantity INT,
    total_weight FLOAT,
    vendor_id INT
);

CREATE TABLE inventory (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    quantity INT,
    restock_date DATE NULL
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    rating DECIMAL(3,2),
    review_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    customer_id INT,
    store_id INT,
    region_id INT,
    order_date DATE,
    invoice_date DATE,
    delivery_date DATE,
    status VARCHAR(20),
    discount_code VARCHAR(50) NULL
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2) NULL
);

CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    order_id INT,
    store_id INT,
    region_id INT,
    store_location VARCHAR(100),
    amount DECIMAL(10,2),
    transaction_date DATETIME
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATETIME,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE TABLE date_dim (
    date_key DATE PRIMARY KEY,
    is_weekend BIT,
    month INT,
    year INT
);

CREATE TABLE colors (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(20)
);

CREATE TABLE sizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(10)
);

CREATE TABLE b2b_customers (email VARCHAR(100));
CREATE TABLE b2c_customers (email VARCHAR(100));
CREATE TABLE Cart (product_id INT);
CREATE TABLE Wishlist (product_id INT);
CREATE TABLE hr_roster (employee_id INT, name VARCHAR(100));
CREATE TABLE payroll (employee_id INT, salary DECIMAL(10,2));

CREATE TABLE web_logs (
    log_id INT PRIMARY KEY,
    log_date DATETIME,
    action VARCHAR(255)
);

CREATE TABLE customer_feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    temporary_notes VARCHAR(255) NULL,
    complaints INT
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    created_date DATETIME,
    resolved_date DATETIME
);
GO

-- 4. Populate Tables with Data
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Sales'),
(4, 'Marketing'),
(5, 'Finance'),
(6, 'Legal'); 

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, job_title, salary, base_salary, bonus_amount, department_id, manager_id, assigned_manager, hire_date, dob, tenure) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '123-456-7890', 'Executive Director', 135000.00, 120000.00, 15000.00, 1, NULL, NULL, '2018-03-15', '1982-05-14', 6),
(2, 'Bob', 'Jones', 'bob.j@example.com', '123-555-0101', 'Engineer', 95000.00, 90000.00, 5000.00, 1, 1, 'Alice Smith', '2021-06-01', '1990-11-20', 3),
(3, 'Charlie', 'Brown', 'cbrown@example.com', '415-555-2671', 'Engineer', 88000.00, 85000.00, NULL, 1, 1, 'Alice Smith', '2022-01-15', '1994-08-03', 2),
(4, 'David', 'Miller', 'dmiller@example.com', '415-555-8832', 'Engineer', 92000.00, 88000.00, 4000.00, 1, 1, 'Alice Smith', '2019-11-04', '1988-02-17', 5),
(5, 'Eva', 'Green', 'egreen@example.com', '212-555-9090', 'Sales Manager', 105000.00, 95000.00, 10000.00, 3, 1, 'Alice Smith', '2020-08-12', '1985-09-29', 4),
(6, 'Frank', 'White', 'fwhite@example.com', '212-555-4321', 'Sales Rep', 62000.00, 60000.00, 2000.00, 3, 5, 'Eva Green', '2023-02-10', '1996-12-05', 1),
(7, 'Grace', 'Hall', 'ghall@example.com', '617-555-1122', 'Sales Rep', 64000.00, 61000.00, NULL, 3, 5, 'Eva Green', '2023-04-18', '1997-03-22', 1),
(8, 'Hank', 'Taylor', 'htaylor@example.com', '617-555-3344', 'Sales Rep', 61000.00, 59000.00, 2000.00, 3, 5, 'Eva Green', '2022-09-01', '1995-07-11', 2),
(9, 'Ivy', 'Anderson', 'ianderson@example.com', '312-555-6677', 'HR Specialist', 70000.00, 68000.00, 2000.00, 2, 1, 'Alice Smith', '2021-10-01', '1991-04-19', 3),
(10, 'Jack', 'Thomas', 'jthomas@example.com', '312-555-9900', 'Financial Analyst', 85000.00, 80000.00, 5000.00, 5, 1, NULL, '2023-07-22', '1993-10-10', 1);

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, state_code, account_balance, birth_date, lifetime_spend) VALUES
(101, 'Sarah', 'Stone', 'sarah.s@gmail.com', '212-555-0199', '123 Broadway', 'New York', 'NY', 850.00, '1985-06-14', 5400.00),
(102, 'Samuel', 'Scott', 'sscott@yahoo.com', '212-555-0188', '456 5th Ave', 'New York', 'NY', 3500.00, '1978-02-18', 1200.00),
(103, 'Samantha', 'Smith', 's.smith@corp.com', '212-555-0177', '789 Madison Ave', 'New York', 'NY', 7500.00, '1992-09-12', 8900.00),
(104, 'Michael', 'Chang', 'mchang@gmail.com', '415-555-0166', '101 Market St', 'San Francisco', 'CA', 4500.00, '1990-11-03', 14200.00),
(105, 'Jessica', 'Taylor', 'jtaylor@outlook.com', '415-555-0155', '202 Mission St', 'San Francisco', 'CA', 600.00, '1988-04-20', 3100.00),
(106, 'William', 'Brown', 'wbrown@gmail.com', '512-555-0144', '303 Congress Ave', 'Austin', 'TX', 2200.00, '1995-01-25', 450.00),
(107, 'NoContact', 'Person', NULL, NULL, NULL, 'Chicago', 'IL', 1500.00, '1983-08-30', 250.00);

INSERT INTO users (user_id, username, password, email, status, is_active, last_login, website_url, registration_date) VALUES
(1, '  john_doe  ', 'Pass123', 'John.DOE@gmail.com', 'Active', 1, GETDATE() - 2, 'http://johndoe.com', '2022-01-10'),
(2, 'sarah_admin', 'Secret999!', 'SARAH@company.org', 'Active', 1, GETDATE() - 25, 'https://sarah.net', '2021-05-14'),
(3, 'inactive_user', 'short', 'inactive@domain.com', 'Inactive', 0, GETDATE() - 120, 'http://oldsite.org', '2020-03-22'),
(4, 'ghost_user', 'ValidPass2024', 'ghost@gmail.com', 'Active', 1, GETDATE() - 5, 'https://ghost.io', '2023-01-01');

INSERT INTO vendors (vendor_id, company_name) VALUES
(1, 'Apex Tech Solutions'),
(2, 'Global Logistics'),
(3, 'Nano Tech Innovations'),
(4, 'Prime Goods Inc'),
(5, 'Modern Tech Supplies');

INSERT INTO products (product_id, product_name, category, retail_price, price, stock_quantity, total_weight, vendor_id) VALUES
(201, 'Wireless Mouse', 'Electronics', 35.00, 25.00, 45, 0.45, 1),
(202, 'Mechanical Keyboard', 'Electronics', 85.00, 75.00, 15, 1.25, 1),
(203, 'USB-C Cable', 'Electronics', 15.00, 9.99, 0, 0.15, 3),
(204, 'Desk Lamp', 'Furniture', 45.00, 39.00, 8, 2.10, 4),
(205, 'Ergonomic Chair', 'Furniture', 250.00, 210.00, 5, 18.50, 4),
(206, 'External SSD 1TB', 'Electronics', 120.00, 99.00, 20, 0.30, 3),
(207, 'Monitor Stand', 'Accessories', 30.00, 22.00, 12, 1.80, 2),
(208, 'Notebook Pack', 'Stationery', 12.00, 8.50, 60, 0.80, 5),
(209, 'Coffee Mug', 'Kitchen', 14.00, 10.00, 0, 0.50, 5),
(210, 'Obsolete Dongle', 'Electronics', 19.99, 12.00, 0, 0.10, 1);

INSERT INTO inventory (id, name, quantity, restock_date) VALUES
(1, 'Wireless Mouse', 45, '2023-11-10'),
(2, 'Mechanical Keyboard', 15, '2023-12-01'),
(3, 'USB-C Cable', 0, NULL),
(4, 'Ergonomic Chair', 5, '2023-10-15'),
(5, 'Coffee Mug', 0, NULL);

INSERT INTO reviews (review_id, product_id, rating, review_date) VALUES
(1, 201, 4.50, '2023-02-15'),
(2, 201, 5.00, '2023-03-01'),
(3, 202, 4.00, '2023-01-20'),
(4, 202, 3.80, '2023-05-11'),
(5, 203, 2.50, '2023-06-09'),
(6, 204, 4.80, '2023-07-14'),
(7, 205, 5.00, '2023-08-19');

INSERT INTO orders (order_id, user_id, customer_id, store_id, region_id, order_date, invoice_date, delivery_date, status, discount_code) VALUES
(1001, 1, 101, 1, 10, '2023-03-10', '2023-03-10', '2023-03-15', 'Completed', 'SPRING10'),
(1002, 2, 102, 1, 10, '2023-05-15', '2023-05-16', '2023-05-20', 'Completed', NULL),
(1003, 1, 101, 2, 20, '2023-07-20', '2023-07-20', '2023-07-26', 'Shipped', 'SUMMER20'),
(1004, 3, 104, 3, 30, '2023-08-05', '2023-08-06', '2023-08-12', 'Pending', NULL),
(1005, 2, 105, 2, 20, '2023-09-01', '2023-09-02', '2023-09-05', 'Canceled', NULL),
(1006, 1, 103, 1, 10, '2023-10-18', '2023-10-18', '2023-10-25', 'Completed', 'VIP50'),
(1007, 2, 104, 3, 30, '2023-11-02', '2023-11-03', '2023-11-10', 'Pending', NULL),
(1008, 1, 101, 1, 10, CAST(GETDATE() AS DATE), CAST(GETDATE() AS DATE), NULL, 'Pending', NULL);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount) VALUES
(1, 1001, 201, 2, 25.00, 5.00),
(2, 1001, 202, 1, 75.00, 0.00),
(3, 1002, 205, 1, 210.00, 10.00),
(4, 1003, 206, 3, 99.00, 15.00),
(5, 1004, 204, 2, 39.00, 0.00),
(6, 1005, 203, 5, 9.99, 0.00),
(7, 1006, 205, 4, 210.00, 50.00),
(8, 1007, 202, 2, 75.00, 0.00),
(9, 1008, 201, 1, 25.00, 0.00);

INSERT INTO sales (transaction_id, order_id, store_id, region_id, store_location, amount, transaction_date) VALUES
(501, 1001, 1, 10, 'Manhattan Main', 120.00, '2023-03-10 14:30:00'),
(502, 1002, 1, 10, 'Manhattan Main', 200.00, '2023-05-15 11:15:00'),
(503, 1003, 2, 20, 'Brooklyn Station', 282.00, '2023-07-20 16:45:00'),
(504, 1004, 3, 30, 'San Francisco Flagship', 78.00, '2023-08-05 09:20:00'),
(505, 1006, 1, 10, 'Manhattan Main', 1450.00, '2023-10-18 18:00:00'),
(506, NULL, 1, 10, 'Manhattan Main', 9500.00, '2023-11-12 12:00:00'),
(507, NULL, 3, 30, 'San Francisco Flagship', 11500.00, '2023-11-15 15:30:00');

INSERT INTO transactions (transaction_id, transaction_date, amount, status) VALUES
(1, '2023-01-10 10:00:00', 450.00, 'Completed'),
(2, '2023-02-14 14:10:00', 650.00, 'Completed'),
(3, '2023-03-20 09:30:00', 1200.00, 'Completed'),
(4, '2023-04-18 16:20:00', 300.00, 'Pending'),
(5, '2023-05-25 18:45:00', 850.00, 'Completed'),
(6, '2023-06-02 11:00:00', 120.00, 'Active');

INSERT INTO date_dim (date_key, is_weekend, month, year) VALUES
('2023-03-10', 0, 3, 2023),
('2023-03-11', 1, 3, 2023),
('2023-05-15', 0, 5, 2023),
('2023-07-20', 0, 7, 2023),
('2023-07-22', 1, 7, 2023),
('2023-08-05', 1, 8, 2023),
('2023-10-18', 0, 10, 2023),
('2023-11-12', 1, 11, 2023);

INSERT INTO colors (color_id, color_name) VALUES
(1, 'Red'), (2, 'Blue'), (3, 'Black');

INSERT INTO sizes (size_id, size_name) VALUES
(1, 'S'), (2, 'M'), (3, 'L'), (4, 'XL');

INSERT INTO b2b_customers (email) VALUES
('purchasing@corporate.com'), ('vendor@supply.org'), ('shared@account.com');

INSERT INTO b2c_customers (email) VALUES
('john.doe@gmail.com'), ('sarah.s@gmail.com'), ('shared@account.com');

INSERT INTO Cart (product_id) VALUES (201), (202), (205);
INSERT INTO Wishlist (product_id) VALUES (202), (205), (207);

INSERT INTO hr_roster (employee_id, name) VALUES
(1, 'Alice Smith'), (2, 'Bob Jones'), (3, 'Charlie Brown'), (99, 'Missing On Payroll');

INSERT INTO payroll (employee_id, salary) VALUES
(1, 135000.00), (2, 95000.00), (3, 88000.00);

INSERT INTO web_logs (log_id, log_date, action) VALUES
(1, DATEADD(day, -5, GETDATE()), 'User login'),
(2, DATEADD(day, -30, GETDATE()), 'Page view: Products'),
(3, DATEADD(day, -95, GETDATE()), 'Outdated Session Purge'),
(4, DATEADD(day, -110, GETDATE()), 'Old Audit Record');

INSERT INTO customer_feedback (feedback_id, customer_id, temporary_notes, complaints) VALUES
(1, 101, 'Fast shipping and great service.', 0),
(2, 102, 'Delayed delivery by 2 days.', 1),
(3, 103, NULL, 0),
(4, 104, 'Wrong item sent in the package.', 2);

INSERT INTO tickets (ticket_id, created_date, resolved_date) VALUES
(101, '2023-10-01 08:30:00', '2023-10-03 14:15:00'),
(102, '2023-10-05 10:00:00', '2023-10-10 18:00:00'),
(103, '2023-11-01 11:20:00', '2023-11-02 09:00:00');
GO