# UK Train Rides
This project delivers a comprehensive, four-week data analytics solution designed to transform raw UK railway data into strategic business intelligence. By integrating data analytics, statistical analysis, and machine learning, the project provides decision-makers with a 360-degree view of passenger trends and financial performance.

# Railway Dataset — EDA & Data Cleaning

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



**Hager**
Aspiring Data Analytics professional developing skills in Python, SQL, Excel, and Power BI.
