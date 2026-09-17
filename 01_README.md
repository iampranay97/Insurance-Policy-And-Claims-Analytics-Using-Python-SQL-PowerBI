# Insurance Policy & Claims Analytics

## Project Overview
This project provides an end-to-end analytics solution for the insurance domain, evaluating contract performance, customer risk profiles, and claim payout efficiency. 
The project follows a structured analytical workflow transitioning from initial data cleaning and preprocessing in Python to relational query analysis in SQL, culminating in an interactive multi-page Power BI dashboard.

The primary focus is identifying high-loss policy segments, evaluating claims frequency across risk zones, and optimizing revenue distribution across various sales channels. 
The resulting interactive dashboard delivers clean visual reporting without horizontal scrolling, featuring streamlined navigation across executive summaries, risk breakdowns, and granular policy records.

## Business Problem
Insurance stakeholders require operational insights to manage financial risk, optimize claim settlements, and monitor product profitability across customer segments. Key operational questions include:
* Which product lines and sales channels drive the highest total premium revenue versus claim payouts?
* How are claim frequency and average damage costs distributed across different risk zones and vehicle types?
* What are the primary drivers of loss ratio spikes, and which individual policy records represent the highest financial exposure?

## Business Objectives
* Establish central KPI tracking for total premium, claim payouts, active contracts, and overall loss ratio percentage.
* Evaluate risk exposure across customer risk zones (`Low`, `Medium`, `High`) and claim categories (`Collision`, `Fire`, `Theft`, etc.).
* Build a scroll-free, production-ready 3-page Power BI dashboard with dynamic page navigation and single-table detail logging.

## Dataset
* **Rows:** 155 contracts / claims records
* **Columns:** Multi-table relational entity schema (`clean_contracts`, `clean_claims`, `clean_vehicles`, `insurance_analytics_master_data`, `risk_product_loss_ratio_summary`)
* **Data Type:** Insurance Contracts, Claims Settlement, and Vehicle Profiling
* **Key Fields:** `contract_id`, `claim_id`, `annual_premium`, `damage_amount`, `indemnified_amount`, `risk_zone`, `product`, `claim_type`

## Tools & Technologies
| Tool | Purpose |
| :--- | :--- |
| **Python (Pandas, NumPy)** | Data cleaning, data type validation, missing value handling, and exploratory data analysis (EDA). |
| **PostgreSQL** | Relational database analysis, SQL schema design, KPI querying, and aggregate functions. |
| **Power BI Desktop** | Data modeling, DAX measure creation, UI layout design, and interactive dashboard development. |
| **DAX (Data Analysis Expressions)** | Custom KPIs (`DIVIDE`, `SUM`, `AVERAGE`, `COUNT`), conditional logic, and calculated ranking. |
| **GitHub** | Version control, documentation, and portfolio showcase. |

## Project Workflow
* **Raw Dataset**
* **Python Data Cleaning & EDA**
* **PostgreSQL Analysis & Business Queries**
* **Power BI Data Modeling & DAX Measures**
* **Interactive 3-Page Power BI Dashboard**
* **Business Insights & Recommendations**

---

## Python Analysis
Data cleaning and validation pipelines were executed in Python to prepare the multi-entity relational structure for database loading and visual modeling.
* Standardized text fields, reformatted date values, and validated numerical data types across contract and claim tables.
* Handled missing value imputation and removed duplicate entries across vehicle and claim logs.
* Performed initial univariate and bivariate exploratory analysis to detect outliers in annual premium and damage amounts.
* Generated consolidated master tables (`insurance_analytics_master_data.csv`) and loss ratio analytical exports (`risk_product_loss_ratio_summary.csv`).

**Python Notebook:** [01_data_cleaning_and_eda.ipynb](python/07_data_cleaning_and_eda.ipynb)

---

## SQL Analysis
PostgreSQL queries were designed to extract key metrics, validate cross-table join logic, and analyze loss ratios across different dimensions.
* Created normalized relational schema tables (`clean_contracts`, `clean_claims`, `clean_vehicles`) with primary and foreign key constraints.
* Generated cross-tab aggregations calculating total premium, paid claims, and loss ratios per product line and sales channel.
* Executed ranking queries to profile high-risk contracts and identify top claim payouts.

**SQL File:** [02_business_queries.sql](sql/08_business_queries.sql)

---

## Power BI Dashboard
The Power BI report contains 3 dedicated interactive pages:

### 1. Executive Overview
Focuses on high-level financial metrics, revenue distribution, channel performance, and claim settlement statuses.
* **Core KPIs:** Total Premium ($14.19M), Total Contracts (155), Total Claims (155), Total Paid Claims ($219.91K), Loss Ratio % (1.55%).
* **Revenue Distribution By Product:** Donut chart highlighting premium concentration across `Auto`, `Home`, `Life`, and `Health`.
* **Channel Performance & Claim Status:** Bar charts depicting revenue across sales channels (`Broker`, `Agency`, `Web`, `Phone`) and claim distribution across statuses (`Closed`, `Rejected`, `Expert_review`, `In_progress`, `Open`).

### 2. Risk & Claims Deep-Dive
Analyzes loss exposure across customer risk tiers, fuel types, and specific claim damage types.
* **Core KPIs:** Avg Damage Amount ($4.24K), Claim Frequency % (100.00%), Avg Vehicle Value ($10.13K).
* **Claim Costs by Risk Zone & Claim Type:** Clustered bar chart breaking down payout distribution across `Low`, `Medium`, and `High` risk zones by damage categories (`Collision`, `Fire`, `Theft`, etc.).
* **Claims by Fuel Type & Top Brands:** Donut chart profiling fuel distribution (`Gasoline`, `Diesel`, `Hybrid`, `Electric`) alongside top vehicle brand payouts.

### 3. Policy & Claim Records
Delivers detailed record logging for individual policies and claims with dedicated search and filter capabilities.
* **Search & Filters:** Dynamic client name search bar paired with product and claim status slicers.
* **Top Policy Records:** Single-table detail log displaying top policies sorted by `annual_premium`.
* **Top Claim Records:** Single-table log tracking claim IDs, damage amounts, and indemnified amounts.

**Power BI Dashboard File:** [insurance_analytics_dashboard.pbix](powerbi/Insurance_Claims_Analytics_dashboard.pbix)

---

## Key KPIs
| KPI | Overall Result |
| :--- | :--- |
| **Total Premium** | $14.19M |
| **Total Contracts** | 155 |
| **Total Claims** | 155 |
| **Total Paid Claims** | $219.91K |
| **Loss Ratio %** | 1.55% |
| **Avg Damage Amount** | $4.24K |
| **Avg Vehicle Value** | $10.13K |

---

## Key Business Insights
### Financial & Channel Performance
* **Revenue Drivers:** Auto policies represent the largest share of total revenue at $5.39M (37.98%), followed by Life ($4.59M / 32.33%) and Health ($2.27M / 16.01%).
* **Channel Parity:** Sales volume is evenly distributed across Broker ($3.6M), Agency ($3.6M), Web ($3.6M), and Phone ($3.5M) channels, demonstrating strong multi-channel distribution.

### Risk & Claims Exposure
* **Loss Ratio Distribution:** The `Low` risk zone exhibits a higher loss ratio (3.21%) compared to `Medium` (1.06%) and `High` (0.93%) zones due to higher overall claim volume in low-risk categories.
* **Claim Categories:** Collision and Theft represent the largest payout drivers within the `Low` risk zone, accounting for over $58K in total damage costs.
* **Settlement Backlog:** 47 claims are Closed and 43 are Rejected, while 40 total claims remain in active review (`Expert_review`, `In_progress`, or `Open`).

---

## Business Recommendations
* **Adjust Risk Pricing Models:** Re-evaluate premium pricing and underwriting criteria for `Low` risk profiles, as this group accounts for a disproportionate share of total claim damage payouts.
* **Expedite Review Pipeline:** Implement automated triage for the 40 open/in-progress claims to reduce settlement cycle time and administrative overhead.
* **Optimize Channel Offerings:** Leverage digital channels (`Web`) for standard `Auto` policy renewals to lower customer acquisition costs while maintaining strong broker partnerships.

--- 

## Dashboard Preview
### Executive Overview
![Executive Overview](docs/screenshot_page1.png)

### Risk & Claims Deep-Dive
![Risk & Claims Deep-Dive](docs/screenshot_page2.png)

### Policy & Claim Records
![Policy & Claim Records](docs/screenshot_page3.png)
