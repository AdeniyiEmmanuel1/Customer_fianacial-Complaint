/*
===============================================================================
Script Name : Create Silver Layer Tables – Himalayan Expedition Data Warehouse
Scrupt Purpose :
    This script creates the core tables for the Silver layer of the
    Customer_Complaints Data Warehouse 

Layer       : Silver
Database    : Customer_Complaints.CSV
===============================================================================
*/

PRINT'=================================================
TO Silver Layer TABLES In the DATABASE
======================================================='


-- Drop and recreate to fix schema
IF OBJECT_ID('Silver.Customer_Complaints_Raw', 'U') IS NOT NULL
    DROP TABLE Silver.Customer_Complaints_Raw;

CREATE TABLE Silver.Customer_Complaints_Raw (
	complaint_id                   INT NOT NULL PRIMARY KEY,
    submitted_via                  NVARCHAR(50)  NOT NULL,
    date_submitted                 DATE          NOT NULL,
    date_received                  DATE          NOT NULL,
    state_code                     CHAR(2)       NOT NULL,
    product                        NVARCHAR(200) NOT NULL,
    sub_product                    NVARCHAR(200) NOT NULL,   -- 'Not Specified' where null
    issue                          NVARCHAR(300) NOT NULL,
    sub_issue                      NVARCHAR(300) NOT NULL,   -- 'Not Specified' where null
    company_public_response        NVARCHAR(500) NOT NULL,   -- 'No Public Response' where null
    company_response_to_consumer   NVARCHAR(100) NOT NULL,
    timely_response                NVARCHAR(10)  NOT NULL,   -- 'Pending' where null (still in progress)
    ----Derived Columns
    product_category               NVARCHAR(60)  NOT NULL,
    sub_product_category           NVARCHAR(200)  NOT NULL,
    issue_category                 NVARCHAR(300)  NOT NULL,
    sub_issue_category             NVARCHAR(300)  NOT NULL,
    is_timely_response             BIT           NOT NULL,   -- 1 = Yes, 0 = No, NULL kept out via pending bucket
    has_public_response            BIT           NOT NULL,
    resolution_category            NVARCHAR(30)  NOT NULL,   -- Monetary Relief / Non-Monetary Relief / Explanation Only / In Progress / Unresolved
    response_lag_days              INT           NOT NULL,
      -- date enrichment (drives the seasonality question)
    submission_year                INT           NOT NULL,
    submission_month               TINYINT       NOT NULL,
    submission_month_name          NVARCHAR(10)  NOT NULL,
    submission_quarter             CHAR(2)       NOT NULL,   -- Q1..Q4
    submission_day_of_week         NVARCHAR(10)  NOT NULL,
    submission_year_month          CHAR(7)       NOT NULL,   -- 'YYYY-MM', sort-friendly for cumulative/bump charts
    -- geographic enrichment
    us_region                      NVARCHAR(20)  NOT NULL,   -- Northeast / Midwest / South / West
    dwh_Create_date DATETIME2 DEFAULT GETDATE()
    );
