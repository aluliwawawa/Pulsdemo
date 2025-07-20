## Data Modeling Overview

The RAW layer preserves the original structure of source systems without normalization or business logic.

### Table Structure

Each incoming source is mapped directly to a table:

Table Name

Description

MACHINE_STATUS_LOG

Machine run-time and operational status logs

#### SMT_LOG

Surface Mount Technology production logs

#### AOI_LOG

Automated Optical Inspection results

#### FT_LOG

Functional Testing outcomes

### Mapping Data Sources (ERD)

All tables share common keys for future integration:

factory_id

machine_id

log_date

The Entity-Relationship Diagram (ERD) illustrates how these raw tables relate to downstream dimensions.

### Data Characteristics

Dirty data (nulls, type inconsistencies) are expected.

No major blockers for staging.

Designed to support realistic demo KPI computation.

### ETL Notes

SQL backups of table creation and ingestion scripts are available in Snowflake Worksheets.