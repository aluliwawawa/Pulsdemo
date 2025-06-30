-- ############################################################
-- 🔍 SECTION 4: SAMPLE QUERY
-- ############################################################
-- showcases the success load of location datas as start of a central data pipeline.
-- Data Quality check tool report incidents as on-purpose design of dirty data
-- sample1：query daily production of device_SMT
SELECT log_date, factory_id, SUM(total_units) AS total_units
FROM P1_RAW.SMT_LOG
GROUP BY log_date, factory_id
ORDER BY log_date;

-- sample2：query all devices status
SELECT status, COUNT(*)
FROM P1_RAW.MACHINE_STATUS_LOG
GROUP BY status;

-- sample3：query trend of yield rate of device_AOI
SELECT log_date, 
       SUM(passed_units) / NULLIF(SUM(total_units), 0) AS pass_rate
FROM P1_RAW.AOI_LOG
GROUP BY log_date
ORDER BY log_date;

-- ############################################################
-- 💾 SECTION 1: CREATE DATABASE AND SCHEMA
-- ############################################################
CREATE DATABASE IF NOT EXISTS DEMO_PULS_OPERATION;

CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P1_RAW;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P2_STAGE;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P3_MART;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P4_REPORT;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P5_BACKUP;

USE DATABASE DEMO_PULS_OPERATION;
USE SCHEMA P1_RAW;

-- ############################################################
-- 🏗️ SECTION 2: CREATE TABLES
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.SMT_LOG (
    log_id INT AUTOINCREMENT PRIMARY KEY,
    factory_id VARCHAR(50),
    machine_id VARCHAR(50),
    product_id VARCHAR(50),
    log_date DATE,
    total_units INT,
    passed_units INT,
    failed_units INT,
    defect_code VARCHAR(50),
    cycle_time_sec FLOAT,
    created_at TIMESTAMP,
    operator_id STRING,      
    shift STRING
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.AOI_LOG (
    factory_id STRING,
    machine_id STRING,
    product_id STRING,
    log_date DATE,
    total_units INT,
    passed_units INT,
    failed_units INT,
    defect_code STRING,
    cycle_time_sec FLOAT,
    created_at TIMESTAMP,
    camera_id STRING,
    inspection_type STRING
);

CREATE OR REPLACE TABLE P1_RAW.FT_LOG (
    factory_id STRING,
    machine_id STRING,
    product_id STRING,
    log_date DATE,
    pass_flag BOOLEAN,
    test_duration_sec FLOAT,
    test_station STRING,   
    error_code STRING,  
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE P1_RAW.MACHINE_STATUS_LOG (
    factory_id STRING,
    machine_id STRING,
    machine_type STRING,
    status STRING,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_minute FLOAT,
    log_date DATE,
    operator_note STRING,  
    source_system STRING, 
    created_at TIMESTAMP
);

-- ############################################################
-- 🧠 SECTION 3: INSERT DUMMY DATA
-- ############################################################
-- load local csv files
-- dummy data preferences see Readme.md
