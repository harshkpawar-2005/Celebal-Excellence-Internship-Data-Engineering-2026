# Shopping Dataset Analysis

## Project Overview

This project focuses on performing exploratory data analysis (EDA), data cleaning, feature engineering, and visualization on a shopping dataset using Python and Pandas.

The goal of the analysis is to understand product pricing, popularity, category distribution, and identify useful business insights from the dataset.

---

## Dataset

Dataset Used: `Combined_dataset.csv`

The dataset contains information about products including:

- Product Title
- Category
- Rating
- Ratings Count
- Initial Price
- Final Price
- Discount
- Seller Information
- Customer Feedback

---

## Tasks Performed

### 1. Data Loading
- Loaded the dataset using Pandas.
- Checked dataset dimensions and column names.

### 2. Data Exploration
- Viewed sample records using `head()` and `tail()`.
- Examined data types using `info()`.
- Generated summary statistics using `describe()`.

### 3. Data Cleaning
- Identified missing values.
- Converted price-related columns into numeric format.
- Handled missing values in selected columns.
- Checked and removed duplicate records.

### 4. Feature Engineering
Created the following derived columns:

- **price_difference** = initial_price - final_price
- **popularity_score** = rating × ratings_count

### 5. Data Analysis
Performed:
- Category-wise analysis
- Product popularity analysis
- Pricing analysis

### 6. Data Visualization
Created visualizations including:
- Histogram of product prices
- Boxplot of product prices
- Top product categories bar chart
- Rating vs Final Price scatter plot

### 7. Output Generation
- Saved the cleaned dataset as `cleaned_dataset.csv`.

---
## Approach Followed

To complete this project, I followed a structured workflow:

1. Loaded the dataset into a Pandas DataFrame and explored its structure.
2. Examined column names, data types, and summary statistics to understand the data.
3. Identified missing values and checked for duplicate records.
4. Cleaned the dataset by handling missing values and converting price-related fields into numeric format.
5. Created additional features such as `price_difference` and `popularity_score` to support analysis.
6. Performed category-wise and product-level analysis to identify trends and patterns.
7. Visualized the results using histograms, boxplots, bar charts, and scatter plots.
8. Saved the cleaned dataset for future use and documented the findings.

## Key Findings

- The dataset contains 1000 products across multiple categories.
- No duplicate records were found in the dataset.
- Several columns such as videos, seller information, and customer feedback contain missing values.
- Product prices were cleaned and converted into numeric format for analysis.
- Tops, dresses, and shirts are the most common product categories.
- Trolley bags have the highest average product price among all categories.
- Most products are priced below ₹3000.
- A few products act as high-price outliers.
- Ratings alone do not show a strong relationship with product price.

---

## Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook

---

## Project Structure

```text
shopping-analysis/
│
├── data/
│   ├── Combined_dataset.csv
│   └── cleaned_dataset.csv
│
├── notebook/
│   └── analysis.ipynb
│
└── README.md
```

---

## Author

**Harshal Pawar**

B.E. Artificial Intelligence & Data Science  
Dr. D. Y. Patil Institute of Technology, Pimpri, Pune  
Data Engineering Intern