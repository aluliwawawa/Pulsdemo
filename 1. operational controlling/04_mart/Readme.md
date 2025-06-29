# 04_mart - Business Data Modeling

## Purpose
This schema contains business-driven data models for Operational Controlling.

## Contents
| File                     | Description                         |
| ------------------------ | ----------------------------------- |
| analysis_modeling.md     | KPI modeling (OEE, Utilization, etc.) |
| dictionary.md            | Data dictionary for mart tables     |
| model_sql/               | SQL scripts to create mart tables   |

## Tables in this schema
- FACT_MACHINE_UTILIZATION
- FACT_FACTORY_OEE_MONTHLY
- V_DEFECT_TREND_DAILY
- V_FACTORY_PERFORMANCE_SUMMARY

## 🔄 Data Pipeline
Data flows from:
