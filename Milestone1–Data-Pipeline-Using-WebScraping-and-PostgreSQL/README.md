
# Milestone 1 – Hacktiv8 Comprehensive Data Analytics Program (Phase 0)

This milestone demonstrates my learning during **Phase 0** of the Hacktiv8 Comprehensive Data Analytics Program. The project showcases my ability to build a basic **data pipeline (ETL)** using real web data, from extraction to loading into a database.

---

## Project Overview

For this milestone, I created a program to collect and clean **makeup product data from Sociolla** to analyze **sales trends and consumer preferences**.  

As a potential dropshipper, I focused on products with **5.0 ratings**, which indicate high customer satisfaction. The collected data includes: Brand, Product name, Rating, Number of reviews, Original and discounted price & Discount amount  

Using **web scraping** and **data cleaning techniques**, this program helps me identify **high-potential products** to resell, especially those highly liked and heavily discounted.

---

## Steps & Deliverables

| Step | Description | Deliverable |
|------|-------------|------------|
| **Extract** | Collected data from the Sociolla website using web scraping. | Notebook file (`.ipynb`) with scraping code and explanations. |
| **Transform** | Cleaned and preprocessed the data using Pandas. Ensured numeric columns were correct and consistent, handled missing values, and saved the cleaned data as `.csv`. | Cleaned CSV file. |
| **Load** | Created a PostgreSQL database and tables matching the CSV structure. Inserted cleaned data into the database. | SQL file (`.sql`) with table creation and insert statements. |
| **Documentation** | Added markdown and comments to explain each step of the process in both notebook and SQL scripts. | Fully documented notebook and SQL scripts. |

---

## Outcome

This milestone allowed me to demonstrate my ability to:

1. **Collect data from real-world sources** using web scraping techniques, ensuring I can extract relevant information programmatically.  
2. **Clean and preprocess data** using Python (Pandas) to handle missing values, correct data types, and prepare it for analysis.  
3. **Design and populate a relational database** (PostgreSQL) with structured tables matching the cleaned dataset.  
4. **Document the workflow** clearly with markdown and comments, making the process reproducible and understandable.  
5. **Analyze and identify actionable insights** from product data, such as top-rated items and high-discount products, to inform business decisions.  
6. **Showcase a complete data pipeline (ETL)** from extraction to storage, demonstrating end-to-end data handling skills.  
