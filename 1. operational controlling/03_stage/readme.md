# Stage Layer (P2_STAGE)

DQ Script: null_check, value_check, join_check, consistency_check (fail+pass=total)

## Purpose

The Stage layer is designed to:

- Standardize data structures from different raw sources (SMT, AOI, FT, machine logs).
- Clean and deduplicate data (e.g., factory, machine, product, defect codes).
- Build consistent dimension tables.
- Prepare standardized fact tables for further modeling in the MART layer.

## Tables in Stage

| Table                         | Description                          |
| ----------------------------- | ------------------------------------- |
| **DIM_DATE**                  | Generated full calendar table        |
| **DIM_FACTORY**               | Cleaned factory list                 |
| **DIM_MACHINE**               | Cleaned machine list with types      |
| **DIM_PRODUCT**               | Product list deduplicated            |
| **DIM_DEFECT**                | Defect codes cleaned and standardized|
| **STG_PRODUCTION_LOG**        | Unified production log from SMT/AOI/FT|
| **STG_MACHINE_STATUS_LOG**    | Standardized machine status logs     |

## SQL Files

| File                              | Description                       |
| --------------------------------- | --------------------------------- |
| **01_create_stage_tables.sql**    | Create dimension and fact tables  |
| **02_etl_dim.sql**                | Extract and clean dimension tables|
| **03_etl_fact.sql**               | Standardize and merge fact tables |
| **04_sample_queries.sql**         | Sample queries to validate Stage  |

## Notes

- No physical constraints on keys in Snowflake, but primary keys and unique keys are defined for clarity.
- If any data quality issue (e.g., defect codes inconsistency) is found, a specific dimension table is built to clean it here.


STG = RAW清洗 + DIM补充（Planned Time, Ideal Cycle Time等）