# Week 8 – E-Commerce Order Analytics

This repository contains the **Week 8 assignment** completed as part of the **Celebal Technologies Data Engineering Internship Program**.

The Week 8 assignment focuses on building an end-to-end **E-Commerce Order Analytics System** using Python and SQL, covering data generation, data cleaning, database processing, advanced SQL analytics, Python-SQL integration, and edge-case handling.

---

## Topics Covered

- Synthetic Data Generation
- Data Quality and Validation
- Data Cleaning using Pandas
- Missing Value Handling
- Data Standardization
- Regular Expression Validation
- Referential Integrity
- SQLite Database
- SQL Aggregations
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Running Totals
- Ranking and Segmentation
- Year-over-Year Analysis
- Cohort Analysis
- Python-SQL Integration
- Command-Line Reporting
- Edge-Case Handling

---

## Assignment

### E-Commerce Order Analytics System

The assignment uses four interconnected datasets:

- Customers
- Products
- Orders
- Order Items

The project covers the complete workflow from generating synthetic data and identifying data-quality issues to cleaning the datasets, performing SQL-based analysis, and generating reports using Python and SQL.

---

## Technologies Used

- Python
- Pandas
- SQL
- SQLite
- Regular Expressions
- Git
- GitHub

---

## Assignment Structure

```text
Week-8/
│
└── ecommerce-order-analytics/
    │
    ├── data/
    │   ├── raw_data/
    │   └── cleaned_data/
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

---

## Key Components

### Data Generation

Generated synthetic e-commerce data containing intentional data-quality issues for realistic data processing.

### Data Cleaning

Used Python and Pandas to:

- Handle missing customer IDs
- Standardize order dates
- Normalize product names
- Validate customer emails
- Check referential integrity

### SQL Analytics

Performed business analysis using:

- Aggregations
- CTEs
- Subqueries
- Window Functions
- Ranking
- Running Totals
- Customer Segmentation
- Cohort Analysis

### Python-SQL Integration

Built a command-line reporting tool using Python and SQLite for generating date-based business reports.

### Edge-Case Handling

Validated scenarios involving:

- Invalid order IDs
- Invalid discount percentages
- Zero quantities
- Future order dates

---

## Progress

| Component | Status |
|------|--------|
| Synthetic Data Generation | ✅ Completed |
| Data Cleaning & Validation | ✅ Completed |
| SQLite Database Processing | ✅ Completed |
| SQL Analysis | ✅ Completed |
| Python-SQL Integration | ✅ Completed |
| Edge-Case Handling | ✅ Completed |
| Documentation | ✅ Completed |

---

## Assignment Location

```text
Week-8/ecommerce-order-analytics/
```

---

## Author

**Harshal Pawar**

Data Engineering Intern  
B.E. Artificial Intelligence & Data Science  
Dr. D. Y. Patil Institute of Technology, Pimpri, Pune