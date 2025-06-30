-- ############################################################
-- SECTION 3: SAMPLE QUERY
-- ############################################################
-- showcase the success of data aggregation based on views of KPI (yield rate, Machine Util, OEE)

SELECT YIELD_RATE_PERCENT,UTILIZATION_PERCENT,OEE_PERCENT
FROM DEMO_PULS_OPERATION.P3_MART.MART_ALL
WHERE FACTORY_ID = 'F3'
ORDER BY iso_year_week DESC
LIMIT 10;

-- ############################################################
-- SECTION 1: Create Table
-- ############################################################

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P3_MART.MART_ALL (
    factory_id            STRING,
    machine_id            STRING,
    machine_type          STRING,
    iso_year_week         STRING,  
    total_units           NUMBER,
    passed_units          NUMBER,
    failed_units          NUMBER,
    yield_rate_percent    FLOAT,  
    runtime_min           FLOAT,  
    planned_time_min      FLOAT,   
    utilization_percent   FLOAT,  
    oee_percent           FLOAT,   
    source_table          STRING, 
    etl_load_time         TIMESTAMP  
);

-- ############################################################
-- SECTION 2: JOIN DATA FROM STAGES FOR KPI CALC
-- ############################################################
-- KPI defined as Yield Rate, Machine Utilization and OEE Rate

INSERT INTO DEMO_PULS_OPERATION.P3_MART.MART_MACHINE_WEEKLY
WITH base AS (
    SELECT 
        factory_id,
        machine_id,
        product_id,
        log_date,
        total_units,
        passed_units,
        failed_units,
        defect_code,
        shift,
        cycle_time_sec,
        source_table,
        etl_load_time
    FROM DEMO_PULS_OPERATION.P2_STAGE.STG_SMT_LOG

    UNION ALL

    SELECT 
        factory_id,
        machine_id,
        product_id,
        log_date,
        total_units,
        passed_units,
        failed_units,
        defect_code,
        'UNKNOWN' AS shift, -- no shift in AOI,
        cycle_time_sec,
        source_table,
        etl_load_time
    FROM DEMO_PULS_OPERATION.P2_STAGE.STG_AOI_LOG
),

machine_status_daily AS (
    -- daily aggregation
    SELECT
        machine_id,
        log_date,
        SUM(duration_minute) AS runtime_min
    FROM DEMO_PULS_OPERATION.P2_STAGE.STG_MACHINE_STATUS_LOG
    GROUP BY machine_id, log_date
)

SELECT
    b.factory_id,
    b.machine_id,
    m.machine_type,

    EXTRACT(YEAR FROM DATE_TRUNC('WEEK', b.log_date)) || '-W' ||
    LPAD(EXTRACT(WEEK FROM DATE_TRUNC('WEEK', b.log_date)), 2, '0') AS iso_year_week,

    -- Output
    SUM(b.total_units) AS total_units,
    SUM(b.passed_units) AS passed_units,
    SUM(b.failed_units) AS failed_units,

    -- YR
    ROUND(SUM(b.passed_units) * 100.0 / NULLIF(SUM(b.total_units), 0), 2) AS yield_rate_percent,

    -- Runtime
    COALESCE(SUM(ms.runtime_min), 0) AS runtime_min,

    -- WeeklyPlan
    MAX(f.planned_time) * COUNT(DISTINCT b.log_date) AS planned_time_min,

    -- Utilization
    ROUND(
        COALESCE(SUM(ms.runtime_min), 0) * 100.0 / 
        NULLIF(MAX(f.planned_time) * COUNT(DISTINCT b.log_date), 0), 
    2) AS utilization_percent,

    -- OEE
    ROUND(
        (
            (COALESCE(SUM(ms.runtime_min), 0) / 
            NULLIF(MAX(f.planned_time) * COUNT(DISTINCT b.log_date), 0)) -- Availability
            *
            (MAX(m.ideal_cycle_time) * SUM(b.total_units) / 
            NULLIF(COALESCE(SUM(ms.runtime_min), 0), 0)) -- Performance
            *
            (SUM(b.passed_units) / NULLIF(SUM(b.total_units), 0)) -- Quality
        ) * 100.0, 2
    ) AS oee_percent,

    'STG_SMT_AOI' AS source_table,
    CURRENT_TIMESTAMP() AS etl_load_time

FROM base b

LEFT JOIN machine_status_daily ms
    ON b.machine_id = ms.machine_id AND b.log_date = ms.log_date

LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_MACHINE m
    ON b.machine_id = m.machine_id

LEFT JOIN DEMO_PULS_OPERATION.P2_STAGE.DIM_FACTORY f
    ON b.factory_id = f.factory_id

GROUP BY
    b.factory_id,
    b.machine_id,
    m.machine_type,
    EXTRACT(YEAR FROM DATE_TRUNC('WEEK', b.log_date)),
    EXTRACT(WEEK FROM DATE_TRUNC('WEEK', b.log_date));
