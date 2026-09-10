# Bank of America Consumer Complaints (SQL Server Data Warehouse)

## **Project Overview**

This project demonstrates an end-to-end SQL Server data warehousing workflow using the **Bank of America Consumer Complaints / CFPB Consumer Complaint dataset (2017–2023)**.

-------------------------------------------------

## **Project Objectives**

The primary objective of this project is to transform raw consumer complaint data into a clean, standardized, and analytics-ready dataset that can be used to identify complaint patterns, understand customer pain points, evaluate response performance, and support data-driven business decisions.

The project applies a structured Bronze → Silver → Gold data warehouse architecture in SQL Server to prepare the data for analysis and business intelligence reporting.

## **Key Goals**

The project aims to:

- Build a structured SQL Server data warehouse using a Bronze, Silver, and Gold architecture.
- Ingest and preserve raw consumer complaint data in the Bronze layer.
- Clean, standardize, and enrich complaint records in the Silver layer.
- Create analytical categories for products, sub-products, issues, and resolutions.
- Develop derived metrics for response timeliness, response lag, resolution outcomes, seasonality, and geographic analysis.
- Validate the quality and consistency of the transformed data through data-quality tests.
- Produce an analytics-ready Gold layer suitable for Tableau, Power BI, and SQL-based analysis.
- Answer key business questions and translate complaint data into meaningful business insights.

------------------------------------------------------------------------------
## **Business Questions**

The analysis is designed to answer the following questions:

1. Do consumer complaints show any seasonal patterns?

The analysis will examine complaint volumes across:

- Years
- Months
- Quarters
- Days of the week

This will help identify periods when complaint activity increases or decreases and determine whether consumer complaints follow recurring seasonal patterns.

## ** Business insight:**
Identifying seasonal patterns can help organizations anticipate periods of higher complaint volumes, improve staffing and customer-service capacity, and investigate whether recurring operational or product-related issues contribute to seasonal increases.

2. Which products generate the most complaints, and what are their most common issues?

The analysis will identify the products and product categories associated with the highest complaint volumes and then examine the most frequently reported issues and sub-issues within those products.

## ** Business insight:**
Understanding which products generate the most complaints and why can help organizations prioritize product improvements, investigate recurring customer pain points, allocate resources to high-impact areas, and identify opportunities to improve the customer experience.

3. How are complaints typically resolved?

The analysis will examine complaint outcomes using the resolution categories created in the Silver layer, including:

Monetary Relief
Non-Monetary Relief
Explanation Only
In Progress
Unresolved

The analysis will determine the distribution of these outcomes and identify whether resolution patterns differ across products, issues, or other relevant dimensions.

## ** Business insight:**
Understanding how complaints are resolved provides visibility into how organizations respond to customer problems and whether certain products or complaint types are more likely to result in monetary relief, non-monetary relief, explanations, or unresolved outcomes.

4. What can we learn from complaints with untimely responses?

The analysis will isolate complaints where responses were not classified as timely and examine their characteristics, including:

Product category
Issue category
Resolution outcome
Response lag
Geographic region
Submission period

The objective is to identify patterns associated with delayed responses and determine whether particular products, issues, periods, or regions experience higher levels of untimely responses.

## ** Business insight:**
Analyzing untimely complaints can reveal potential service bottlenecks, recurring operational challenges, and areas where response processes may need improvement. These findings can support efforts to reduce response delays and improve customer-service performance.

## **Expected Business Value**

By answering these questions, the project aims to move beyond simple complaint counting and provide a structured view of when complaints occur, what customers complain about, how organizations respond, and where response performance may require attention.

The resulting Gold dataset can serve as the foundation for an interactive BI dashboard that enables stakeholders to:

Monitor complaint trends over time.
Identify high-volume products and complaint categories.
Investigate recurring customer issues.
Evaluate resolution outcomes.
Monitor timely versus untimely responses.
Identify areas requiring operational attention.
Support evidence-based customer-service and product decisions.

The project follows a **Medallion Architecture**:

```text
                    Consumer Complaints CSV
                              |
                              v
                    +-------------------+
                    |   BRONZE LAYER    |
                    | Raw / Source Data  |
                    +-------------------+
                              |
                              v
                    +-------------------+
                    |   SILVER LAYER    |
                    | Clean + Standardize|
                    | + Enrich           |
                    +-------------------+
                              |
                              v
                    +-------------------+
                    |    GOLD LAYER     |
                    | Analytics-Ready    |
                    | Fact View          |
                    +-------------------+
                              |
                              v
                    BI / Reporting / Analysis
```

## **Business Purpose**

Consumer complaint data contains useful information about:

- complaint volume
- financial products and services
- complaint issues and sub-issues
- response timeliness
- company responses
- resolution outcomes
- geographic distribution
- seasonality and complaint trends

The objective of this project is to transform raw complaint records into a structured, analytics-ready dataset that can support SQL analysis and BI dashboards.

## Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- CSV data ingestion with `BULK INSERT`
- SQL Server views and stored procedures
- Tableau / Power BI-ready output

## Repository Structure

```text
customer-complaints-sqlserver/
│
├── README.md
│
├── bronze_layer/
│   ├── 01_create_bronze_table.sql
│   └── 02_load_bronze.sql
│
├── silver_layer/
│   └── 01_load_silver.sql
│
├── gold_layer/
│   └── 01_create_fact_view.sql
│
├── tests/
│   └── 01_data_quality_tests.sql
│
├── dataset/
│   └── README.md
│
└── docs/
    └── data_dictionary.md
```
--------------------------------------------------------------

## Layer 1 (Bronze)

The Bronze layer represents the raw ingestion stage.

The source columns are loaded into:

`Bronze.Customer_Complaints_Raw`

The Bronze layer intentionally performs minimal transformation. Its purpose is to preserve the source structure and provide a controlled landing area for downstream processing.

### Bronze process

1. Truncate the existing Bronze table.
2. Load the CSV using `BULK INSERT`.
3. Preserve source values.
4. Print load and batch durations.
5. Catch and report loading errors.

## Layer 2 (Silver)

The Silver layer cleans, standardizes and enriches the Bronze data.

The target table is:

`Silver.Customer_Complaints_Raw`

### Main transformations

#### Text cleaning

- `TRIM()` removes unnecessary whitespace.
- `UPPER()` standardizes state codes.
- Missing sub-products are assigned `Not Specified`.
- Missing public responses are assigned `No Public Response`.
- Missing timely-response values are assigned `Pending`.

#### Product categorization

Products and sub-products are grouped into more analytical categories such as:

- Debt Collection
- Mortgage
- Student Loan
- Checking Account
- Savings Account
- Credit Card
- Prepaid Card
- Personal Loan
- Money Transfer
- Virtual Currency
- Credit Reporting
- Vehicle Loan / Lease

#### Issue categorization

Complaint issues are grouped into analytical themes including:

- Incorrect / Misleading Information
- Account Opening, Closing & Servicing
- Fees & Interest Rates
- Fraud & Security
- Dispute & Investigation
- Payment & Collection Issues
- Account Features & Add-ons

#### Derived metrics

The Silver layer also creates:

- `is_timely_response`
- `has_public_response`
- `resolution_category`
- `response_lag_days`
- `submission_year`
- `submission_month`
- `submission_month_name`
- `submission_quarter`
- `submission_day_of_week`
- `submission_year_month`
- `us_region`

These fields make the data easier to analyze without repeatedly rebuilding the same transformations.

## Layer 3 (Gold)

The Gold layer exposes an analytics-ready fact view:

`Gold.Fact_Customer_Complaints`

The view includes a generated:

`complaint_key`

using:

```sql
ROW_NUMBER() OVER (ORDER BY complaint_id)
```

The Gold view provides the cleaned and enriched complaint data in a format suitable for downstream SQL analysis and visualization.

## Data Quality Testing

The `tests` folder contains checks for:

- row counts
- duplicate complaint IDs
- null primary keys
- invalid state codes
- invalid timely-response values
- negative response lag
- invalid geographic regions
- missing derived values

These checks help confirm that the Bronze → Silver → Gold pipeline produced usable data.

## Data Loading

The Bronze stored procedure uses SQL Server `BULK INSERT`.

Before running the procedure, update the CSV path in:

`bronze_layer/02_load_bronze.sql`

Example:

```sql
FROM 'C:\Path\To\Customer_Complaints.csv'
```

The SQL Server service account must be able to access the file location.

## How to Run the Project

Run the scripts in this order.

### 1. Create the database and schemas

Run the database setup script in SQL Server.

### 2. Create the Bronze table

Run:

```text
bronze_layer/01_create_bronze_table.sql
```

### 3. Load the Bronze layer

Update the CSV path and run:

```text
bronze_layer/02_load_bronze.sql
```

### 4. Load the Silver layer

Run:

```text
silver_layer/01_load_silver.sql
```

Then execute the procedure:

```sql
EXEC Silver.Load_Silver_Customer_Complaints;
```

### 5. Create the Gold view

Run:

```text
gold_layer/01_create_fact_view.sql
```

### 6. Run data-quality tests

Run:

```text
tests/01_data_quality_tests.sql
```

## Example Gold Query

```sql
SELECT *
FROM Gold.Fact_Customer_Complaints;
```

Example analytical query:

```sql
SELECT
    submission_year,
    product_category,
    COUNT(*) AS complaint_count
FROM Gold.Fact_Customer_Complaints
GROUP BY
    submission_year,
    product_category
ORDER BY
    submission_year,
    complaint_count DESC;
```

## Data Dictionary

See:

`docs/data_dictionary.md`

for the main Bronze, Silver and Gold fields and their purposes.

## Important Repository Note

The raw CSV is intentionally not included in this repository by default.

Instead, place the downloaded dataset in:

```text
dataset/
```

The dataset README explains where the data comes from and how to configure the local file path.

This keeps the GitHub repository focused on the **data engineering / SQL transformation work** while avoiding unnecessary large raw-data files.

## Portfolio Value

This project demonstrates practical skills in:

- SQL Server
- data ingestion
- ETL / ELT concepts
- Medallion Architecture
- data cleaning
- data standardization
- data enrichment
- dimensional/analytical modeling
- stored procedures
- views
- data-quality testing
- business-oriented categorization
- BI-ready data preparation

It can be extended with a Tableau or Power BI dashboard to demonstrate the complete workflow from raw data to business insight.

## Author

**Adeniyi Emmanuel**

Data Analyst / Business Intelligence Portfolio

Core tools: SQL | Power BI | Tableau | Python | R | Excel


