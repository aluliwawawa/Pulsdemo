# P4_VIEW

## Purpose

This schema contains KPI views for business reporting and dashboard purposes. Views are designed based on the MART layer with simplified fields, proper aggregation, and business logic alignment.

## View List

| View Name                        | Description                                 |
| --------------------------------- | ------------------------------------------- |
| V_MACHINE_OEE_WEEKLY              | Machine-level OEE & Utilization (weekly)    |
| V_MACHINE_YIELD_WEEKLY            | Machine-level Yield & Output (weekly)       |
| V_FACTORY_OEE_MONTHLY             | Factory-level OEE & Utilization (monthly)   |
| V_FACTORY_OUTPUT_MONTHLY          | Factory-level Yield & Output (monthly)      |

## Source

All views are based on `P3_MART.MART_ALL`.