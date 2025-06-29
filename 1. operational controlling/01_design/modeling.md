# Operational Controlling - Schema Modeling

## Objective

This document describes the **Galaxy Schema model** for Operational Controlling. It serves as the foundation for all downstream data transformations and reporting.

---

## Schema Overview

### Fact Tables

| Table                      | Description                                       |
| -------------------------- | ------------------------------------------------- |
| **FACT_PRODUCTION**        | Daily production summary by machine and product   |
| **FACT_DEFECT_DETAIL**     | Detailed defect logs                              |
| **FACT_MACHINE_STATE_LOG** | Status Log of All Machines                        |

### Dimension Tables
| Table           | Description                                 |
| ----------------| --------------------------------------------|
| **DIM_DATE**    | Standard date dimension                     |
| **DIM_FACTORY** | Factory metadata (factory_id, location)     |
| **DIM_MACHINE** | Machine metadata (machine_id, type, factory)|
| **DIM_PRODUCT** | Product catalog                             |
| **DIM_DEFECT**  | Defect types and descriptions               |

**Feilds explained in Dictionary.md**

---

## Table Relationships

FACT_PRODUCTION --> DIM_DATE
FACT_PRODUCTION --> DIM_FACTORY
FACT_PRODUCTION --> DIM_MACHINE
FACT_PRODUCTION --> DIM_PRODUCT

FACT_DEFECT_DETAIL --> DIM_DATE
FACT_DEFECT_DETAIL --> DIM_FACTORY
FACT_DEFECT_DETAIL --> DIM_MACHINE
FACT_DEFECT_DETAIL --> DIM_PRODUCT
FACT_DEFECT_DETAIL --> DIM_DEFECT

FACT_MACHINE_STATE_LOG --> DIM_DATE
FACT_MACHINE_STATE_LOG --> DIM_FACTORY
FACT_MACHINE_STATE_LOG --> DIM_MACHINE

---

## Design Principles

- Conforms to Kimball dimensional modeling standards.
- Galaxy schema structure with shared dimensions across multiple fact tables.
- Supports operational analysis including:
  - Production yield and performance
  - Defect trends
  - Machine utilization and OEE

---

## Summary

This schema is designed to:

- Enable scalable analytics for Operational Controlling.
- Feed consistent data into KPI dashboards.
- Serve as a solid foundation for downstream business data marts.

