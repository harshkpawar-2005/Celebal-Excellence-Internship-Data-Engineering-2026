# Week 8 Performance Summary

## E-Commerce Order Analytics System

### Project Summary

The Week 8 assignment involved developing an end-to-end e-commerce data processing and analytics workflow using Python and SQL.

Synthetic datasets were created with intentional data-quality issues and then processed through cleaning, validation, database loading, SQL analysis, and Python-based reporting.

---

## Data Generation

Four interconnected datasets were generated:

- Customers
- Products
- Orders
- Order Items

The generated data included intentional issues such as:

- Missing customer IDs
- Inconsistent date formats
- Invalid email addresses
- Product-name formatting inconsistencies
- Negative quantities representing returns

This provided a realistic environment for applying data-quality validation techniques.

---

## Data Cleaning

Python and Pandas were used to prepare the generated data for analysis.

The cleaning workflow covered:

- Missing customer ID handling
- Date standardization
- Product-name normalization
- Email validation
- Referential integrity checking

The cleaned datasets were stored separately from the raw datasets so that the original generated data remained available for reference.

---

## Database Processing

The cleaned CSV files were loaded into a SQLite database containing:

```text
customers
products
orders
order_items
```

A separate database-creation script was implemented so that the database can be recreated from the cleaned datasets whenever required.

The generated database is treated as a local artifact and excluded from version control.

---

## SQL Analysis

The SQL component covered both basic business queries and advanced analytical techniques.

The implemented analysis included:

- Revenue analysis
- Customer ranking
- Monthly order trends
- Return analysis
- Running totals
- Customer order gaps
- Customer segmentation
- Quartile-based classification
- Year-over-Year comparison
- Product category shifts
- Cumulative revenue contribution
- Cohort analysis
- Frequently purchased product combinations

Advanced SQL features used include:

- CTEs
- Window functions
- `DENSE_RANK()`
- `LAG()`
- `NTILE()`
- `FIRST_VALUE()`
- Self joins
- Aggregations

---

## Python-SQL Integration

A command-line reporting tool was developed using Python and SQLite.

The tool accepts a reporting period and date range and provides:

- Total orders
- Revenue
- Unique customers
- Top three products
- Previous-period comparison
- Percentage change

This demonstrated practical integration between Python application logic and SQL-based data analysis.

---

## Edge-Case Testing

The project includes validation for:

- Invalid order references
- Discount values greater than 100%
- Zero quantities
- Future order dates

These checks help identify problematic records before they can affect downstream analytical results.

---

## Project Workflow

```text
Data Generation
      ↓
Data Cleaning
      ↓
Data Validation
      ↓
SQLite Database
      ↓
SQL Analysis
      ↓
Python-SQL Reporting
      ↓
Edge-Case Testing
```

The separation of these stages makes the project easier to maintain, test, and reproduce.

---

## Key Learning Outcomes

The project provided practical experience with:

- Python data processing
- Pandas
- Data-quality validation
- SQLite
- Relational data handling
- SQL aggregations
- CTEs
- Window functions
- Cohort analysis
- Python-SQL integration
- CLI application development
- Edge-case testing
- Data engineering workflow design

---

## Final Outcome

The completed project demonstrates a complete local e-commerce analytics workflow, beginning with synthetic data generation and ending with SQL-driven business analysis and Python-based reporting.

It combines data preparation, quality validation, database processing, advanced SQL, and application-level reporting into a single structured project.