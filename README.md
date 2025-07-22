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

<img width="1145" height="512" alt="Screenshot 2025-07-22 at 6 08 44 PM" src="https://github.com/user-attachments/assets/8ce0a9ee-6ad3-4000-9905-f169ae3bbc5e" />


<img width="1147" height="499" alt="Screenshot 2025-07-22 at 6 07 57 PM" src="https://github.com/user-attachments/assets/d2244f5b-cd0f-422f-b7e4-6b0321522e32" />

<img width="1146" height="505" alt="Screenshot 2025-07-22 at 6 07 22 PM" src="https://github.com/user-attachments/assets/9237134f-6694-4e8f-b2b5-a0d1fbb6ae71" />

<img width="1159" height="514" alt="Screenshot 2025-07-22 at 6 06 23 PM" src="https://github.com/user-attachments/assets/4e57e974-dc16-4856-949c-8334dda7b84c" />


