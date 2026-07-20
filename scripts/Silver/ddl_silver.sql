/*
===============================================================================
Script Name : Create Silver Layer Tables – Himalayan Expedition Data Warehouse
Scrupt Purpose :
    This script creates the core tables for the Silver layer of the
    Himalayan Expedition Data Warehouse following the Medallion Architecture.

    The script performs the following tasks:
    - Drops existing Silver layer tables (if they exist) to ensure a clean
      and consistent schema deployment.
    - Creates the Himalayan_Exped, Himalayan_Members, and Himalayan_Peaks
      tables with standardized data types and optimized column lengths.
    - Preserves cleansed, validated, and transformed expedition, member,
      and mountain peak data received from the Bronze layer.
    - Defines appropriate data types for dates, times, numeric values,
      Boolean flags, and descriptive text to support data quality,
      reporting, and analytical processing.
    - Adds an audit column (dwh_create_date) to record the timestamp when
      each record is loaded into the Silver layer.

    These tables serve as the trusted, cleansed data repository that will
    be used for downstream transformations into the Gold layer, business
    intelligence reporting, dashboards, and analytical models.

Layer       : Silver
Database    : Himalayan Expedition Data Warehouse
===============================================================================
*/

PRINT'=================================================
TO Silver Layer TABLES In the DATABASE
======================================================='


-- Drop and recreate to fix schema
IF OBJECT_ID('Silver.Himalayan_Exped', 'U') IS NOT NULL
    DROP TABLE Silver.Himalayan_Exped;

CREATE TABLE Silver.Himalayan_Exped (
    expid        NVARCHAR(50),
    peakid       NVARCHAR(50),
    year_id      SMALLINT,   
    season       NVARCHAR(50),
    host         NVARCHAR(50),
    route1       NVARCHAR(100),
    route2       NVARCHAR(100),
    route3       NVARCHAR(100),
    route4       NVARCHAR(100),
    nation       NVARCHAR(50),
    leaders      NVARCHAR(200),
    sponsor      NVARCHAR(300),     -- Was 50; sponsor text can be long
    success1     BIT,
    success2     BIT,
    success3     BIT,
    success4     BIT,
    ascent1      NVARCHAR(50),
    ascent2      NVARCHAR(50),
    ascent3      NVARCHAR(50),
    ascent4      NVARCHAR(50),
    claimed      BIT,
    disputed     BIT,
    countries    NVARCHAR(300),     
    approach     NVARCHAR(300),
    bcdate       DATE,     
    smtdate      DATE,
    smttime      TIME(0),
    smtdays      SMALLINT,      
    totdays      SMALLINT,
    termdate     DATE,
    termreason   NVARCHAR(255),
    termnote     NVARCHAR(500),     -- Can be very long
    highpoint    SMALLINT,      
    traverse     BIT,
    ski          BIT,
    parapente    BIT,
    camps        SMALLINT,
    rope         INT,
    totmembers   SMALLINT,
    smtmembers   SMALLINT,
    mdeaths      TINYINT,
    tothired     SMALLINT,
    smthired     SMALLINT,
    hdeaths      TINYINT,
    nohired      BIT,
    o2used       BIT,
    o2none       BIT,
    o2climb      BIT,
    o2descent    BIT,
    o2sleep      BIT,
    o2medical    BIT,
    o2taken      BIT,
    o2unkwn      BIT,
    othersmts    NVARCHAR(200),
    campsites    NVARCHAR(500),     -- Very long field
    accidents    NVARCHAR(500),
    achievment   NVARCHAR(500),
    agency       NVARCHAR(200),
    comrte       BIT,
    stdrte       BIT,
    primrte      BIT,
    primmem      BIT,
    primref      BIT,
    primid       FLOAT,
    chksum       INT,
    dwh_create_date DATETIME DEFAULT GETDATE()
);
        
----Drop and recreate to fix schema
IF OBJECT_ID('Silver.Himalayan_Members', 'U') IS NOT NULL
    DROP TABLE Silver.Himalayan_Members;

CREATE TABLE Silver.Himalayan_Members (
                expid NVARCHAR(15),
                membid SMALLINT,
                peakid NVARCHAR(10),
                myear SMALLINT,
                mseason NVARCHAR(10),
                fname NVARCHAR(100),
                fname_nickname NVARCHAR(60),
                lname NVARCHAR(100),
                sex CHAR(1),
                yob SMALLINT,
                citizen NVARCHAR(60),
                statuss NVARCHAR(50),
                residence NVARCHAR(200),
                occupation NVARCHAR(200),
                leader BIT,
                deputy BIT,
                bconly BIT,
                nottobc BIT,
                support BIT,
                disabledd BIT,
                hired BIT,
                sherpa BIT,
                tibetan BIT,
                msuccess BIT,
                mclaimed BIT,
                mdisputed BIT,
                msolo BIT,
                mtraverse BIT,
                mski BIT,
                mparapente BIT,
                mspeed BIT,
                mhighpt SMALLINT,
                mperhighpt FLOAT,
                msmtdate1 DATE,
                msmtdate2 DATE,
                msmtdate3 DATE,
                msmttime1 TIME(0),
                msmttime2 TIME(0),
                msmttime3 TIME(0),
                mroute1 NVARCHAR(100),
                mroute2 NVARCHAR(100),
                mroute3 NVARCHAR(100),
                mascent1 NVARCHAR(30),
                mascent2 NVARCHAR(30),
                mascent3 NVARCHAR(30),
                mo2used BIT,
                mo2none BIT,
                mo2climb BIT,
                mo2descent BIT,
                mo2sleep BIT,
                mo2medical BIT,
                mo2note NVARCHAR(300),
                death BIT,
                deathdate DATE,
                deathtime TIME(0),
                deathtype NVARCHAR(60),
                deathhgtm SMALLINT,
                deathclass NVARCHAR(60),
                msmtbid NVARCHAR(100),
                msmtterm NVARCHAR(300),
                hcn FLOAT,
                mchksum INT,
                dwh_create_date DATETIME DEFAULT GETDATE()
                );

----Drop and recreate to fix schema
IF OBJECT_ID('Silver.Himalayan_Peaks', 'U') IS NOT NULL
    DROP TABLE Silver.Himalayan_Peaks;

CREATE TABLE Silver.Himalayan_Peaks (
                peakid NVARCHAR(10),
                pkname NVARCHAR(100),
                pkname2 NVARCHAR(100),
                locationn NVARCHAR(200),
                heightm SMALLINT,
                heightf INT,
                himal NVARCHAR(100),
                region NVARCHAR(100),
                openn BIT,
                unlisted BIT,
                trekking BIT,
                trekyear SMALLINT,
                restrictt NVARCHAR(200),
                phost NVARCHAR(50),
                pstatus NVARCHAR(20),
                pyear SMALLINT,
                pseason NVARCHAR(10),
                pmonth CHAR(3),
                pmonth_note NVARCHAR(100),
                pday TINYINT,
                first_ascent_date NVARCHAR(12),
                pexpid NVARCHAR(15),
                pcountry NVARCHAR(100),
                psummiters NVARCHAR(400),
                psmtnote NVARCHAR(400),
                dwh_create_date DATETIME DEFAULT GETDATE()
                );
