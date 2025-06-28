# 04_mart - Analysis Modeling

## Objective
Define KPI models for Operational Controlling.

## KPI Definitions
- OEE = Availability × Performance × Quality
- Machine Utilization Rate = Runtime / (Runtime + Downtime + Idle)

## Data Lineage
Data sources:
- FACT_PRODUCTION
- FACT_DEFECT_DETAIL

## Formula Details
| KPI                 | Formula                         |
| ------------------- | ------------------------------- |
| OEE                 | Avail × Perf × Qual            |
| Machine Utilization | runtime / total available time |
| Defect Rate         | defect count / total units     |

## Tables Created
- FACT_MACHINE_UTILIZATION
- FACT_FACTORY_OEE_MONTHLY
- V_DEFECT_TREND_DAILY
