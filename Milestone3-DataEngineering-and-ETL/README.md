# Milestone 3

_This milestone was designed to evaluate learning progress in the Hacktiv8 Comprehensive Data Analytics Program, specifically in Phase 2._

---

## Overview

For this milestone, a **data pipeline automation project** was completed using the **Superstore dataset**, which simulates a retail platform preparing for a year-end promotional campaign.  

The goal of this program was to **analyze customer data to maximize the impact of promotional campaigns** by identifying customers most likely to respond positively.  

As the customer base expanded, the volume of data became too large for manual management, making automation essential.

The solution included:  

- **Data cleaning and transformation** using **PySpark**  
- **Storage of processed data** in **MongoDB**  
- **Automation of the ETL pipeline** with **Airflow**

This project demonstrates how automated pipelines can handle large datasets efficiently, reduce errors, and provide actionable insights for business decision-making.

---

## Assignment Objectives

The following abilities were demonstrated through this milestone:

- Automation of ETL processes using Apache Airflow  
- Validation of data using Great Expectations  
- Efficient preparation and processing of data with PySpark  
- Storage of clean and structured data in a NoSQL database (MongoDB)  

---

## Assignment Problems

As a Data Engineer, a **fully automated ETL pipeline** was required for the Superstore dataset, covering extraction, transformation, validation, and loading into MongoDB.

--- 

### Data Sources

A public dataset from **Kaggle** was selected to meet the requirements.

---

## Assignment Instructions

A **data pipeline automation system (ETL)** was built using **PySpark, Airflow, and MongoDB**.

### A. Pre-Automation

1. The Superstore dataset was selected and saved as `P2M3_<student-name>_data_raw.csv`.  
2. **Exploratory data analysis** and **data validation** were conducted in a Jupyter Notebook.  
3. **Great Expectations** was applied with **7 Expectations**.
4. All Expectations returned `success: true`.  

### B. Automated Data Pipeline

1. **Extract**  
   - `extract.py` was created to read the dataset using PySpark  
   - Functions were built to return Spark DataFrames  

2. **Transform**  
   - `transform.py` was created to clean and transform data with PySpark  
   - Steps followed conclusions from the pre-automation analysis  

3. **Load**  
   - `load.py` was created to save transformed data into **MongoDB**  
   - Data storage was verified with screenshots  

### Workflow Orchestration

- An **Airflow DAG** was built with three tasks: `Extract`, `Transform`, `Load`.  
- DAG was scheduled to run every Saturday from 09:10–09:30 AM, every 10 minutes.  

---

## Outcome

This milestone allowed demonstration of the following capabilities:

1. Efficient handling of large datasets through automated pipelines  
2. Programmatic cleaning, validation, and transformation of data using PySpark and Great Expectations  
3. Automation of ETL workflows with Airflow  
4. Storage of clean and structured data in MongoDB for business purposes  
5. Generation of actionable insights for campaign planning and customer targeting  

