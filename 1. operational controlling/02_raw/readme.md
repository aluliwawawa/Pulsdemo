##Overview

The RAW layer acts as the landing zone for incoming data from various systems and sources. It captures unprocessed data with minimal transformation to preserve original integrity for downstream processes.

### Data Pipeline

Source Types: System APIs, File Uploads (CSV/Excel)

Fetch Frequency: One-time bulk load for demo purposes

Dictionary: Field definitions and data types are outlined in the data dictionary

Responsible Person: Anom(Demo)


### Data Quality Notes

The raw data contains some dirty records (e.g., nulls, inconsistent casing, missing fields)

However, these issues are not severe enough to block transformation into STG or MART layers.

Data is designed to support downstream KPI calculation:

✅ Machine Utilization

✅ Yield Rate

✅ Factory OEE

Time frame is scattered within January 2024, simulating realistic operational logs.

Dummy data includes defect codes to reflect real-world manufacturing scenarios.

### Files

MACHINE_STATUS_LOG.csv

SMT_LOG.csv

AOI_LOG.csv

FT_LOG.csv