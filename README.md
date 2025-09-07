# GoDaddy-Microbusiness-Density
This project exploration data analysis on Godaddy microbusiness density across US counties, analyzing trends, growth, and rankings using SQL queries on a Kaggle Dataset

## Problem Context (Kaggle Story)

American policy leaders strive to develop economies that are more inclusive and resilient to downturns. They're also aware that with advances in technology, entrepreneurship has never been more accessible than it is today.  

Whether to create a more appropriate work/life balance, to follow a passion, or due to loss of employment, studies have demonstrated that Americans increasingly choose to create businesses of their own to meet their financial goals.  

The challenge is that these **microbusinesses** are often too small or too new to show up in traditional economic data sources, making it nearly impossible for policymakers to study them.  

But **data science** could help fill in the gaps and provide insights into the factors associated with these businesses.



---

## 🌐 Tech Stack

| Tool           | Description                               |
|----------------|-------------------------------------------|
| Google Cloud SQL | Fully managed MySQL 8.0 database service |
| Cloud SQL Studio | SQL editor in browser for writing queries |
| GCS (Cloud Storage) | File upload and import staging area    |
| SQL (MySQL)     | For querying and analyzing data          |
| Visual Studio Code | For formatting and managing `.sql` files |

This project demonstrates how to:
- Set up a MySQL 8.0 database instance in **Google Cloud SQL**
- Import a structured CSV file into Cloud SQL from **Google Cloud Storage (GCS)**
- Define and create relational database schema manually
- Explore the data using **window functions**, **CTEs**, and **aggregate functions** via **Cloud SQL Studio**
- Calculate **month-over-month growth in microbusiness density** by state and county

---

## 📁 Dataset Description


- ## Data Dictionary

| Column                | Description |
|------------------------|-------------|
| **row_id**             | An ID code for the row. |
| **cfips**              | A unique identifier for each county using the Federal Information Processing System (FIPS). The first two digits correspond to the state FIPS code, while the following three represent the county. |
| **county_name**        | The written name of the county. |
| **state_name**         | The name of the state. |
| **first_day_of_month** | The date of the first day of the month. |
| **microbusiness_density** | Microbusinesses per 100 people over the age of 18 in the given county. This is the **target variable**. The population figures used to calculate density are on a two-year lag due to the pace of updates from the U.S. Census Bureau (e.g., 2021 density figures use 2019 population figures). |
| **active**             | The raw count of microbusinesses in the county. *(Not provided for the test set.)* |

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
 ### 🏅 National Top 10 Counties
Objective: Identify the top-performing counties nationwide.

Metric: Highest average microbusiness density.

Use Case: Highlight strong local economies or entrepreneurial activity hubs.

<img width="1145" height="512" alt="Screenshot 2025-07-22 at 6 08 44 PM" src="https://github.com/user-attachments/assets/8ce0a9ee-6ad3-4000-9905-f169ae3bbc5e" />

### 🏆 State Rankings (Best/Worst)
Objective: Rank all U.S. states based on average microbusiness density.

Metric: AVG(microbusiness_density) with ranking.

Use Case: Benchmark performance across states; identify leaders and laggards.

<img width="1146" height="505" alt="Screenshot 2025-07-22 at 6 07 22 PM" src="https://github.com/user-attachments/assets/9237134f-6694-4e8f-b2b5-a0d1fbb6ae71" />


### 📈 Cumulative Average Growth (Running Average)
Objective: Measure the growth trajectory of microbusiness density over time at the county level.

Use Case: Identify whether counties are steadily improving or stagnating.

Metric: Running average of microbusiness_density per county (cfips).

<img width="1159" height="514" alt="Screenshot 2025-07-22 at 6 06 23 PM" src="https://github.com/user-attachments/assets/4e57e974-dc16-4856-949c-8334dda7b84c" />


### 📊 Month-over-Month (MoM) Change
Objective: Track short-term changes in microbusiness density.

Metric: Difference from the previous month's value.

Use Case: Detect recent accelerations or slowdowns in economic activity at the county level.

<img width="1140" height="488" alt="Screenshot 2025-07-22 at 7 04 46 PM" src="https://github.com/user-attachments/assets/49b6f2a4-5747-4e0f-bd2f-7e9a31158ce9" />


 ### 📅 Year-over-Year (YoY) Change
Objective: Compare year-to-year microbusiness density per county.

Use Case: Understand long-term economic momentum or contraction.

<img width="1150" height="504" alt="Screenshot 2025-07-22 at 7 06 39 PM" src="https://github.com/user-attachments/assets/4bb0bd3e-f32b-4257-af37-06698682aace" />

### 🏅 County Rankings Within Each State
Objective: Rank counties within their respective states based on their latest density value.

Use Case: Allow state-level policymakers to identify standout or underperforming counties.
<img width="1154" height="486" alt="Screenshot 2025-07-22 at 8 21 44 PM" src="https://github.com/user-attachments/assets/2ad0435c-8fdb-450d-8142-dc91a6035a4f" />

### 📍 County Rank Over Time
Objective: Track how a county’s rank changes month-to-month within its state.

Use Case: Evaluate the consistency or volatility of local economic performance.
<img width="1174" height="511" alt="Screenshot 2025-07-22 at 8 25 32 PM" src="https://github.com/user-attachments/assets/ecd4f919-bfd4-4452-a83f-206ecd2e5032" />



### 🧭 Potential High-Growth Areas with Low Base
Objective: Identify counties with low density but fast growth, signaling potential for economic development.

Use Case: Early-stage investment opportunities, rural development strategy.
<img width="1145" height="498" alt="Screenshot 2025-07-22 at 8 17 15 PM" src="https://github.com/user-attachments/assets/eb02405b-f570-4994-a48b-ecbad5cf8a42" />

### 📈 Monthly State-Level Growth Rates
Objective: Track month-over-month growth rates (as percentages) for each state.

Use Case: Compare short-term momentum across states.

<img width="1156" height="504" alt="Screenshot 2025-07-22 at 8 14 40 PM" src="https://github.com/user-attachments/assets/ca94a291-b528-40a1-a600-e81aae19ca78" />

