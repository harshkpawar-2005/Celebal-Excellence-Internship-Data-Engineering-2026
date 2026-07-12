# Azure Cloud Fundamentals and Data Pipeline using Azure Data Factory

## Overview

This project demonstrates the implementation of an end-to-end cloud-based data pipeline using **Azure Data Factory (ADF)** and **Azure Blob Storage**.

The pipeline retrieves metadata from the source file, copies the dataset from one Blob container to another, and monitors execution through Azure Data Factory.

---

## Project Structure

```text
azure-adf-pipeline/
│
├── screenshots/
│   ├── 01_Resource_Group.png
│   ├── 02_Storage_Account.png
│   ├── 03_Blob_Container.png
│   ├── 04_Source_Container.png
│   ├── 05_Destination_Container.png
│   ├── 06_Azure_Data_Factory.png
│   ├── 07_Source_Dataset.png
│   ├── 08_Destination_Dataset.png
│   ├── 09_Pipeline_Design.png
│   ├── 10_Get_Metadata.png
│   ├── 11_Copy_Data.png
│   ├── 12_Pipeline_Success.png
│   ├── 13_Pipeline_Output.png
│   └── 14_IAM_Roles.png
│
├── pipeline-summary.md
└── README.md
```

---

## Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory
- Azure IAM (RBAC)

---

## Azure Data Factory Components

### Linked Services

- Azure Blob Storage (Source)
- Azure Blob Storage (Destination)

### Datasets

- Source Dataset
- Destination Dataset

### Activities

- Get Metadata
- Copy Data

---

## Pipeline Workflow

```text
CSV File
    │
    ▼
Azure Blob Storage (Source)
    │
    ▼
Azure Data Factory
    │
    ├── Get Metadata
    └── Copy Data
    │
    ▼
Azure Blob Storage (Destination)
```

---

## Features

- Resource Group creation
- Storage Account configuration
- Blob Container management
- Dataset creation
- Linked Service configuration
- Metadata validation
- Copy Data activity
- Pipeline monitoring
- IAM role configuration

---

## Dataset

**Superstore Dataset**

The dataset is stored in Azure Blob Storage and processed through Azure Data Factory.

---

## Outcome

Successfully implemented an end-to-end Azure data pipeline that validates metadata, copies data between Blob containers, and monitors execution through Azure Data Factory.

---

## Author

**Harshal Pawar**

Data Engineering Intern  
B.E. Artificial Intelligence & Data Science  
Dr. D. Y. Patil Institute of Technology, Pimpri, Pune