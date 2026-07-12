# Pipeline Summary

## Overview

This project demonstrates the implementation of an end-to-end data pipeline using **Azure Data Factory (ADF)** and **Azure Blob Storage**. The pipeline reads the Superstore dataset from a source Blob container, retrieves file metadata, copies the data to a destination container, and monitors the execution through Azure Data Factory.

---

## Architecture

```text
Superstore CSV
        │
        ▼
Azure Blob Storage (Source Container)
        │
        ▼
Azure Data Factory
   ├── Get Metadata Activity
   └── Copy Data Activity
        │
        ▼
Azure Blob Storage (Destination Container)
```

---

## Pipeline Workflow

1. Created a Resource Group in Azure.
2. Created a Storage Account.
3. Created Source and Destination Blob Containers.
4. Uploaded the Superstore CSV file to the Source Container.
5. Created an Azure Data Factory instance.
6. Configured Linked Services to connect Azure Data Factory with Azure Blob Storage.
7. Created Source and Destination Datasets.
8. Used the **Get Metadata** activity to retrieve file information.
9. Used the **Copy Data** activity to copy the dataset from the Source Container to the Destination Container.
10. Executed the pipeline using **Debug/Trigger**.
11. Monitored pipeline execution and verified successful completion.
12. Configured IAM roles to manage access between Azure Data Factory and Azure Storage.

---

## Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory
- Azure IAM (Role-Based Access Control)

---

## Activities Used

- Get Metadata
- Copy Data

---

## Dataset

**Dataset Name:** Superstore Dataset

The dataset was uploaded to Azure Blob Storage and processed using Azure Data Factory.

---

## Execution Result

- Pipeline executed successfully.
- File metadata was retrieved successfully.
- Dataset was copied from the Source Blob Container to the Destination Blob Container.
- Pipeline execution was monitored using Azure Data Factory Monitor.

---

## Outcome

This project demonstrates how Azure Data Factory can be used to build an end-to-end cloud-based data pipeline for moving and validating data stored in Azure Blob Storage.