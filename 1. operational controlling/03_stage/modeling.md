# STG Modeling Document

## 1. Scope
STG = Data cleaning from RAW + Enrichment with DIM.
In Demo phase, STG & DIM Tables are placed under one schema.
No business analytic integration is performed at this stage.

## 2. General Cleaning Rules
Standardize all ID fields (factory_id, machine_id, product_id) with TRIM() and UPPER().
Convert all date and timestamp fields to DATE or TIMESTAMP_NTZ.
Add technical fields:
  etl_load_time: ETL load timestamp.
  source_table: Source table name for data lineage.

## 3. Table-specific Cleaning Actions

### STG_MACHINE_STATUS_LOG
Map status 'IDLE' → 'MAINTENANCE'.
Fill null in operator_note with 'N/A'.
Duration check passed, no adjustment needed.

### STG_SMT_LOG
Fill null in defect_code with 'N/A'.
Standardize shift to uppercase ('DAY' / 'NIGHT').
Pass rate check passed.

### STG_AOI_LOG
Fill null in camera_id with 'UNKNOWN'.
Fill null in inspection_type with 'UNKNOWN'.
Fill null in defect_code with 'N/A'.
Pass rate check passed.

### STG_FT_LOG
Fill null in error_code with 'UNKNOWN'.
Specifically ensure that records with pass_flag = False and missing error_code are filled with 'UNKNOWN'.
No negative value found in test_duration_sec.

## 4. DIM Enrichment
Join the following dimension tables to enrich STG tables:
  DIM_MACHINE: Add machine_type and ideal_cycle_time.
  DIM_FACTORY: Add planned_time.
  DIM_DATE: Standard date dimension for time-based analysis.
  DIM_PRODUCT: Add product_name, product_line, generation.
  DIM_DEFECT: Add defect_name and defect_group.

## 5. Dimension Table Design

### DIM_FACTORY
  factory_id
  factory_name
  planned_time (in minutes/day)

### DIM_MACHINE
  machine_id
  machine_type
  ideal_cycle_time (in seconds)

### DIM_DATE
  date_key (YYYYMMDD)
  date (YYYY-MM-DD)
  year
  month
  month_name
  week
  weekday
  quarter
  fiscal_year

### DIM_PRODUCT
  product_id
  product_name
  product_line
  generation

### DIM_DEFECT
  defect_code
  defect_name
  defect_group