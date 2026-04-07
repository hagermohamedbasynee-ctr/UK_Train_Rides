# UK Train Rides
This project delivers a comprehensive, four-week data analytics solution designed to transform raw UK railway data into strategic business intelligence. By integrating data analytics, statistical analysis, and machine learning, the project provides decision-makers with a 360-degree view of passenger trends and financial performance.

# step 1: EDA & Data Cleaning using Python

Performing **Exploratory Data Analysis (EDA)** and **Data Cleaning** on a UK railway transactions dataset containing **31,653 records** and **18 columns**. The goal is to understand the data structure, fix quality issues, and prepare a clean dataset ready for analysis and reporting.

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

# step 2: Dashboard and Insights using Excel

Creating an interactive Excel dashboard built from the cleaned railway dataset, featuring **6 charts**, **4 KPI cards**, and **3 slicers** for dynamic filtering. All visuals are connected and update automatically when a filter is applied.

---

## Dashboard Components

### KPI Cards
Four summary metrics displayed as standalone cards to provide an immediate snapshot of performance:

| KPI | Value |
|---|---|
| **Average Delay Time** | 3.88 mins |
| **Total Revenue** | £741,921 |
| **Average Revenue** | £23.44 |
| **Total Transactions** | 31,653 |

### Charts
1. **Monthly Journey Trend (Combo Chart)**
   - **Bar:** Count of Transaction ID per month.
   - **Line:** Sum of Revenue per month.
   - **Insight:** Visualizes journey volume vs. revenue from January to April 2024.

2. **Revenue by Ticket Type (Bar Chart)**
   - Compares total revenue across Advance, Anytime, and Off-Peak tickets.
   - **Insight:** Advance tickets are the primary revenue driver at £309,274.

3. **Railcard Type by Class (Clustered Bar Chart)**
   - Breaks down First Class vs. Standard passengers by railcard category.
   - **Insight:** "No Railcard" passengers dominate with 18,933 Standard class journeys.

4. **Delay Status (Pie Chart)**
   - Shows the distribution of delay categories as a percentage.
   - **Insight:** 86.82% of journeys were completed "On Time."

5. **Top 10 Most Delayed Routes (Horizontal Bar Chart)**
   - Ranks routes by the highest average delay time in minutes.
   - **Insight:** Manchester Piccadilly to London St Pancras has the highest average delay (22.4 mins).

### Slicers (Interactive Filters)
Three slicers connected to all pivot charts, allowing for deep-dive analysis:

| Slicer | Options |
|---|---|
| **Journey Status** | Cancelled, Delayed, On Time |
| **Payment Method** | Contactless, Credit Card, Debit Card |
| **Purchase Type** | Online, Station |

---

## Development Workflow

### 1. Data Preparation
- Loaded the `railway_clean.csv` into Excel.
- Added **Calculated Columns** to enhance analysis:
    - `Route` (Departure + Arrival)
    - `Month of Journey` & `Day of Week`
    - `Purchase Lead Days` (Date of Journey - Date of Purchase)
    - `Is Weekend` (Boolean)
    - `Delay Time (mins)`

### 2. Pivot Table Construction
- Built dedicated pivot tables for each visual on a background sheet.
- Utilized **Field Settings** to switch between `SUM`, `AVERAGE`, and `COUNT` as required for KPIs.
- Grouped `Date of Journey` by Month to create time-series trends.

### 3. Visual Design & Interactivity
- Inserted **Pivot Charts** tailored to the data (e.g., Horizontal Bar for rankings, Pie for proportions).
- Established **Report Connections** for all slicers to ensure the entire dashboard updates in unison.
- **UI Polishing:** Removed gridlines, applied a consistent color palette, and aligned elements for a professional "Application" feel.

---

## Tools Used

| Tool | Purpose |
|---|---|
| **Microsoft Excel** | Data hosting and dashboard engine |
| **Pivot Tables/Charts** | Data aggregation and visualization |
| **Slicers** | User-facing interactivity |
| **Excel Formulas** | Creating calculated fields and KPIs |
