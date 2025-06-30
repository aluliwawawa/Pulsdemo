-- ############################################################
-- SECTION 6: SAMPLE QUERY
-- ############################################################
-- sample 1: showcase the success of data standardization and join dimensions (Machine Type, Planned Time, Ideal Cycle Time etc.)

SELECT
    factory_id,
    machine_id,
    machine_type,
    product_id,
    log_date,
    total_units,
    passed_units,
    failed_units,
    defect_code,
    planned_time,
    ideal_cycle_time
FROM DEMO_PULS_OPERATION.P2_STAGE.STG_SMT_LOG
ORDER BY log_date DESC
LIMIT 10;

-- ############################################################
-- SECTION 1: CREATE STAGE TABLES
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.STG_MACHINE_STATUS_LOG (
    factory_id         STRING,
    machine_id         STRING,
    machine_type       STRING,           -- from DIM_MACHINE
    start_time         TIMESTAMP_NTZ,
    end_time           TIMESTAMP_NTZ,
    duration_minute    NUMBER(10,2),
    status             STRING,
    log_date           DATE,
    operator_note      STRING,
    planned_time       NUMBER(10,2),     -- from DIM_FACTORY
    ideal_cycle_time   NUMBER(10,2),     -- from DIM_MACHINE
    source_system      STRING,
    created_at         TIMESTAMP_NTZ,
    source_table       STRING,
    etl_load_time      TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.STG_SMT_LOG (
    factory_id         STRING,
    machine_id         STRING,
    machine_type       STRING,           -- from DIM_MACHINE
    product_id         STRING,
    log_date           DATE,
    total_units        NUMBER,
    passed_units       NUMBER,
    failed_units       NUMBER,
    defect_code        STRING,
    cycle_time_sec     FLOAT,
    operator_id        STRING,
    shift              STRING,
    planned_time       NUMBER(10,2),     -- from DIM_FACTORY
    ideal_cycle_time   NUMBER(10,2),     -- from DIM_MACHINE
    source_system      STRING,
    created_at         TIMESTAMP_NTZ,
    source_table       STRING,
    etl_load_time      TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.STG_AOI_LOG (
    factory_id         STRING,
    machine_id         STRING,
    machine_type       STRING,           -- from DIM_MACHINE
    product_id         STRING,
    log_date           DATE,
    total_units        NUMBER,
    passed_units       NUMBER,
    failed_units       NUMBER,
    defect_code        STRING,
    cycle_time_sec     FLOAT,
    camera_id          STRING,
    inspection_type    STRING,
    planned_time       NUMBER(10,2),     -- from DIM_FACTORY
    ideal_cycle_time   NUMBER(10,2),     -- from DIM_MACHINE
    source_system      STRING,
    created_at         TIMESTAMP_NTZ,
    source_table       STRING,
    etl_load_time      TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.STG_FT_LOG (
    factory_id         STRING,
    machine_id         STRING,
    machine_type       STRING,           -- from DIM_MACHINE
    product_id         STRING,
    log_date           DATE,
    pass_flag          BOOLEAN,
    test_duration_sec  FLOAT,
    test_station       STRING,
    error_code         STRING,
    planned_time       NUMBER(10,2),     -- from DIM_FACTORY
    ideal_cycle_time   NUMBER(10,2),     -- from DIM_MACHINE
    source_system      STRING,
    created_at         TIMESTAMP_NTZ,
    source_table       STRING,
    etl_load_time      TIMESTAMP_NTZ
);

   
-- ############################################################
-- SECTION 2: CREATE DIM TABLES
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY (
    factory_id       STRING PRIMARY KEY,
    factory_name     STRING,
    PLANNED_TIME NUMBER(10,2),
    created_at       TIMESTAMP_NTZ,
    updated_at       TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE (
    machine_id         STRING PRIMARY KEY,
    machine_type       STRING,
    ideal_cycle_time   NUMBER(10,2),  -- Ideal cycle time per unit in seconds
    created_at         TIMESTAMP_NTZ,
    updated_at         TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DIM_DATE (
    date_key     INT PRIMARY KEY,    -- Format: YYYYMMDD
    date         DATE,
    year         INT,
    quarter      STRING,             -- 'Q1', 'Q2' ...
    month        INT,
    month_name   STRING,
    week         INT,
    weekday      INT,                -- 1 = Monday
    weekday_name STRING,
    fiscal_year  STRING,
    is_weekend   BOOLEAN,
    created_at   TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DIM_PRODUCT (
    product_id    STRING PRIMARY KEY,
    product_name  STRING,
    product_line  STRING,
    generation    STRING,
    created_at    TIMESTAMP_NTZ,
    updated_at    TIMESTAMP_NTZ
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DIM_DEFECT (
    defect_code   STRING PRIMARY KEY,
    defect_name   STRING,
    defect_group  STRING,
    created_at    TIMESTAMP_NTZ,
    updated_at    TIMESTAMP_NTZ
);

-- ############################################################
-- SECTION 3: INSERT DUMMY DATA IN DIM TABLES
-- ############################################################

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DIM_DATE
SELECT 
  TO_NUMBER(TO_CHAR(dates.date, 'YYYYMMDD')) AS date_key,
  dates.date,
  YEAR(dates.date) AS year,
  CONCAT('Q', QUARTER(dates.date)) AS quarter,
  MONTH(dates.date) AS month,
  TO_CHAR(dates.date, 'Month') AS month_name,
  WEEK(dates.date) AS week,
  DAYOFWEEK(dates.date) AS weekday,
  TO_CHAR(dates.date, 'Day') AS weekday_name,
  CONCAT('FY', YEAR(dates.date)) AS fiscal_year,
  CASE WHEN DAYOFWEEK(dates.date) IN (6,7) THEN TRUE ELSE FALSE END AS is_weekend,
  CURRENT_TIMESTAMP() AS created_at
FROM (
    SELECT DATEADD(day, SEQ4(), '2024-01-01') AS date
    FROM TABLE(GENERATOR(ROWCOUNT => 1000))
) AS dates;

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DIM_DEFECT (defect_code, defect_name, defect_group)
VALUES 
('D_SOLDER', 'Solder Short', 'SMT'),
('D_MISSING', 'Missing Component', 'SMT'),
('D_MISALIGN', 'Component Misalignment', 'SMT'),
('D_CRACK', 'PCB Crack', 'AOI'),
('D_OPEN', 'Open Circuit', 'FT'),
('D_SHORT', 'Short Circuit', 'FT');

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY (factory_id, factory_name, planned_time)
VALUES
  ('F1', 'Suzhou Plant', 780),
  ('F2', 'Munich Plant', 700),
  ('F3', 'Chomutov Plant', 720);


INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE (machine_id, machine_type, ideal_cycle_time)
VALUES
  ('AOI01', 'AOI', 45),
  ('FT01', 'FT', 90),
  ('SMT01', 'SMT', 60),
  ('SMT02', 'SMT', 59),
  ('SMT03', 'SMT', 56);

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DIM_PRODUCT (product_id, product_name, product_line, generation)
VALUES
  ('F100', 'FLEX 100', 'FLEX', 'Gen1'),
  ('P100', 'PIANO 100', 'PIANO', 'Gen1'),
  ('P200', 'PIANO 200', 'PIANO', 'Gen2'),
  ('P300', 'PIANO 300', 'PIANO', 'Gen3'),
  ('S100', 'SMART 100', 'SMART', 'Gen1'),
  ('S200', 'SMART 200', 'SMART', 'Gen2'),
  ('S300', 'SMART 300', 'SMART', 'Gen3');


-- ############################################################
-- SECTION 4: DATA CLEAN FOR STAGE TABLES
-- ############################################################
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.STG_MACHINE_STATUS_LOG
SELECT
    TRIM(UPPER(r.factory_id)) AS factory_id,
    TRIM(UPPER(r.machine_id)) AS machine_id,
    d_m.machine_type,
    CAST(r.start_time AS TIMESTAMP_NTZ) AS start_time,
    CAST(r.end_time AS TIMESTAMP_NTZ) AS end_time,
    r.duration_minute,
    CASE 
        WHEN UPPER(r.status) = 'IDLE' THEN 'MAINTENANCE'
        ELSE UPPER(r.status)
    END AS status,
    CAST(r.log_date AS DATE) AS log_date,
    COALESCE(r.operator_note, 'N/A') AS operator_note,
    d_f.PLANNED_TIME,
    d_m.ideal_cycle_time,
    r.source_system,
    CAST(r.created_at AS TIMESTAMP_NTZ) AS created_at,
    'MACHINE_STATUS_LOG' AS source_table,
    CURRENT_TIMESTAMP() AS etl_load_time
FROM DEMO_PULS_OPERATION.P1_RAW.MACHINE_STATUS_LOG r
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE d_m
    ON TRIM(UPPER(r.machine_id)) = d_m.machine_id
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY d_f
    ON TRIM(UPPER(r.factory_id)) = d_f.factory_id;

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.STG_SMT_LOG
SELECT
    TRIM(UPPER(r.factory_id)) AS factory_id,
    TRIM(UPPER(r.machine_id)) AS machine_id,
    d_m.machine_type,
    TRIM(UPPER(r.product_id)) AS product_id,
    CAST(r.log_date AS DATE) AS log_date,
    r.total_units,
    r.passed_units,
    r.failed_units,
    COALESCE(r.defect_code, 'N/A') AS defect_code,
    r.cycle_time_sec,
    r.operator_id,
    UPPER(r.shift) AS shift,
    d_f.PLANNED_TIME,
    d_m.ideal_cycle_time,
    'UNKNOWN' AS source_system,   
    CAST(r.created_at AS TIMESTAMP_NTZ) AS created_at,
    'SMT_LOG' AS source_table,
    CURRENT_TIMESTAMP() AS etl_load_time
FROM DEMO_PULS_OPERATION.P1_RAW.SMT_LOG r
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE d_m
    ON TRIM(UPPER(r.machine_id)) = d_m.machine_id
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY d_f
    ON TRIM(UPPER(r.factory_id)) = d_f.factory_id;
UPDATE DEMO_PULS_OPERATION.P2_STAGE.STG_SMT_LOG
SET total_units = '99' --manual correction
WHERE log_date = '2024-1-19';
    
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.STG_AOI_LOG
SELECT
    TRIM(UPPER(r.factory_id)) AS factory_id,
    TRIM(UPPER(r.machine_id)) AS machine_id,
    d_m.machine_type,
    TRIM(UPPER(r.product_id)) AS product_id,
    CAST(r.log_date AS DATE) AS log_date,
    r.total_units,
    r.passed_units,
    r.failed_units,
    COALESCE(r.defect_code, 'N/A') AS defect_code,
    r.cycle_time_sec,
    COALESCE(r.camera_id, 'UNKNOWN') AS camera_id,
    COALESCE(r.inspection_type, 'UNKNOWN') AS inspection_type,
    d_f.PLANNED_TIME,
    d_m.ideal_cycle_time,
    'UNKNOWN' AS source_system,   
    CAST(r.created_at AS TIMESTAMP_NTZ) AS created_at,
    'AOI_LOG' AS source_table,
    CURRENT_TIMESTAMP() AS etl_load_time
FROM DEMO_PULS_OPERATION.P1_RAW.AOI_LOG r
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE d_m
    ON TRIM(UPPER(r.machine_id)) = d_m.machine_id
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY d_f
    ON TRIM(UPPER(r.factory_id)) = d_f.factory_id;

INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.STG_FT_LOG
SELECT
    TRIM(UPPER(r.factory_id)) AS factory_id,
    TRIM(UPPER(r.machine_id)) AS machine_id,
    d_m.machine_type,
    TRIM(UPPER(r.product_id)) AS product_id,
    CAST(r.log_date AS DATE) AS log_date,
    r.pass_flag,
    r.test_duration_sec,
    r.test_station,
    COALESCE(r.error_code, 'UNKNOWN') AS error_code,
    d_f.PLANNED_TIME,
    d_m.ideal_cycle_time,
    'UNKNOWN' AS source_system,   
    CAST(r.created_at AS TIMESTAMP_NTZ) AS created_at,
    'FT_LOG' AS source_table,
    CURRENT_TIMESTAMP() AS etl_load_time
FROM DEMO_PULS_OPERATION.P1_RAW.FT_LOG r
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE d_m
    ON TRIM(UPPER(r.machine_id)) = d_m.machine_id
LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY d_f
    ON TRIM(UPPER(r.factory_id)) = d_f.factory_id;

-- ############################################################
-- SECTION 5: DATA QUALITY CHECK TOOL
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P2_STAGE.DQ_REPORT (
    table_name    STRING,
    check_type    STRING,
    column_name   STRING,
    issue_count   NUMBER,
    total_count   NUMBER,
    check_date    DATE DEFAULT CURRENT_DATE()
);

--clear data for testing
TRUNCATE TABLE DEMO_PULS_OPERATION.P2_STAGE.STG_AOI_LOG;

-- SET DQ check target
SET target_table = 'DEMO_PULS_OPERATION.P2_STAGE.STG_AOI_LOG';
SET table_label = 'STG_AOI_LOG';

-- ✅ Null Check
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DQ_REPORT
(
SELECT $table_label, 'null_check', 'factory_id', COUNT_IF(factory_id IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'null_check', 'machine_id', COUNT_IF(machine_id IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'null_check', 'product_id', COUNT_IF(product_id IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'null_check', 'log_date', COUNT_IF(log_date IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
);


-- ✅ Join Check
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DQ_REPORT
(
SELECT $table_label, 'join_check', 'machine_type', COUNT_IF(machine_type IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'join_check', 'planned_time', COUNT_IF(planned_time IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'join_check', 'ideal_cycle_time', COUNT_IF(ideal_cycle_time IS NULL), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
);




-- ✅ Value Check (Negative Number Check)
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DQ_REPORT
(
SELECT $table_label, 'value_check', 'total_units_negative', COUNT_IF(total_units < 0), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'value_check', 'passed_units_negative', COUNT_IF(passed_units < 0), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'value_check', 'failed_units_negative', COUNT_IF(failed_units < 0), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
UNION ALL
SELECT $table_label, 'value_check', 'cycle_time_negative', COUNT_IF(cycle_time_sec < 0), COUNT(*), CURRENT_DATE()
FROM IDENTIFIER($target_table)
);


-- ✅ Consistency Check (Pass + Fail = Total)
INSERT INTO DEMO_PULS_OPERATION.P2_STAGE.DQ_REPORT
(
SELECT $table_label, 'consistency_check', 'pass_plus_fail_vs_total',
       COUNT_IF(passed_units + failed_units != total_units),
       COUNT(*),
       CURRENT_DATE()
FROM IDENTIFIER($target_table)
);