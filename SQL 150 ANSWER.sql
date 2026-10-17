

--Q1:Retrieve all columns from the `employees` table for employees hired after 2020.

SELECT * FROM employees
WHERE hire_date >'2020'

--Q2:Select only the `first_name`, `last_name`, and `email` from the `customers` table.
SELECT first_name ,last_name , email from customers

--Q3:List all unique `job_titles` currently present in the `employees` table using DISTINCT.
SELECT DISTINCT(job_title) FROM employees

--Q4:Retrieve the top 5 highest-paid employees by ordering the `salary` column in descending
--order

SELECT TOP 5 employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

--Q5:Select all rows from `products`, but alias the `retail_price` column as `price_usd`.
SELECT product_id,product_name,category , retail_price as price_usd , price, stock_quantity,total_weight , vendor_id  FROM products;

--Q6:Retrieve the first 3 rows from the `transactions` table ordered by `transaction_date`
SELECT top 3 * FROM transactions
order by transaction_date

--Q7 :Select `employee_id` and calculate a new column `annual_bonus` as 10% of `base_salary`.
SELECT employee_id, base_salary ,base_salary*0.10 as annual_bonus FROM employees;

--Q8:List all `orders` sorted by `store_id` ascending, and then by `order_date` descending.
SELECT * FROM orders
ORDER BY store_id asc , order_date desc;

--Q9:Retrieve `product_name` and a hardcoded string 'Active' as a new column named `status`.
SELECT product_name , 'ACTIVE' AS Status  from products;

--Q10:Select the `order_id` and the total price (quantity * unit_price) aliased as `total_value`.
SELECT  order_id ,quantity ,  unit_price, quantity*unit_price as total_value from order_items;

--Q11:Find all transactions in the `sales` table where the `amount` is strictly greater than 500.
SELECT transaction_id, amount  from sales
where amount >500;

--Q12:Retrieve all customers whose `last_name` starts with the letter 'S' using the LIKE operator.
SELECT * FROM customers where  last_name like 'S%';

--Q13:Filter the `orders` table for purchases made between '2023-01-01' and '2023-12-31'.
SELECT * FROM orders WHERE order_date BETWEEN '2023-01-01' and '2023-12-31';

--Q14:Find all employees who work in `department_id` 1, 3, or 5 using the IN operator.
SELECT employee_id,first_name,last_name , department_id FROM employees where department_id  in (1,3,5); 

--Q15:Retrieve products where the `category` is 'Electronics' AND the `price` is less than 50.
SELECT product_id,product_name, category, price FROM products 
where   category = 'Electronics'and price<50;

--Q16:List all active users (status = 'Active') OR users who logged in within the last 7 days.
SELECT * 
FROM users 
WHERE status = 'Active' 
   OR last_login >= DATEADD(day, -7, CAST(GETDATE() AS DATE));


select * from users

--Q17:Find all records in the `inventory` table where `restock_date` IS NULL.
SELECT * FROM inventory WHERE restock_date IS  NULL ;

--Q18:Retrieve all vendors whose `company_name` contains the word 'Tech' anywhere in the string.
SELECT * FROM vendors where company_name  like '%Tech%';

--Q19:Filter out all canceled orders using the != or <> operator on the `status` column.
SELECT * FROM orders 
WHERE status != 'Canceled' OR status IS NULL;

--Q20:Find customers located in 'New York' whose `account_balance` is NOT BETWEEN 1000 and
--5000
SELECT  customer_id, first_name, last_name,city FROM customers WHERE  city = 'New York' and account_balance not  between 1000 and 5000;

--Q21:Calculate the total (SUM) revenue generated across all completed orders.
SELECT SUM(amount) as "revenue"  from transactions where status = 'Completed';


--Q22:Count the total number of unique customers who made a purchase this month.
SELECT COUNT(DISTINCT(customer_id) ) as "Unique customer " from orders where order_date between '2023-05-01' and '2023-05-30'



--Q23:Find the minimum, maximum, and average salary for all employees in the database.
SELECT MIN(salary) AS min_salary, 
       MAX(salary) AS max_salary, 
       ROUND(AVG(CAST(salary AS FLOAT)), 0) AS avg_salary 
FROM employees;

--Q24:Group by `department_id` and calculate the total headcount (COUNT) for each department.
SELECT 
    department_id, 
    COUNT(employee_id) AS headcount
FROM employees
GROUP BY department_id;


--Q25:Calculate the average order value (AVG) grouped by `product_category`.
SELECT 
    p.category, 
    AVG(oi.quantity * oi.unit_price) AS avg_order_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category;

--Q26:Group sales by `store_location` and only show locations with total revenue exceeding $10,00
--(HAVING).

SELECT 
    s.store_location, 
    sum(oi.quantity * oi.unit_price) AS Total_revenue
FROM sales s
JOIN order_items oi ON s.order_id = oi.order_id

GROUP BY s.store_location
having sum(oi.quantity * oi.unit_price)>1000;

--Q27:Find the total number of items sold per `vendor_id` and order the results from highest to
--lowest.
SELECT 
    p.vendor_id, 
    SUM(oi.quantity) AS total_items_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.vendor_id
ORDER BY total_items_sold DESC;

--Q28:Count how many employees share the same `job_title`, excluding titles with fewer than 3
--employees.
SELECT 
    job_title, 
    COUNT(employee_id) AS total_employees
FROM employees
GROUP BY job_title
HAVING COUNT(employee_id) >= 3;

--Q29:Group by the extract of the YEAR from `order_date` to find yearly total revenue.

SELECT 
    YEAR(o.order_date) AS order_year, 
    SUM(oi.quantity * oi.unit_price) AS Total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY YEAR(o.order_date); -- Optional: to sort the years chronologically!

--Q30:Calculate the average rating per `product_id`, rounding the result to two decimal places.
SELECT 
    p.product_id, 
    ROUND(AVG(CAST(r.rating AS FLOAT)), 2) AS AVG_RATING
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id;

--Q31:Write an INNER JOIN to combine `users` and `orders` on `user_id` to show order history.
SELECT o.user_id, o.order_id,u.username,o.order_date from orders o 
join users u on o.user_id = u.user_id

--Q32:Use a LEFT JOIN to list all `products` and any associated `reviews` (including products with no
--reviews).
SELECT p.product_name, p.category,r.rating from products p 
left join reviews r on p.product_id = r.product_id

--Q33:Perform a RIGHT JOIN between `departments` and `employees` to find departments with no
--staff.
SELECT 
    d.department_id, 
    d.department_name, 
    e.employee_id, 
    e.first_name 
FROM employees e 
RIGHT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

--Q34:Write a FULL OUTER JOIN to find mismatched records between two legacy `customer` tables.
SELECT 
    b2c.email AS b2c_email,
    b2b.email AS b2b_email
FROM dbo.B2C_customers b2c
FULL OUTER JOIN dbo.B2B_customers b2b 
    ON b2c.email = b2b.email
WHERE b2c.email IS NULL 
   OR b2b.email IS NULL;

--Q35: Join `order_items`, `orders`, and `products` to display order ID, product name, and quantity.
SELECT o.order_id, p.product_id,ot.quantity from products p 
join order_items ot on p.product_id = ot.product_id
join orders o on o.order_id=ot.order_id


--Q36:Use a SELF JOIN on the `employees` table to list employees alongside their manager's name.
SELECT 
    e.first_name AS employee_name, 
    m.first_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;


--Q37: Join `sales` and `date_dim` tables, filtering the result for weekend sales only.
SELECT dd.date_key, dd.month , dd.year ,s.store_location,s.amount from date_dim dd
join sales s on dd.date_key = cast(s.transaction_date as date)

--Q38:Write a CROSS JOIN between `colors` and `sizes` tables to generate all possible product
--variations.
SELECT 
    c.Color_name, 
    s.size_name
FROM Colors c
CROSS JOIN Sizes s;

--Q39:Use an anti-join (LEFT JOIN + IS NULL) to find users who registered but never placed an
--order.
SELECT o.user_id, o.order_id,u.username,o.order_date from users u
left join orders o on o.user_id = u.user_id
WHERE o.order_id IS NULL;

--Q40: Join two tables using multiple conditions (e.g., matching both `store_id` and `region_id`).
SELECT o.user_id, o.order_id,u.username,o.order_date from orders o 
join users u on o.user_id = u.user_id
and o.customer_id= u.is_active

--Q41:Use a CASE statement to label orders > $100 as 'High Value' and others as 'Standard'.
SELECT 
    order_item_id,
    order_id,
    (quantity * unit_price) AS Price,
    CASE 
        WHEN (quantity * unit_price) > 100 THEN 'High Value'
        ELSE 'Standard'
    END AS value_category
FROM order_items;


--Q42:Write a query grouping `age` into buckets: '<18', '18-35', '36-50', and '50+' using CASE.
SELECT 
    first_name,
    last_name,
    city,    
    DATEDIFF(YEAR, birth_date, GETDATE()) AS Age,
    CASE 
        WHEN DATEDIFF(YEAR, birth_date, GETDATE()) < 18 THEN '<18'
        WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 18 AND 35 THEN '18-35'
        WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS Age_Bucket
FROM customers;

SELECT * FROM customers


--Q43:Use CASE inside a SUM function to count how many orders have a 'Shipped' status.
SELECT 
    SUM(CASE WHEN status = 'Shipped' THEN 1 ELSE 0 END) AS shipped_orders_count
FROM orders;

--Q44:Create a priority flag using CASE: If `status`='Urgent' THEN 1, IF 'Normal' THEN 2, ELSE 3.
SELECT 
    CASE WHEN status = 'Urgent' THEN 1
    WHEN status = 'Normal' THEN 2 ELSE 3 END AS priorityflag
FROM orders;


--Q45:Use a CASE statement in the ORDER BY clause to sort 'Premium' members to the top of the list.
SELECT 
    first_name,
    last_name,
    account_balance
FROM customers
ORDER BY 
    CASE 
        WHEN account_balance > 3000 THEN 1  -- Priority 1: Goes to the top
        ELSE 2                              -- Priority 2: Goes below
    END ASC;

--Q46:Write a conditional check to flag an employee as 'Eligible for Bonus' if their tenure > 3 years.
SELECT 
    first_name,
    last_name,
    CASE 
        WHEN tenure > 3 THEN 'Eligible for Bonus'
        ELSE 'Not Eligible'
    END AS bonus_eligibility
FROM employees;
--Q47:Use IIF or a simple CASE to return 'Yes' if a `discount_code` was applied, otherwise 'No'.
SELECT 
    order_item_id,
    order_id,
    (quantity * unit_price) AS price,
    IIF(discount > 0, 'Yes', 'No') AS discount_applied
FROM order_items;

--Q48:Categorize products based on stock: 'Out of Stock' (0), 'Low Stock' (<10), and 'In Stock' (>=10).
SELECT product_id, product_name,category ,
CASE 
        WHEN stock_quantity = 0 THEN 'Out of Stock'        
       WHEN stock_quantity <10 THEN 'lOW Stock' ELSE 'In stock'
    END AS Stock_Update
    
 FROM products


--Q49:Use a CASE statement to apply different tax rates based on the `state_code` of the transaction.
SELECT 
    customer_id,
    account_balance,
    state_code,
    CASE 
        WHEN state_code = 'CA' THEN 0.08
        WHEN state_code = 'NY' THEN 0.06
        -- Add 1 or 2 more state codes here
        ELSE 0.05
    END AS tax_rate,
    account_balance* CASE 
        WHEN state_code = 'CA' THEN 0.08
        WHEN state_code = 'NY' THEN 0.06
        ELSE 0.05
    END AS estimated_tax
FROM customers;

--Q50:Update a boolean integer column: return 1 if `is_active` is true and `last_login` < 30 days, else 0.

select username,email,
case 
when status='Active' and DATEDIFF(day, last_login, GETDATE()) < 30 THEN 1  
else 0
end as Updation
from users

--Basic Data Type Conversion
--Q51:CAST a string `order_date` ('2023-01-15') into a standard SQL DATE data type.
select cast(order_date as date)  from orders

--Q52:CONVERT a floating-point `total_weight` into an INTEGER to remove decimal precision.
select cast(total_weight as INT) as formated_weight  from products

--Q53:Cast the `employee_id` (integer) to a VARCHAR so it can be concatenated with a prefix.
select cast(employee_id as varchar(50)) as formated_id from employees

--Q54:Convert a Unix timestamp integer into a readable DATETIME format.
SELECT DATEADD(s, customer_id, '1970-01-01') AS formatted_timestamp 
FROM customers;

--Q55:Use safe casting (e.g., TRY_CAST) to handle alpha-numeric characters in a supposed numeric
--column.
SELECT 
    product_id,
    total_weight AS raw_weight,
    -- Step 1: Safe cast with default value fallback
    COALESCE(TRY_CAST(total_weight AS INT), 0) AS cleaned_weight,
    
    -- Step 2: Flag bad rows for the data team
    CASE 
        WHEN TRY_CAST(total_weight AS INT) IS NULL THEN 'Invalid/Alphanumeric'
        ELSE 'Valid Numeric'
    END AS data_quality_status
FROM products;

--Q56:CAST a numeric percentage (0.15) to a string and append a '%' symbol to it.
-- If you want the literal string "0.15%"
SELECT CONCAT(CAST(0.15 AS VARCHAR(10)), '%') AS string_percentage;

--Q57:Convert a DATETIME column to purely a DATE column to strip away the time metadata.
SELECT  CAST(transaction_date as date ) as Formated_TD FROM transactions

--Q58:Change a string 'true'/'false' column into a standard boolean/BIT data type.
SELECT 
    CAST(
        CASE 
            WHEN discount_code IS NULL THEN 0
            ELSE 1 
        END AS BIT
    ) AS is_discounted
FROM orders;

--Q59:Format a standard DATE column into a specific string format (e.g., 'MM-DD-YYYY').
SELECT FORMAT(order_date, 'MM-dd-yyyy') AS formatted_date 
FROM orders;


--Q60:Cast two integers as floats before dividing them to prevent integer division (truncation).
SELECT 
    round(CAST( quantity AS FLOAT) / CAST(Unit_price AS FLOAT),2) AS ratio
FROM order_items;

--Window Functions
--Q61:Use ROW_NUMBER() to rank employees by salary within each specific `department_id`.
SELECT 
    CONCAT(first_name, ' ', last_name) AS employee_name,
    job_title,
    salary,
    department_id,
    ROW_NUMBER() OVER(
        PARTITION BY department_id 
        ORDER BY salary DESC
    ) AS salary_rank_in_dept
FROM employees; 


--Q62:Calculate the running total of sales for the year using SUM() OVER(ORDER BY order_date).
select o.order_id, s.store_location, sum(amount) over(
order by o.order_date) as RunningT from orders o join sales s on o.order_id = s.order_id

--Q63:Find the day-over-day revenue difference using the LAG() function.

SELECT 
    transaction_date,
    amount AS current_amount,
    LAG(amount) OVER (ORDER BY transaction_date) AS previous_amount,
    -- Day-over-Day Difference calculation:
    amount - LAG(amount) OVER (ORDER BY transaction_date) AS dod_difference
FROM transactions;


--Q64:Use LEAD() to find the date of the *next* purchase made by a specific customer.

SELECT 
    customer_id,
    order_id,
    order_date AS current_order_date,
    LEAD(order_date) OVER(
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS next_order_date
FROM orders;

--Q65:Rank products by total sales using RANK() and DENSE_RANK() to see how ties are handled.
SELECT 
    STORE_id,
    SUM(amount) AS total_sales,
    RANK() OVER(ORDER BY SUM(amount) DESC) AS sales_rank,
    DENSE_RANK() OVER(ORDER BY SUM(amount) DESC) AS sales_dense_rank
FROM sales
GROUP BY store_id;

--Q66:Use NTILE(4) to divide customers into quartiles based on their lifetime spend.
SELECT 
    *, 
    NTILE(4) OVER(ORDER BY lifetime_spend) AS spend_quartile 
FROM customers;

--Q67:Calculate a 7-day moving average of sales using AVG() OVER with a ROWS BETWEEN clause.
SELECT 
    *, 
    AVG(amount) OVER(
        PARTITION BY store_id 
        ORDER BY transaction_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7day 
FROM sales;

--Q68:Find the highest salary in the company and display it next to every row using MAX() OVER().
SELECT 
    employee_id,
    first_name,
    salary,
    MAX(salary) OVER() AS company_max_salary
FROM employees;

--Q69:Use FIRST_VALUE() to find the name of the very first product ever purchased by each user.
SELECT 
    o.customer_id,
    o.order_date,
    p.product_name,
    FIRST_VALUE(p.product_name) OVER(
        PARTITION BY o.customer_id 
        ORDER BY o.order_date ASC
    ) AS first_product_purchased
FROM orders o
JOIN order_items ot ON o.order_id = ot.order_id
JOIN products p ON ot.product_id = p.product_id;

--Q70:Calculate the percentage contribution of each region to total sales using Window Functions.
SELECT 
    region_id,
    SUM(amount) AS region_total_sales,
    -- Global total across all regions:
    SUM(SUM(amount)) OVER() AS overall_total_sales,
    -- Percentage contribution calculation:
    ROUND(
        (SUM(amount) * 100.0) / SUM(SUM(amount)) OVER(), 
        2
    ) AS pct_contribution
FROM sales
GROUP BY region_id
;
--CTE

--Q71:Write a basic CTE to filter active employees, then select their names from the CTE.
WITH ActiveEmp AS (
    SELECT 
        CONCAT(e.first_name, ' ', e.last_name) AS Full_name,
        o.status 
    FROM employees e 
    JOIN orders o ON e.employee_id = o.user_id
    WHERE o.status = 'Completed'
)
SELECT * FROM ActiveEmp;


--Q72:Create two CTEs (one for sales, one for returns) and join them together in the final query.
WITH Returns AS (
    SELECT 
        order_id,amount
    FROM sales  
    
),
SALESs AS (
    SELECT 
        order_id,store_id,store_location 
    FROM sales )
SELECT * FROM Returns r join SALESs s on r.order_id =s.order_id ;

--Q73:Use a CTE to calculate average salary per department, then find departments above the
--company average.
WITH SalaryStats AS (
    SELECT 
        department_id,
        salary,
        -- Department average:
        AVG(salary) OVER(PARTITION BY department_id) AS dept_avg_salary,
        -- Company-wide average (empty OVER clause):
        AVG(salary) OVER() AS company_avg_salary
    FROM employees
)
SELECT DISTINCT
    department_id,
    dept_avg_salary,
    company_avg_salary
FROM SalaryStats
WHERE dept_avg_salary > company_avg_salary;

--Q74:Write a CTE to deduplicate rows by assigning a ROW_NUMBER, then delete rows where rn >1.
WITH DedupeOrders AS (
    SELECT 
        order_id,
        customer_id,
        order_date,
        -- PARTITION BY defines what constitutes a duplicate
        ROW_NUMBER() OVER(
            PARTITION BY customer_id, order_date 
            ORDER BY order_id ASC -- Keeps the row with the smallest order_id (rn = 1)
        ) AS rn
    FROM orders
)
DELETE FROM DedupeOrders
WHERE rn > 1; -- Deletes duplicate rows directly from the underlying orders table

--Q75:Use a recursive CTE to build a hierarchical organizational chart (Manager -> Employee).
WITH OrgChartCTE AS (
    -- 1. ANCHOR MEMBER: Find the top-level boss(es) where manager_id is NULL
    SELECT 
        employee_id,
        first_name,
        manager_id,
        job_title,
        1 AS hierarchy_level,
        CAST(first_name AS VARCHAR(1000)) AS org_path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- 2. RECURSIVE MEMBER: Join the table back to the CTE (child -> parent)
    SELECT 
        e.employee_id,
        e.first_name,
        e.manager_id,
        e.job_title,
        c.hierarchy_level + 1,
        CAST(c.org_path + ' -> ' + e.first_name AS VARCHAR(1000))
    FROM employees e
    INNER JOIN OrgChartCTE c ON e.manager_id = c.employee_id
)
-- 3. OUTER QUERY: Consume the recursive results
SELECT 
    employee_id,
    first_name,
    job_title,
    manager_id,
    hierarchy_level,
    org_path
FROM OrgChartCTE
ORDER BY hierarchy_level, manager_id;

--Q76:Create a CTE that defines a static list of dates, and join it to sales to find days with zero revenue.
WITH StaticDates AS (
    SELECT '2026-01-01' AS sale_date
    UNION ALL
    SELECT '2026-01-02'
    UNION ALL
    SELECT '2026-01-03'
    UNION ALL
    SELECT '2026-01-04'
    UNION ALL
    SELECT '2026-01-05'
)
SELECT d.sale_date
FROM StaticDates d
LEFT JOIN sales s ON d.sale_date = s.transaction_date
WHERE s.transaction_date IS NULL;


--Q77:Use a CTE to find the top 3 customers, then query their full demographic details in the mainquery.
-- Step 1: Find the top 3 customer IDs in the CTE
WITH Top3Customers AS (
    SELECT TOP 3 customer_id
    FROM customers
    ORDER BY lifetime_spend DESC
)
-- Step 2: Join back to the main table to get all demographic details
SELECT c.*
FROM customers c
JOIN Top3Customers t ON c.customer_id = t.customer_id;

--Q78:Write a CTE to extract complex JSON/XML data, then apply basic filtering in the main SELECT.
WITH RawData AS (
    -- Creating static JSON data to test with
    SELECT 1 AS customer_id, '{"email": "john@gmail.com", "status": "Active"}' AS raw_json
    UNION ALL
    SELECT 2 AS customer_id, '{"email": "jane@gmail.com", "status": "Inactive"}'
),
ParsedData AS (
    SELECT 
        customer_id,
        JSON_VALUE(raw_json, '$.email') AS email,
        JSON_VALUE(raw_json, '$.status') AS account_status
    FROM RawData
)
SELECT 
    customer_id,
    email,
    account_status
FROM ParsedData
WHERE account_status = 'Active';


--Q79:Calculate customer lifetime value in a CTE and use it to group users into VIP tiers.
WITH CustomerLTV AS (
    SELECT 
        customer_id,
        lifetime_spend
    FROM customers
    GROUP BY customer_id, lifetime_spend
)
SELECT 
    customer_id,
    lifetime_spend,
    CASE 
        WHEN lifetime_spend >= 10000 THEN 'VIP'
        WHEN lifetime_spend >= 5000  THEN 'Gold'
        ELSE 'Silver'
    END AS vip_tier
FROM CustomerLTV;

--Q80:Refactor a complex nested subquery into a readable CTE format.
-- EXTRA

--Subqueries
--Q81:Use a subquery in the WHERE clause to find employees earning more than the overall company average.

SELECT 
    employee_id,
    first_name,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q82:Write an IN subquery to find all `orders` placed by customers located in 'Austin'  .
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE city = 'Austin'  
);
select * from orders;
--Q83:Use an EXISTS clause with a correlated subquery to find users who have at least one activesubscription.
WITH users AS (
    SELECT 1 AS user_id, 'Alice' AS first_name
    UNION ALL
    SELECT 2 AS user_id, 'Bob' AS first_name
),
subscriptions AS (
    SELECT 1 AS subscription_id, 1 AS user_id, 'Active' AS status
    UNION ALL
    SELECT 2 AS subscription_id, 2 AS user_id, 'Cancelled' AS status
)
SELECT 
    u.user_id,
    u.first_name
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM subscriptions s
    WHERE s.user_id = u.user_id
      AND s.status = 'Active'
);


--Q84:Write a subquery in the SELECT clause to display the total company revenue next toindividual order rows.
SELECT 
    o.order_id,
    o.customer_id,
    (ot.quantity * ot.unit_price) AS line_total,
    -- Query order_items directly in the subquery to get total company revenue:
    (SELECT SUM(quantity * unit_price) FROM order_items) AS total_company_revenue
FROM orders o
JOIN order_items ot ON o.order_id = ot.order_id;

--Q85:Use a subquery in the FROM clause (derived table) to pre-aggregate daily sales before joining.
WITH stores AS (
    SELECT 1 AS store_id, 'Downtown Branch' AS store_name
    UNION ALL
    SELECT 2 AS store_id, 'Uptown Branch' AS store_name
),
orders AS (
    SELECT 101 AS order_id, 1 AS store_id, '2026-10-01' AS order_date, 150.00 AS amount
    UNION ALL
    SELECT 102 AS order_id, 1 AS store_id, '2026-10-01' AS order_date, 200.00 AS amount
    UNION ALL
    SELECT 103 AS order_id, 2 AS store_id, '2026-10-01' AS order_date, 300.00 AS amount
)
SELECT 
    s.store_id,
    s.store_name,
    ds.order_date,
    ds.daily_sales
FROM stores s
JOIN (
    -- Derived Table: Sums daily sales per store first
    SELECT 
        store_id,
        CAST(order_date AS DATE) AS order_date,
        SUM(amount) AS daily_sales
    FROM orders
    GROUP BY store_id, CAST(order_date AS DATE)
) AS ds ON s.store_id = ds.store_id;

--Q86:Find the product with the maximum price using a WHERE `price` = (SELECT MAX(price)...) subquery.
SELECT * from products
where price = (SELECT Max(price) from products);

--Q87:Write a  EXISTS query to find all active Discount codes that have  used.

WITH discount_codes AS (
    SELECT 'SUMMER2026' AS discount_code, 'Active' AS status
    UNION ALL
    SELECT 'WELCOME10'  AS discount_code, 'Active' AS status
    UNION ALL
    SELECT 'EXPIRED50'  AS discount_code, 'Inactive' AS status
),
orders AS (
    SELECT 101 AS order_id, 'SUMMER2026' AS discount_code
)
SELECT 
    d.discount_code,
    d.status
FROM discount_codes d
WHERE d.status = 'Active'
  AND EXISTS (
      SELECT 1
      FROM orders o
      WHERE o.discount_code = d.discount_code
  );


--Q88:Use a correlated subquery in the HAVING clause to filter groups based on a dynamic threshold.

SELECT 
    department_id,
    job_title,
    AVG(salary) AS avg_dept_salary
FROM employees e1
GROUP BY department_id, job_title
HAVING AVG(salary) > (
    -- Dynamic threshold: Average salary of all employees in the SAME location
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.job_title = e1.job_title
);

--Q89:Find the second highest salary in the `employees` table using a subquery and MAX().
SELECT employee_id, first_name, last_name, job_title, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

--Q90:Update a table based on aggregated values calculated in a subquery.
UPDATE d
SET d.amount = agg.total_salary
FROM sales d
JOIN (
    SELECT 
        department_id,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id
) AS agg ON d.order_id = agg.department_id;

--Set Operations
--Q91:Use UNION to combine lists of `emails` from a `b2b_customers` table and a `b2c_customers`--table.
with allemail as (
SELECT * from b2b_customers
union 
SELECT * from b2c_customers)
SELECT * FROM allemail

--Q92:Use UNION ALL to merge Q1 and Q2 sales data tables without removing any duplicate rows.

SELECT 
    'Q' + CAST(DATEPART(quarter, transaction_date) AS VARCHAR) AS sales_quarter,
    SUM(amount) AS total_amount
FROM sales
GROUP BY DATEPART(quarter, transaction_date);
SELECT 
    SUM(CASE WHEN DATEPART(quarter, transaction_date) = 1 THEN amount ELSE 0 END) AS Q1_Total,
    SUM(CASE WHEN DATEPART(quarter, transaction_date) = 2 THEN amount ELSE 0 END) AS Q2_Total
FROM sales;

--Q93:Find the common `product_id`s present in both 'Cart' and 'Wishlist' tables using INTERSECT.
SELECT product_id from Cart
intersect
SELECT product_id FROM Wishlist


--Q94:Use EXCEPT (or MINUS) to find employees in the `hr_roster` who are missing from the
--`payroll` table.
SELECT employee_id FROM employees
EXCEPT
SELECT employee_id FROM payroll

--Q95:Combine the names of `vendors` and `customers` into a single column using UNION, padding
--with a 'Type' column.
SELECT company_name AS name, 'Vendor' AS type
FROM vendors

UNION

SELECT concat(first_name,last_name) as customer_name , 'Customer' AS type
FROM customers;

--Q96:Use UNION ALL to unpivot three columns (Jan_Rev, Feb_Rev, Mar_Rev) into a single 'Month'
--column.
--NA

--Q97:Find elements unique to the first table by using EXCEPT, then elements unique to the second,
--and UNION them.
WITH unique_in_first AS (
    SELECT customer_id FROM customers
    EXCEPT
    SELECT customer_id FROM customer_feedback
),
unique_in_second AS (
    SELECT customer_id FROM customer_feedback
    EXCEPT
    SELECT customer_id FROM customers
)
SELECT customer_id FROM unique_in_first
UNION ALL
SELECT customer_id FROM unique_in_second;

--Q98:Merge historical archived data with live data using UNION ALL for year-over-year reporting.

-- Historical / Past Data (2025 ya usse purana)
SELECT 
    order_id, 
    amount, 
    transaction_date, 
    'Archived Data' AS source_type
FROM sales
WHERE transaction_date < '2026-01-01'

UNION ALL

-- Live / Current Year Data (2026)
SELECT 
    order_id, 
    amount, 
    transaction_date, 
    'Live Data' AS source_type
FROM sales
WHERE transaction_date >= '2026-01-01';



--Q99:Use INTERSECT on a composite key (user_id, product_id) between 2022 and 2023 sales tables.
-- First Half of 2023 (Jan to Jun)
SELECT order_id, transaction_id 
FROM sales 
WHERE MONTH(transaction_date) BETWEEN 1 AND 6

INTERSECT

-- Second Half of 2023 (Jul to Dec)
SELECT order_id, transaction_id FROM sales 
WHERE MONTH(transaction_date) BETWEEN 7 AND 12;

--Q100:Write a complex query using UNION ALL wrapped in a CTE, followed by an aggregation on
--the result.
WITH CombinedSales AS (
    -- Source 1: Regular Sales Data
    SELECT 
        'Direct Sales' AS source_type,
        amount
    FROM sales
    
    UNION ALL
    
    -- Source 2: Additional Transactions / Online Data
    SELECT 
        'Online Sales' AS source_type,
        amount
    FROM sales
    WHERE amount > 5000 -- Sub-filtering to simulate second dataset
)
-- Outer Aggregation
SELECT 
    source_type,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_order_value
FROM CombinedSales
GROUP BY source_type;

--Data Manipulation and Definition (DML/DDL)
--Q101:Write a CREATE TABLE statement for `inventory` with columns for ID, name, quantity, and a primary key.
DROP TABLE IF EXISTS inventories;
GO
CREATE TABLE inventories (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    quantity INT
);

--Q102:Add a new column named `last_login_date` of type DATETIME to the existing `users` table.
-- Agar column pehle se nahi hai tabhi add ho:
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('users') AND name = 'last_login_date')
BEGIN
    ALTER TABLE users ADD last_login_date DATETIME;
END
ALTER table users
add  last_login_date DATETIME;

--Q103:Write an INSERT statement to add three new specific rows into the `departments` table.
INSERT INTO departments (department_id, department_name)
VALUES 
    (7, 'HR'),
    (8, 'IT'),
    (9, 'Finance');

--Q104:Use INSERT INTO ... SELECT to copy all inactive accounts into an `archived_accounts` table.
-- 1. Source Table (#accounts)
CREATE TABLE #accounts (
    account_id INT,
    account_name VARCHAR(50),
    status VARCHAR(20)
);

-- 2. Target Table (#archived_accounts)
CREATE TABLE #archived_accounts (
    account_id INT,
    account_name VARCHAR(50),
    status VARCHAR(20)
);

-- 3. Source Table me Sample Data
INSERT INTO #accounts VALUES 
    (101, 'Rahul Sharma', 'Active'),
    (102, 'Priya Verma', 'Inactive'),
    (103, 'Amit Patel', 'Inactive'),
    (104, 'Sneha Gupta', 'Active');

-- 4. Inactive accounts copy karna
INSERT INTO #archived_accounts (account_id, account_name, status)
SELECT account_id, account_name, status
FROM #accounts
WHERE status = 'Inactive';

-- 5. Target Table ka Output Check
SELECT * FROM #archived_accounts;

-- Cleanup
DROP TABLE #accounts;
DROP TABLE #archived_accounts;

--Q105:Write an UPDATE statement to increase the `base_salary` of all 'Engineers' by 5%.
UPDATE employees
SET 
base_salary = base_salary+base_salary*0.05
where job_title ='Engineer'


--Q106:Update the `status` of orders to 'Overdue' if the  `status` is 'Pending'.
UPDATE orders
SET status = 'Overdue'
WHERE status = 'Pending';

--Q107:Write a DELETE statement to remove all rows from `web_logs` that are older than 120 days.
SELECT * FROM web_logs
delete web_logs
where DATEDIFF(day, log_date, GETDATE()) < 120

--Q108:Use TRUNCATE to quickly wipe all data from a temporary staging table.
truncate table  inventories

--Q109:Create a Non-Clustered Index on the `email` column of the `users` table to speed up lookups.
CREATE NONCLUSTERED INDEX IX_users_email
ON users (email);



--Q110:Drop a column `temporary_notes` from the `customer_feedback` table safely.
ALTER TABLE customer_feedback
DROP COLUMN IF EXISTS temporary_notes; 

--Date and Time Manipulation
--Q111:Use CURRENT_DATE or GETDATE() to find all orders placed exactly today , These dataset is older.
SELECT * FROM orders 
WHERE order_date = CAST(GETDATE() AS DATE);


--Q112:Use a DATEDIFF function to calculate the number of days a ticket was open (`resolved_date` `created_date`).
SELECT * , DATEdiff(day,created_date,resolved_date) as Time FROM tickets


--Q113:Add exactly 30 days to the `invoice_date` using DATEADD to calculate the `due_date`.
SELECT * ,DATEADD(day,30,invoice_date) as Due_date from orders


--Q114:Extract only the MONTH and YEAR from a timestamp column to aggregate monthly active users.
SELECT 
    YEAR(registration_date) AS reg_year,
    MONTH(registration_date) AS reg_month,
    COUNT(user_id) AS monthly_active_users
FROM users
WHERE status = 'Active'
GROUP BY YEAR(registration_date), MONTH(registration_date)
ORDER BY reg_year, reg_month;

--Q115:Use DATE_TRUNC to round a precise timestamp down to the nearest hour.
--NA

--Q116:Find the last day of the current month using LAST_DAY() or equivalent date math.
SELECT EOMONTH(GETDATE()) AS last_day_of_current_month;

--Q117:Filter for records where the `birth_date` occurred on a weekend (Saturday or Sunday).
SELECT * 
FROM customers 
WHERE DATENAME(WEEKDAY, birth_date) IN ('Saturday', 'Sunday');


--Q118:Calculate a user's exact age in years based on their `dob` and the current date.
SELECT * ,DATEdiff(year, birth_date, CURRENT_DATE) as ageI
FROM customers 
 
--Q119:Find the overlapping days between two different date ranges (start1, end1 and start2, end2).

--NA

--Q120:Format a raw datetime column into 'Day-MonthName-Year' (e.g., '15-August-2023') for a report.

SELECT 
    *,
    FORMAT(birth_date, 'dd-MMMM-yyyy') AS formatted_birth_date
FROM customers; 

--String Manipulation

--Q121:Concatenate `first_name` and `last_name` with a space in between to create a `full_name` column.
SELECT concat(first_name ,' ',  last_name) as full_name from customers

--Q122:Use SUBSTRING to extract the first 3 characters of a `phone_number` to find the area code.
SELECT * , SUBSTRING(phone , 1,3) as area_code from customers

--Q123:Use UPPER and LOWER to standardize all entered email addresses to lowercase.
SELECT lower( email)as lower_email FROM customers

--Q124:Find and REPLACE all instances of 'http://' with 'https://' in the `website_url` column.
-- 1. Create Temp Table
CREATE TABLE #web_logs (
    log_id INT IDENTITY(1,1),
    Website_urll VARCHAR(200)
);

-- 2. Insert Sample Data (including mock http URLs)
INSERT INTO #web_logs (Website_urll)
VALUES 
    ('http://example.com'),
    ('http://testsite.org'),
    ('https://already-secure.com'); -- Won't change if pattern doesn't match

-- 3. Run UPDATE with REPLACE
UPDATE #web_logs
SET Website_urll = REPLACE(Website_urll, 'http://', 'https://');

-- 4. Verify Results
SELECT * FROM #web_logs;

-- Cleanup
DROP TABLE #web_logs;
SELECT * FROM web_logs

--Q125:Use TRIM to remove accidental leading and trailing spaces from user-entered `usernames`.
SELECT * , trim(first_name) as t, len(first_name) ,len(trim(first_name))  from customers

--Q126:Find the position/index of the '@' symbol in an email address using CHARINDEX or POSITION.
SELECT 
    email,
    CHARINDEX('@', email) AS at_position
FROM customers;

--Q127:Extract everything after the '@' symbol to group users by their email domain.
SELECT 
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS email_domain,
    COUNT(*) AS user_count
FROM customers
WHERE email LIKE '%@%'
GROUP BY SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email))
ORDER BY user_count DESC;

--Q128:Pad a numeric `employee_id` with leading zeros (e.g., '00045') using LPAD or string math.
SELECT RIGHT('00000' + CAST(employee_id AS VARCHAR), 5) AS padded_id 
FROM employees;

--Q129:Split a comma-separated string 'Red,Green,Blue' and extract the second element.
SELECT value FROM STRING_SPLIT('Red,Green,Blue', ',');


--Q130:Calculate the LENGTH of EMAIL and flag any that are shorter than 20 characters.
SELECT *, LEN(email) as countemail , 
case when LEN(email)<20 then 1 else 0 end as flag
FROM employees

--Handling Nulls
--Q131:Use COALESCE to return 'N/A' whenever the `phone_number` column is NULL.
SELECT *, coalesce(phone , 'N/A') as updatedno from customers


--Q132:Replace NULL `bonus_amount` values with 0 using IFNULL before adding them to the salary.
select bonus_amount, isnull(bonus_amount, 0) as updatedbonus   from employees

--Q133:Write a WHERE clause to exclusively select rows where the `assigned_manager` IS NOT NULL.
select *  from employees
where assigned_manager is not null

--Q134:Understand aggregate behavior: Write a query showing the difference between COUNT(*) and COUNT(column_name).
SELECT count(*) as diff1 from employees
SELECT COUNT(bonus_amount) as diff2 from  employees

--Q135:Use COALESCE inside a JOIN condition to match records where keys might be missing.4
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    COALESCE(e.department_id, 1) AS resolved_department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d 
    ON d.department_id = COALESCE(e.department_id, 1);

--Q136:Use NULLIF to divide total sales by the number of complaints, preventing a divide-by-zero error.
SELECT 
    c.customer_id,
    c.first_name,
    SUM(s.amount) AS total_sales,
    cf.complaints,
    -- NULLIF converts 0 to NULL, returning NULL instead of throwing a divide-by-zero error
    SUM(s.amount) / NULLIF(cf.complaints, 0) AS sales_per_complaint
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN sales s ON o.order_id = s.order_id
LEFT JOIN customer_feedback cf ON c.customer_id = cf.customer_id
GROUP BY c.customer_id, c.first_name, cf.complaints;

--Q137:Sort a list of tasks by `due_date`, ensuring all tasks with NULL due dates appear at the very end.
SELECT 
    order_id,
    invoice_date,
    delivery_date
FROM orders
ORDER BY 
    CASE WHEN delivery_date IS NULL THEN 1 ELSE 0 END ASC, 
    delivery_date ASC;

--Q138:Filter a dataset to find rows where all three specific columns (`email`, `phone`, `address`) are NULL.
SELECT * from customers
where email is null and phone is null and address is null;

--Q139:Use CASE to create a boolean flag: 1 if `discount` IS NULL, else 0.

SELECT *,
CASE WHEN discount_code is null then 1 else 0 end as flag
from orders

--Q140:Perform string concatenation safely with NULLs (ensuring the whole string doesnt become NULL).
select *, CONCAT(email,phone,address) as info ,
coalesce(CONCAT(email,phone,address),'NA') as safetynulll
from customers


--Views and Materialized Views
--Q141:Create a standard VIEW called `vw_active_staff` that hides terminated employees from basic users.
DROP VIEW IF EXISTS vw_active_staff;
GO

CREATE VIEW vw_active_staff AS 
SELECT * FROM users 
WHERE is_active = 1;
GO

SELECT * FROM vw_active_staff;
GO

--Q142:Write a CREATE OR REPLACE VIEW statement to add a new calculated column to an existing view.
CREATE OR ALTER VIEW
vw_active_staff AS 
SELECT 
    user_id,
    username,
    email,
    status,
    is_active,
    last_login,
    -- New calculated column added here
    DATEDIFF(day, last_login, GETDATE()) AS days_since_login
FROM users
WHERE is_active = 1;
GO
SELECT * FROM vw_active_staff
GO
--Q143:Create a view that joins `orders`, `customers`to serve as a BI reporting layer.
DROP VIEW IF EXISTS vw_BI_reporting;
GO
CREATE VIEW vw_BI_reporting AS 
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS username,
    c.email,
    o.status, 
    c.phone
FROM orders O 
JOIN customers c ON O.CUSTOMER_ID = C.CUSTOMER_ID;
GO
--Q144:Query a system dictionary/catalog to find all views currently existing in the database.

SELECT 
    name AS view_name,
    create_date,
    modify_date
FROM sys.views;
GO

--Q145:Write a VIEW that restricts row access (e.g., only showing data for `region = 10`).
DROP VIEW IF EXISTS vw_region_north;
GO
CREATE VIEW vw_region_north AS 
SELECT *
FROM orders
WHERE region_id = 10;
GO

--Q146:Create a Materialized View for a highly complex daily sales aggregation to improve dashboard speed.
-- 1. Drop view if it already exists partially
DROP VIEW IF EXISTS vw_daily_sales_agg;
GO

-- 2. Recreate View with SCHEMABINDING and ISNULL
CREATE VIEW vw_daily_sales_agg
WITH SCHEMABINDING
AS
SELECT 
    CAST(transaction_date AS DATE) AS sale_date,
    store_id,
    COUNT_BIG(*) AS total_transactions,
    SUM(ISNULL(amount, 0)) AS total_sales
FROM dbo.sales
GROUP BY CAST(transaction_date AS DATE), store_id;
GO

-- 3. Create the Unique Clustered Index successfully
CREATE UNIQUE CLUSTERED INDEX IX_vw_daily_sales_agg 
ON vw_daily_sales_agg (sale_date, store_id);
GO

--Q147:Write the specific command required to REFRESH a Materialized View after a data load.
--NA

--Q148:Drop an obsolete view named `vw_2020_archived_metrics`.
--NA
--Q149:Create a view that utilizes a CTE and Window Functions to expose a pre-calculated 'Ranking'metric.
CREATE OR ALTER VIEW vw_employee_salary_ranking AS
SELECT 
    employee_id,
    first_name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;
GO

--Q150:Update a base table and write a query against a view to observe how standard views reflect
--real-time changes.
-- 1. Update the base table (e.g., increase salary for an employee)
UPDATE employees 
SET salary = salary + 10000 
WHERE employee_id = 2;

-- 2. Query the standard view immediately to observe real-time changes
SELECT 
    employee_id,
    first_name,
    salary
FROM vw_employee_salary_ranking
WHERE employee_id = 2;
GO