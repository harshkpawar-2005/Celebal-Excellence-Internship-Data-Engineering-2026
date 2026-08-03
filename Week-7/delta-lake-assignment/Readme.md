# Delta Lake Incremental Data Processing Assignment

## Overview

This project demonstrates incremental data processing using **PySpark** and **Delta Lake** in **Databricks**. The assignment includes loading a dataset, performing data cleaning, creating an incremental dataset, applying a Delta Lake `MERGE` operation, and validating the final results.

---

## Objectives

- Load a CSV dataset into a Delta table.
- Perform basic data cleaning.
- Create an incremental dataset to simulate new incoming data.
- Apply the Delta Lake `MERGE` operation to:
  - Update existing records.
  - Insert new records.
- Validate the final dataset.
- Export the processed datasets.

---

## Technologies Used

- Databricks
- Apache Spark (PySpark)
- Delta Lake
- Python

---

## Project Structure

```text
delta-lake-assignment/
│
├── data/
│   ├── customer_master.csv
│   └── customer_incremental.csv
│
├── notebooks/
│   └── delta_scd_assignment.py
│
├── screenshots/
│   ├── data_loading/
│   ├── data_cleaning/
│   ├── scd1/
│   ├── validation/
│   └── final_output/
│
└── README.md
```

---

## Dataset

The assignment uses the **Sample Superstore** dataset.

### Master Dataset

The cleaned Superstore dataset is stored as:

- `customer_master.csv`

### Incremental Dataset

A second dataset was created by:

- Selecting a subset of records from the master dataset.
- Updating existing records.
- Adding a new customer record.

This dataset is stored as:

- `customer_incremental.csv`

---

## Steps Performed

### 1. Data Loading

- Loaded the CSV dataset into a Spark DataFrame.
- Displayed the dataset.
- Explored schema and data types.

---

### 2. Data Cleaning

Performed the following operations:

- Checked missing values.
- Removed duplicate records.
- Filtered records.
- Created a derived column:

```text
Price_per_Unit = Sales / Quantity
```

- Renamed column names to make them Delta Lake compatible.

---

### 3. Create Delta Master Table

The cleaned DataFrame was saved as a Delta table.

```text
workspace.default.customer_master
```

---

### 4. Create Incremental Dataset

Created an incremental dataset by:

- Selecting five existing records.
- Updating existing record values.
- Adding a new customer record.

Saved as:

```text
workspace.default.customer_incremental
```

---

### 5. Delta MERGE Operation (SCD Type 1)

Applied the Delta Lake `MERGE` operation using **Row_ID** as the merge key.

Operations performed:

- Updated matching records.
- Inserted new records.

---

### 6. Validation

Validated the results by:

- Checking the final row count.
- Verifying updated records.
- Verifying inserted records.
- Displaying the final Delta table.

---

## Key Delta Lake Features Demonstrated

- Delta Tables
- ACID Transactions
- MERGE (Upsert)
- Update Existing Records
- Insert New Records
- Incremental Data Processing

---

## Output

The project successfully demonstrates incremental data processing using Delta Lake by:

- Creating a master Delta table.
- Simulating incremental data.
- Performing update and insert operations using `MERGE`.
- Validating the final dataset.

---

## Learning Outcomes

Through this assignment, the following concepts were learned:

- Apache Spark DataFrames
- Data Cleaning using PySpark
- Delta Lake Architecture
- Delta Tables
- SCD Type 1 (Overwrite Strategy)
- MERGE Operation
- Incremental Data Processing
- Databricks Workspace

---

## Author

**Harshal Pawar**

Data Engineering Intern

B.E. Artificial Intelligence & Data Science

Dr. D. Y. Patil Institute of Technology, Pimpri, Pune