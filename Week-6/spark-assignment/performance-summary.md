# Performance Summary

## Assignment Overview

This assignment demonstrates the fundamentals of Apache Spark using PySpark to process the Superstore dataset. The workflow includes data loading, schema inspection, DataFrame transformations, filtering, aggregation, and efficient data storage.

---

## Objectives Achieved

- Created and configured a SparkSession.
- Loaded the Superstore dataset into a Spark DataFrame.
- Explored the dataset using Spark DataFrame operations.
- Applied filtering and column transformations.
- Handled missing values.
- Performed aggregations using `groupBy()`.
- Compared CSV and Parquet storage formats.
- Understood Spark execution concepts and optimization techniques.

---

## Spark Performance Concepts

### Lazy Evaluation
Spark records transformations without executing them immediately. The transformations are executed only when an action such as `show()`, `count()`, or `write()` is called. This enables Spark to optimize the execution plan.

### Directed Acyclic Graph (DAG)
Spark builds a DAG of transformations before execution. The DAG Scheduler optimizes the workflow and divides it into stages for efficient processing.

### Narrow and Wide Transformations

- **Narrow Transformations** (e.g., `select()`, `filter()`, `withColumn()`) process data within the same partition and require minimal data movement.
- **Wide Transformations** (e.g., `groupBy()`) require shuffling data across partitions, making them more computationally expensive.

### Data Shuffling

Aggregation operations such as `groupBy()` involve shuffling, where records are redistributed among executors. Although necessary for many analytical operations, shuffling increases network and disk I/O.

---

## CSV vs Parquet

| CSV | Parquet |
|------|----------|
| Row-based storage | Columnar storage |
| Larger storage size | Compressed storage |
| Slower analytical queries | Faster analytical queries |
| Plain text format | Optimized for Spark and Big Data |

Parquet provides better storage efficiency and query performance, making it the preferred format for analytical workloads.

---

## Best Practices Applied

- Used the Spark DataFrame API for distributed processing.
- Inspected and validated the dataset schema before transformations.
- Applied filtering and transformations using built-in Spark functions.
- Performed aggregations using `groupBy()`.
- Leveraged Spark's lazy evaluation model for optimized execution.
- Stored processed data in efficient formats where applicable.

---

## Key Learning Outcomes

- Learned the fundamentals of Apache Spark architecture.
- Understood distributed data processing using PySpark.
- Worked with DataFrame transformations and actions.
- Explored Spark optimization concepts such as Lazy Evaluation and DAG execution.
- Gained practical experience in processing structured datasets using Spark.

---

## Conclusion

The assignment successfully demonstrates an end-to-end Spark data processing workflow using the Superstore dataset. It provides hands-on experience with Spark DataFrames, transformations, aggregations, and core performance concepts that are essential for scalable data engineering applications.