# Railway Dataset — End-to-End Data Analysis Project

## Brief

This project analyses a UK railway transactions dataset using a full data analytics pipeline — from raw data exploration and cleaning in Python, to structured querying in SQL, data modelling in Power BI, and interactive dashboard reporting in Excel. The dataset contains 31,653 ticket transactions recorded across multiple UK train stations, covering journey outcomes, ticket pricing, delay reasons, and passenger behaviour.

---

## Objective

The objective of this project is to transform raw, inconsistent railway data into meaningful insights that support operational and business decision-making. Specifically, the project aims to:

- **Assess data quality** by identifying and resolving missing values, duplicate records, and inconsistent categories
- **Explore the data** to uncover patterns in journey performance, revenue, delay causes, and passenger behaviour
- **Build calculated metrics** such as delay time, booking lead days, and refund eligibility to enrich the dataset for analysis
- **Query the data using SQL** to answer key business questions around route performance, delay trends, and revenue
- **Model the data in Power BI** using a star schema with Fact and Dimension tables to enable efficient and scalable reporting
- **Visualise insights** through an interactive Excel dashboard and a Power BI report featuring KPIs, trend analysis, and route-level performance

---

## Project Overview

This project performs **Exploratory Data Analysis (EDA)** and **Data Cleaning** on a UK railway transactions dataset containing **31,653 records** and **18 columns**. The goal is to understand the data structure, fix quality issues, and prepare a clean dataset ready for analysis and reporting.

---

## Dataset

**File:** `railway.csv`

The dataset captures individual train ticket purchases and journey outcomes, including ticket details, pricing, route information, journey status, and delay reasons.

| Column | Description |
|---|---|
| Transaction ID | Unique identifier for each ticket purchase |
| Date of Purchase | Date the ticket was bought |
| Time of Purchase | Time the ticket was bought |
| Purchase Type | Online or Station |
| Payment Method | Contactless, Credit Card, or Debit Card |
| Railcard | Railcard type held by the passenger |
| Ticket Class | Standard or First Class |
| Ticket Type | Advance, Off-Peak, or Anytime |
| Price | Final ticket cost (£) |
| Departure Station | Station where the journey starts |
| Arrival Destination | Station where the journey ends |
| Date of Journey | Date the train departed |
| Departure Time | Scheduled departure time |
| Arrival Time | Scheduled arrival time |
| Actual Arrival Time | Actual arrival time |
| Journey Status | On Time, Delayed, or Cancelled |
| Reason for Delay | Cause of delay or cancellation |
| Refund Request | Whether the passenger requested a refund |

---

## Notebook Structure

### 1. Data Understanding
Initial exploration to understand the shape and content of the dataset before any modifications.

- Checked dataset dimensions using `.shape`
- Previewed first and last rows using `.head()` 
- Listed all column names using `.columns`
- Inspected data types using `.dtypes`
- Generated summary statistics using `.describe()`

---

### 2. Data Preparation

#### Fixing Data Types
- Converted `Date of Purchase` and `Date of Journey` from `object` to `datetime64` using `pd.to_datetime()`

#### Duplicates Check
- Checked for fully duplicate rows using `.duplicated().sum()`
- **Result:** 0 duplicate rows found

#### Handling Missing Values
Identified 3 columns with missing values:

| Column | Missing Count | Action Taken |
|---|---|---|
| Railcard | 20,918 (66%) | Filled with `"No Railcard"` — absence of railcard is meaningful |
| Reason for Delay | 27,481 (87%) | Filled using journey status logic (see below) |
| Actual Arrival Time | 1,880 (6%) | Filled using journey status logic (see below) |

#### Standardising Inconsistent Values
The `Reason for Delay` column contained duplicate categories with different naming. These were unified using a mapping dictionary:

| Before | After |
|---|---|
| `Weather` | `Weather Conditions` |
| `Signal failure` | `Signal Failure` |
| `Staffing` | `Staff Shortage` |

#### Smart Null Filling with Nested Logic
Rather than blindly filling nulls, a conditional approach was used based on `Journey Status`:

**Reason for Delay:**
- If journey was `On Time` and reason is missing → filled with `"No Delay"`
- If journey was `Delayed` or `Cancelled` but reason is missing → filled with `"Unknown"` to flag a data quality issue

**Actual Arrival Time:**
- If journey was `Cancelled` and arrival time is missing → filled with `"Cancelled"` (train never arrived)
- If any other status has a missing arrival time → filled with `"Unknown"`

---

## Tools & Libraries

| Tool | Purpose |
|---|---|
| Python 3 | Programming language |
| Pandas | Data manipulation and cleaning |
| Jupyter Notebook | Interactive development environment |

---

## How to Run

1. Clone the repository
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   ```

2. Install dependencies
   ```bash
   pip install pandas jupyter
   ```

3. Place `railway.csv` in the same folder as the notebook

4. Open the notebook
   ```bash
   jupyter notebook EDA_and_Cleaning.ipynb
   ```

---

## Key Findings

- **86.8%** of journeys were on time
- **7.2%** of journeys were delayed
- **5.9%** of journeys were cancelled
- Top delay causes: Weather Conditions, Signal Failure, Staff Shortage
- No duplicate records found in the dataset
- After cleaning: **0 missing values** across all 18 columns

---

## Excel Dashboard — UK Train Station Dashboard

### Overview
An interactive Excel dashboard built from the cleaned railway dataset, featuring **6 charts**, **4 KPI cards**, and **3 slicers** for dynamic filtering. All visuals are connected and update automatically when a filter is applied.

---

### Dashboard Components

#### KPI Cards
Four summary metrics displayed on the left panel:

| KPI | Value |
|---|---|
| Average Delay Time | 3.88 mins |
| Sum of Revenue | £741,921 |
| Average Ticket Price | £23.44 |
| Total Journeys | 31,653 |

---

#### Charts

**1. Monthly Journey Trend** — Combo Chart (Bar + Line)
- Bar shows count of journeys per month
- Line shows total revenue per month
- Covers January to April 2024

**2. Revenue by Ticket Type** — Bar Chart
- Compares total revenue across Advance, Anytime, and Off-Peak
- Advance tickets generate the highest revenue at £309,274

**3. Railcard Type by Class** — Clustered Bar Chart
- Breaks down First Class vs Standard passengers by railcard type
- No Railcard passengers dominate with 18,933 Standard class journeys

**4. Delay Status** — Pie Chart
- Shows distribution of delay reasons as percentages
- 86.82% of journeys had no delay

**5. Top 10 Most Delayed Routes** — Horizontal Bar Chart
- Ranks routes by average delay time in minutes
- Manchester Piccadilly → London St. Pancras tops the list at 22.4 mins

---

#### Slicers
Three interactive slicers connected to all pivot charts:

| Slicer | Options |
|---|---|
| Journey Status | Cancelled, Delayed, On Time |
| Payment Method | Contactless, Credit Card, Debit Card |
| Purchase Type | Online, Station |

---

### How the Dashboard Was Built

**Step 1 — Prepare the Data**
- Loaded the cleaned `railway.csv` into Excel
- Applied all cleaning steps (null handling, type fixes, unified categories)
- Added 7 calculated columns using Excel formulas: `Route`, `Month of Journey`, `Day of Week`, `Purchase Lead Days`, `Is Weekend`, `Refund Eligible`, `Delay Time (mins)`

**Step 2 — Create Pivot Tables**
- Created a separate pivot table for each chart on dedicated sheets
- Used `Date of Journey` grouped by month for the trend chart
- Used `COUNTIFS` and `SUMIFS` for the KPI card values

**Step 3 — Build the Charts**
- Inserted pivot charts from each pivot table
- Changed chart types where needed (combo chart for trend, pie for delay status)
- Applied consistent formatting, colors, and titles across all charts

**Step 4 — Set Up Slicers**
- Inserted slicers for `Journey Status`, `Payment Method`, and `Purchase Type`
- Connected each slicer to all pivot tables via **Report Connections**
- Positioned slicers in the top right panel of the dashboard

**Step 5 — Design the Layout**
- Created a dedicated `UK Train Station Dashboard` sheet
- Moved and resized all charts onto the dashboard sheet
- Added the title, KPI cards, and background formatting
- Removed gridlines for a clean presentation look

---

### Tools Used

| Tool | Purpose |
|---|---|
| Microsoft Excel | Pivot Tables, Pivot Charts, Slicers |
| Data source | `railway_clean.csv` |

---

## SQL Queries — SQL Server

### Overview
Five structured queries were written in SQL Server to extract key business insights directly from the cleaned railway dataset. The data was imported from Excel into a proper SQL Server table named `railway` with clean, underscore-formatted column names for easier querying.

---

### Data Import
Before querying, the dataset was imported from Excel into SQL Server and column names were cleaned using `SELECT INTO`:

```sql
SELECT
    [Transaction ID]      AS Transaction_ID,
    [Journey Status]      AS Journey_Status,
    [Departure Station]   AS Departure_Station,
    [Arrival Destination] AS Arrival_Destination,
    [Reason for Delay]    AS Reason_for_Delay,
    [Refund Request]      AS Refund_Request,
    [Date of Journey]     AS Date_of_Journey,
    [Price]               AS Price
INTO railway
FROM Data$;
```

---

### Queries

**Query 1 — On-Time Rate by Route**
Counts total journeys and on-time journeys per route, ordered by busiest routes first.
```sql
SELECT
    Departure_Station,
    Arrival_Destination,
    COUNT(*)                                                          AS Total_Journeys,
    SUM(CASE WHEN Journey_Status = 'On Time' THEN 1 ELSE 0 END)     AS On_Time_Count
FROM railway
GROUP BY Departure_Station, Arrival_Destination
ORDER BY Total_Journeys DESC;
```

---

**Query 2 — Average and Maximum Delay Time by Reason**
Analyses delay severity grouped by cause, rounded to 2 decimal places.
```sql
SELECT
    Reason_for_Delay,
    COUNT(*)                        AS Total_Delayed,
    ROUND(AVG(Delay_Time_Mins), 2)  AS Avg_Delay_Mins,
    ROUND(MAX(Delay_Time_Mins), 2)  AS Max_Delay_Mins
FROM railway
WHERE Journey_Status = 'Delayed'
GROUP BY Reason_for_Delay
ORDER BY Avg_Delay_Mins DESC;
```

---

**Query 3 — Monthly Revenue Trend**
Groups revenue and journey count by month and year to identify seasonal trends.
```sql
SELECT
    MONTH(Date_of_Journey)   AS Journey_Month,
    YEAR(Date_of_Journey)    AS Journey_Year,
    COUNT(*)                 AS Total_Journeys,
    SUM(Price)               AS Total_Revenue,
    AVG(Price)               AS Avg_Ticket_Price
FROM railway
GROUP BY YEAR(Date_of_Journey), MONTH(Date_of_Journey)
ORDER BY Journey_Year, Journey_Month;
```

---

**Query 4 — Refund Count by Journey Status**
Shows how many refunds were requested per journey status category.
```sql
SELECT
    Journey_Status,
    COUNT(*)                                                     AS Total_Journeys,
    SUM(CASE WHEN Refund_Request = 'Yes' THEN 1 ELSE 0 END)    AS Refund_Count
FROM railway
GROUP BY Journey_Status
ORDER BY Journey_Status;
```

---

**Query 5 — Top 5 Most Delayed Routes**
Identifies the 5 routes with the highest number of delays and average delay time.
```sql
SELECT TOP 5
    Departure_Station,
    Arrival_Destination,
    COUNT(*)             AS Total_Delayed,
    AVG(Delay_Time_Mins) AS Avg_Delay_Mins
FROM railway
WHERE Journey_Status = 'Delayed'
GROUP BY Departure_Station, Arrival_Destination
ORDER BY Total_Delayed DESC;
```

---

## Power BI Report — UK Railway Dashboard Analysis

### Overview
A 3-page interactive Power BI report built on a **Star Schema data model**, featuring KPI cards, gauge charts, trend analysis, and route-level performance insights. All pages are connected through shared slicers and navigation buttons.

---

### Data Model — Star Schema

The data was modelled using Fact and Dimension tables for efficient and scalable reporting:

| Table | Type | Description |
|---|---|---|
| `Fact Railway` | Fact | Core transaction table with all measures |
| `Dim Date` | Dimension | Date attributes — Year, Month, Quarter, Weekday, Is Weekend |
| `Dim Time` | Dimension | Time attributes — Hour, Period, Peak/Off-Peak |
| `Dim Journey Status` | Dimension | Journey outcome — On Time, Delayed, Cancelled |
| `Dim Station` | Dimension | Departure and arrival station details |

---

### DAX Measures

Key measures created to power the visuals:

```dax
Total Revenue = SUM('Fact Railway'[Price])

Expenses = 
SUMX(FILTER('Fact Railway', 'Fact Railway'[Refund_Request] = "Yes"),
'Fact Railway'[Price])

Net Revenue = [Total Revenue] - [Expenses]

AVG Ticket Price = AVERAGE('Fact Railway'[Price])

On Time Journeys = 
COUNTROWS(FILTER('Fact Railway',
RELATED('Dim Journey Status'[Journey_Status]) = "On Time"))

Delayed Journeys = 
COUNTROWS(FILTER('Fact Railway',
RELATED('Dim Journey Status'[Journey_Status]) = "Delayed"))

Cancelled Journeys = 
COUNTROWS(FILTER('Fact Railway',
RELATED('Dim Journey Status'[Journey_Status]) = "Cancelled"))

On-Time Rate = DIVIDE([On Time Journeys], COUNTROWS('Fact Railway')) * 100

Refund Rate = 
DIVIDE(COUNTROWS(FILTER('Fact Railway',
'Fact Railway'[Refund_Request] = "Yes")),
COUNTROWS('Fact Railway')) * 100
```

---

### Report Pages

**Page 1 — Overview Report**

| Visual | Type | Insight |
|---|---|---|
| Transactions by Railcard | Horizontal Bar | No Railcard passengers dominate at 5,108 |
| Transactions by Payment Method | Donut Chart | Credit Card leads at 61.29% |
| Monthly Journey Trend | Line Chart | Revenue and transaction count by month |
| Top 5 Crowded Routes | Horizontal Bar | Manchester Piccadilly → Liverpool tops at 1,110 |
| KPI Cards | Cards | Transactions, AVG Delay Time, Net Revenue, AVG Ticket Price |

---

**Page 2 — Revenue Report**

| Visual | Type | Insight |
|---|---|---|
| Total Revenue by Ticket Type | Bar Chart | Advance tickets highest at £309,274 |
| AVG Ticket Price by Month | Line Chart | February dip to £21.01, recovered in March |
| Revenue by Ticket Type | Pie Chart | Balanced split — Advance 35%, Off-Peak 32%, Anytime 31% |
| Refund Rate Gauge | Gauge | 3.47% — above 2% target ⚠️ |
| Top 5 Profitable Routes | Horizontal Bar | London Kings Cross → York leads at £45,615 |
| KPI Cards | Cards | Total Revenue, Expenses, Net Revenue, AVG Ticket Price |

---

**Page 3 — Performance Report**

| Visual | Type | Insight |
|---|---|---|
| Journey Status Count | KPI Cards | 477 Cancelled, 528 Delayed, 6,743 On Time |
| On-Time Rate Gauge | Gauge | 87.03% — below 90% target ⚠️ |
| Delayed Rate Gauge | Gauge | 6.81% |
| Cancelled Rate Gauge | Gauge | 6.16% |
| AVG Delay Time by Month & Reason | Clustered Bar | Weather worst in April at 32.93 mins |
| Refunds by Delay Reason | Pie Chart | Weather accounts for 32.5% of refunds |
| Top 5 Delayed Routes | Horizontal Bar | Manchester Piccadilly → Leeds tops at 53.44 mins |

---

### Slicers — Applied Across All Pages

| Slicer | Options |
|---|---|
| Ticket Class | Standard, First Class |
| Journey Status | On Time, Delayed, Cancelled |
| Purchase Type | Online, Station |
| Railcard | Adult, Senior, Disabled, No Railcard |
| Ticket Type | Advance, Off-Peak, Anytime |
| Month | January, February, March, April |

---

### Gauge Benchmarks

| Gauge | Current Value | Target | Source |
|---|---|---|---|
| On-Time Rate | 87.03% | 90% | UK Office of Rail and Road (ORR) |
| Refund Rate | 3.47% | Below 2% | Service industry standard |
| Cancelled Rate | 6.16% | Below 3% | UK rail industry expectation |
| AVG Delay Time | 3.88 mins | Below 5 mins | Passenger satisfaction research |

---

## Author

**Hager**
Aspiring Data Analytics professional developing skills in Python, SQL, Excel, and Power BI.
