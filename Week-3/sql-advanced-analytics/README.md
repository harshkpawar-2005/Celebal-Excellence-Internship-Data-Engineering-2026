# SQL Advanced Analytics Assignment

## Overview

This project is part of **Week 3** of the Celebal Technologies Data Engineering Internship.

The objective of this assignment is to apply advanced SQL concepts such as **Subqueries, Common Table Expressions (CTEs), and Window Functions** to analyze sales data from the Superstore dataset and generate meaningful business insights.

---

## Objectives

- Load the Superstore dataset into a staging table
- Create normalized dimension tables using `SELECT DISTINCT`
- Analyze data using Subqueries
- Simplify complex queries using CTEs
- Apply Window Functions for ranking and segmentation
- Generate customer sales insights
- Practice real-world SQL analytics

---

## Project Structure

```text
sql-advanced-analytics/
│
├── schema/
│   ├── 01_create_database.sql
│   ├── 02_create_superstore_raw.sql
│   └── 03_create_dimension_tables.sql
│
├── Section_A/
│   └── subqueries.sql
│
├── Section_B/
│   └── ctes.sql
│
├── Section_C/
│   └── window_functions.sql
│
├── Section_D/
│   └── customer_sales_insights.sql
│
└── README.md
```

---

## Topics Covered

### Schema Design

- Database creation
- Staging table (`superstore_raw`)
- Customers table
- Orders table
- Products table

---

### Section A – Subqueries

- Subqueries in `WHERE`
- Aggregate subqueries
- Nested subqueries
- Above-average sales analysis
- Highest sales order identification

---

### Section B – Common Table Expressions (CTEs)

- WITH clause
- Reusable query blocks
- Customer sales aggregation
- Category sales analysis
- Region-wise sales analysis

---

### Section C – Window Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- Customer ranking
- Product ranking

---

### Section D – Customer Sales Insights

- Top customers
- Bottom customers
- Single-order customers
- Customer sales ranking
- Above-average customers

---

## Dataset

Sample Superstore Dataset

Records: **9,989**

---

## Technologies Used

- MySQL 8.0
- MySQL Workbench
- SQL

---

## SQL Concepts Practiced

- SELECT
- DISTINCT
- GROUP BY
- Aggregate Functions
- Subqueries
- CTEs
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- ORDER BY
- Business Analytics Queries

---

## Key Insights

- Technology generated the highest sales among all categories.
- The West region recorded the highest overall sales.
- Customer sales ranking identified the highest-value customers.
- Window functions simplified ranking and segmentation tasks.
- CTEs improved query readability and maintainability.

---

## Author

**Harshal Pawar**

Data Engineering Intern  
B.E. Artificial Intelligence & Data Science  
Dr. D. Y. Patil Institute of Technology, Pimpri, Pune 