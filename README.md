# GoDaddy-Microbusiness-Density
This project exploration data analysis on Godaddy microbusiness density across US counties, analyzing trends, growth, and rankings using SQL queries on a Kaggle Dataset


This project demonstrates how to:
- Set up a MySQL 8.0 database instance in **Google Cloud SQL**
- Import a structured CSV file into Cloud SQL from **Google Cloud Storage (GCS)**
- Define and create relational database schema manually
- Explore the data using **window functions**, **CTEs**, and **aggregate functions** via **Cloud SQL Studio**
- Calculate **month-over-month growth in microbusiness density** by state and county

---

## 🌐 Tech Stack

| Tool           | Description                               |
|----------------|-------------------------------------------|
| Google Cloud SQL | Fully managed MySQL 8.0 database service |
| Cloud SQL Studio | SQL editor in browser for writing queries |
| GCS (Cloud Storage) | File upload and import staging area    |
| SQL (MySQL)     | For querying and analyzing data          |
| Visual Studio Code | For formatting and managing `.sql` files |

---

## 📁 Dataset Description

**File:** `train.csv`  
A dataset containing microbusiness-related statistics by county across monthly time periods.

**Columns:**
- `row_id` (VARCHAR): Unique row identifier
- `cfips` (INT): County FIPS code
- `county_name` (VARCHAR)
- `state_name` (VARCHAR)
- `first_day_of_month` (DATE)
- `microbusiness_density` (DECIMAL): 💡 Target variable
- `active` (INT): Raw count of businesses

---


