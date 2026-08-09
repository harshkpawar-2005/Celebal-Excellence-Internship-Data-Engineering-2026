DATA QUALITY & CLEANING SUMMARY

Project: E-Commerce Order Analytics System

------------------------------------------------------------
1. PURPOSE
------------------------------------------------------------

The synthetic e-commerce data was created with intentional
inconsistencies to represent common data-quality problems found
in real-world datasets.

A Python-based cleaning and validation process was applied before
the datasets were used for database loading and SQL analysis.

The validation process covered:

• Order data standardization
• Missing customer identifier handling
• Product name normalization
• Email format verification
• Order-to-item relationship validation


------------------------------------------------------------
2. ORDER DATA QUALITY
------------------------------------------------------------

The order dataset contained missing customer identifiers and
multiple date representations.

Processing performed:

• 100 records contained a missing customer_id.
• Missing identifiers were assigned the placeholder value -1.
• 100 records contained dates requiring format standardization.
• The affected dates were converted into the common
  YYYY-MM-DD HH:MM:SS representation.

Final Status:
Order records were standardized and prepared for downstream
processing.


------------------------------------------------------------
3. PRODUCT NAME STANDARDIZATION
------------------------------------------------------------

Product descriptions were reviewed for formatting inconsistencies.

The cleaning process addressed:

• Unwanted whitespace around product names
• Inconsistent capitalization

Results:

• 15 product names required whitespace cleanup.
• 60 product names required capitalization normalization.
• Product names were converted to Title Case.


------------------------------------------------------------
4. CUSTOMER EMAIL CHECK
------------------------------------------------------------

Customer email addresses were checked using a regular-expression
based validation rule.

The validation identified 14 records with an invalid email format.

Affected customer IDs:

64, 66, 157, 212, 220, 339, 399,
418, 425, 426, 431, 478, 556, 599

These records were reported for further correction rather than
being silently modified.


------------------------------------------------------------
5. ORDER RELATIONSHIP CHECK
------------------------------------------------------------

A referential consistency check was performed between:

orders.order_id

and

order_items.order_id

Every order-item record was compared against the available order
identifiers.

Result:

Invalid order references: 0

Therefore, all order-item records had a corresponding order
record in the generated dataset.


------------------------------------------------------------
6. QUALITY CHECK RESULTS
------------------------------------------------------------

Check                                      Result
------------------------------------------------------------
Missing customer IDs                         100
Order dates requiring correction             100
Product names requiring trimming              15
Product names requiring normalization         60
Invalid customer emails                       14
Invalid order references                       0


------------------------------------------------------------
7. CLEAN DATA OUTPUT
------------------------------------------------------------

The processing stage produced the following datasets:

• cleaned_customers.csv
• cleaned_products.csv
• cleaned_orders.csv
• cleaned_order_items.csv

These files represent the standardized datasets used for the
subsequent database and SQL analysis stages.


------------------------------------------------------------
8. FINAL OBSERVATION
------------------------------------------------------------

The data-quality process successfully identified the intentional
issues introduced into the synthetic datasets.

Missing identifiers were handled using a defined placeholder,
date representations were standardized, product naming was made
consistent, invalid email formats were identified, and the
relationship between orders and order items was validated.

The resulting datasets are ready to be loaded into the SQLite
database and used for the analytical queries and reporting
components of the project.