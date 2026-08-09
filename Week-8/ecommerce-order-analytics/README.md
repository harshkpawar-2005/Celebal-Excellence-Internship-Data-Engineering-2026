# E-Commerce Order Analytics System

## Overview

This project is developed as part of **Week 8 of the Celebal Technologies Data Engineering Internship Program**.

The project implements an end-to-end e-commerce data processing and analytics workflow using **Python and SQL**. Synthetic datasets are generated with intentional data-quality issues, cleaned and validated using Python, loaded into a SQLite database, and analyzed using SQL.

The project also includes a Python-SQL command-line reporting tool and edge-case validation.

---

## Objectives

The main objectives of this project are:

- Generate synthetic e-commerce datasets.
- Introduce realistic data-quality issues.
- Clean and validate the generated data.
- Perform SQL-based business analysis.
- Apply advanced SQL concepts and window functions.
- Integrate Python with SQL using SQLite.
- Build a command-line reporting tool.
- Handle important data edge cases.

---

## Technology Stack

- Python
- Pandas
- SQL
- SQLite
- Regular Expressions
- Git
- GitHub

---

## Dataset

The project consists of four interconnected datasets.

### Customers

Contains:

- `customer_id`
- `customer_name`
- `email`
- `registration_date`
- `customer_type`

### Products

Contains:

- `product_id`
- `product_name`
- `category`
- `subcategory`
- `cost_price`

### Orders

Contains:

- `order_id`
- `customer_id`
- `order_date`
- `status`
- `region_code`

### Order Items

Contains:

- `item_id`
- `order_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_percent`

---

## Project Structure

```text
ecommerce-order-analytics/
│
├── data/
│   ├── raw_data/
│   │   ├── customers.csv
│   │   ├── order_items.csv
│   │   ├── orders.csv
│   │   └── products.csv
│   │
│   └── cleaned_data/
│       ├── cleaned_customers.csv
│       ├── cleaned_order_items.csv
│       ├── cleaned_orders.csv
│       └── cleaned_products.csv
│
├── output/
│   └── Data Cleaning Report.txt
│
├── scripts/
│   ├── generate_data.py
│   ├── data_cleaning.py
│   ├── create_database.py
│   ├── edge_case_handling.py
│   └── cli_report.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregation.sql
│   ├── window_functions.sql
│   ├── advance_query.sql
│   └── cohort_analysis.sql
│
├── .gitignore
├── README.md
└── performance-summary.md
```

The SQLite database is generated locally using `create_database.py` and is excluded from GitHub.

---

## Data Generation

The `generate_data.py` script creates the four synthetic datasets.

The generated data intentionally contains several data-quality issues to simulate real-world data inconsistencies.

These include:

- Missing `customer_id` values
- Inconsistent order-date formats
- Negative quantities representing returns
- Product-name formatting inconsistencies
- Invalid customer email addresses

The raw datasets are stored in:

```text
data/raw_data/
```

---

## Data Cleaning and Validation

The `data_cleaning.py` script processes the generated raw datasets.

### Orders

The cleaning process:

- Identifies missing customer IDs.
- Replaces missing customer IDs with `-1`.
- Converts inconsistent order-date formats into a standard format.

### Products

Product names are standardized by:

- Removing unnecessary whitespace.
- Converting names to Title Case.

### Customer Emails

Customer email addresses are checked using a regular expression to identify invalid formats.

### Referential Integrity

The relationship between:

```text
orders.order_id
```

and:

```text
order_items.order_id
```

is checked to identify invalid order references.

The cleaned datasets are stored in:

```text
data/cleaned_data/
```

A detailed summary of the identified data-quality issues is available in:

```text
output/Data Cleaning Report.txt
```

---

## SQLite Database

The cleaned datasets are loaded into a local SQLite database.

The database contains four tables:

```text
customers
products
orders
order_items
```

The database is created by:

```text
scripts/create_database.py
```

The database is generated locally under:

```text
database/ecommerce.db
```

The `database/` directory is excluded from GitHub because the database can be recreated from the cleaned CSV files.

---

## SQL Analysis

The project performs business-oriented analysis using SQL.

### Basic Analysis

- Total revenue per category
- Top 10 customers by total order value
- Month-wise order count for the last 12 months

### Intermediate Analysis

- Customers who placed orders but never had delivered items
- Products with more returns than purchases
- Return rate per category

### Advanced SQL Analysis

The project applies:

- Running totals
- `DENSE_RANK()`
- `LAG()`
- Common Table Expressions
- `NTILE(4)`
- Year-over-Year revenue comparison
- `FIRST_VALUE()`
- Cumulative revenue distribution
- Cohort analysis
- Self joins for frequently purchased product combinations

---

## Python-SQL Integration

The `cli_report.py` script provides a command-line reporting interface.

The user can select:

```text
daily
weekly
monthly
```

and enter a start and end date.

The generated report includes:

- Total orders
- Revenue
- Unique customers
- Top 3 products
- Previous-period comparison
- Percentage change

The application connects to SQLite using Python's built-in `sqlite3` module.

---

## Edge-Case Validation

The `edge_case_handling.py` script checks the following scenarios:

1. Invalid `order_id`
2. `discount_percent > 100`
3. `quantity = 0`
4. Future `order_date`

These checks help identify invalid records before they affect downstream analysis.

---

## Processing Workflow

```text
Synthetic Data Generation
          ↓
       Raw CSVs
          ↓
 Python Cleaning & Validation
          ↓
     Cleaned CSVs
          ↓
     SQLite Database
          ↓
      SQL Analysis
          ↓
   Python-SQL Reporting
          ↓
    Edge-Case Testing
```

---

## How to Run

### 1. Generate datasets

```bash
python scripts/generate_data.py
```

### 2. Clean and validate data

```bash
python scripts/data_cleaning.py
```

### 3. Create SQLite database

```bash
python scripts/create_database.py
```

### 4. Run edge-case tests

```bash
python scripts/edge_case_handling.py
```

### 5. Run CLI reporting tool

```bash
python scripts/cli_report.py
```

The SQL queries are available in the `sql/` directory.

---

## Conclusion

The E-Commerce Order Analytics System demonstrates a complete local data-processing workflow using Python and SQL.

The project covers synthetic data generation, data-quality management, relational database processing, advanced SQL analytics, Python-SQL integration, and edge-case validation.

The resulting workflow transforms raw e-commerce data into cleaned datasets and meaningful analytical outputs suitable for business reporting.