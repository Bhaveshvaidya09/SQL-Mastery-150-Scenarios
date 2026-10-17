# 🚀 SQL Mastery & Scenario Bank: 150 Advanced T-SQL Queries

A comprehensive, hand-crafted collection of 150 distinct T-SQL practice scenarios designed to build production-grade database and analytical proficiency[cite: 3]. Built on top of a custom-engineered relational database environment (`SQLMasteryDB`)[cite: 1], this repository covers everything from foundational queries to advanced window functions, CTEs, and schema optimization[cite: 3, 9, 10, 17].

---

## 🗄️ Database Architecture (`SQLMasteryDB`)
The simulation environment includes a fully populated relational database consisting of multiple interconnected operational tables and mock datasets[cite: 1]:
* Core entities include `departments`, `employees`, `customers`, `users`, and `vendors`[cite: 1].
* Inventory and product catalog components include `products`, `inventory`, and `reviews`[cite: 1].
* Transactional and tracking records include `orders`, `order_items`, `sales`, `transactions`, and `date_dim`[cite: 1].
* Specialized auxiliary tables include `colors`, `sizes`, `b2b_customers`, `b2c_customers`, `Cart`, `Wishlist`, `hr_roster`, `payroll`, `web_logs`, `customer_feedback`, and `tickets`[cite: 1].

---

## 📊 Core Categories Covered (150 Scenarios)
The scenario bank is systematically categorized into 15 core analytical domains[cite: 3]:
* **Core Query Structure & Sorting:** Setting up queries, aliases, and explicit ordering[cite: 3].
* **Filtering Operators:** Utilizing `LIKE`, `IN`, `BETWEEN`, and range filtering[cite: 4].
* **Aggregation and Grouping:** Summarizing data using `GROUP BY` and `HAVING` clauses[cite: 5].
* **Joins:** Implementing inner, left, right, full outer, self, cross, and anti-joins[cite: 6].
* **Conditional Logic:** Using `CASE` statements and `IIF` evaluations[cite: 7].
* **Basic Data Type Conversions:** Applying `CAST`, `CONVERT`, and `TRY_CAST` functions[cite: 8].
* **Window Functions:** Leveraging `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG/LEAD`, and moving averages[cite: 9].
* **Common Table Expressions (CTEs):** Writing modular queries and recursive organizational charts[cite: 10].
* **Subqueries:** Utilizing scalar, `IN`, `EXISTS`, derived tables, and correlated subqueries[cite: 11].
* **Set Operations:** Combining data using `UNION`, `UNION ALL`, `INTERSECT`, and `EXCEPT`[cite: 12].
* **Data Manipulation and Definition (DML/DDL):** Managing tables, constraints, indexes, updates, and deletes[cite: 13].
* **Date and Time Manipulation:** Calculating intervals, formatting dates, and managing timestamps[cite: 14].
* **String Manipulation:** Executing text concatenation, substring extractions, and replacements[cite: 15].
* **Handling Nulls:** Managing missing data with `COALESCE`, `NULLIF`, and `ISNULL`[cite: 16].
* **Views and Materialized Views:** Building standard views and indexed views with `SCHEMABINDING`[cite: 17].

---

## 🛠️ How to Run & Test
1. Open **SQL Server Management Studio (SSMS)**[cite: 1].
2. Execute the database schema setup script to create the `SQLMasteryDB` environment and populate all relational tables[cite: 1].
3. Run and test the comprehensive query solution script containing answers for Q1 through Q150[cite: 2, 3].
