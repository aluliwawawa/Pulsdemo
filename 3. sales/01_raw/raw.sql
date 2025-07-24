-- ############################################################
-- 🔍 SECTION 4: SAMPLE QUERY
-- ############################################################
-- showcases the success load of location datas as start of a central data pipeline.
-- sample1：query raw ledger
SELECT
    ar_id,
    customer_id,
    invoice_date,
    paid_date,
    DATEDIFF('DAY', invoice_date, paid_date) AS days_to_pay,
    amount
FROM
    DEMO_PULS_SALES.P1_RAW.LEDGER
ORDER BY
    days_to_pay DESC;


-- ############################################################
-- 💾 SECTION 1: CREATE DATABASE AND SCHEMA
-- ############################################################
CREATE DATABASE IF NOT EXISTS DEMO_PULS_sales;

CREATE SCHEMA IF NOT EXISTS DEMO_PULS_sales.P1_RAW;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_sales.P2_STAGE;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_sales.P3_MART;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_sales.P4_VIEW;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_sales.P5_BACKUP;

USE DATABASE DEMO_PULS_sales;
USE SCHEMA P1_RAW;

-- ############################################################
-- 🏗️ SECTION 2: CREATE TABLES
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_SALES.P1_RAW.SALES_ORDER (
    order_id         STRING,
    customer_id      STRING,
    order_date       STRING,
    amount           STRING,
    region_code      STRING,
    ingestion_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TABLE DEMO_PULS_SALES.P1_RAW.LEDGER (
    ar_id            STRING,
    customer_id      STRING,
    invoice_date     STRING,
    due_date         STRING,
    paid_date        STRING,
    amount           STRING,
    ingestion_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TABLE DEMO_PULS_SALES.P1_RAW.CUSTOMER (
    customer_id      STRING,
    customer_name    STRING,
    is_KA            STRING,
    region_code      STRING,
    ingestion_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ############################################################
-- 🧠 SECTION 3: INSERT DUMMY DATA
-- ############################################################
-- load local csv files
-- dummy data preferences see Readme.md
