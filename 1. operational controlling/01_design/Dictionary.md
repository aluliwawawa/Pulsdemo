# Data Dictionary - Operational Controlling (Galaxy Schema)

## Dimension Tables

### 1 DIM_DATE
| Column       | Type    | Description                     |
| -------------| ------- | ------------------------------- |
| date_sk      | INT     | Surrogate Key (PK)              |
| date_id      | DATE    | Natural Key (YYYY-MM-DD)        |
| year         | INT     | Year                            |
| month        | INT     | Month                           |
| day          | INT     | Day                             |
| week         | INT     | Week                            |
| quarter      | INT     | Quarter                         |
| is_weekend   | BOOLEAN | Is weekend                      |
| is_holiday   | BOOLEAN | Is holiday                      |
| day_name     | VARCHAR | Day of week (Monday, Tuesday...)|

---

### 2 DIM_FACTORY
| Column       | Type        | Description                  |
| -------------| ------------| ---------------------------- |
| factory_sk   | INT         | Surrogate Key (PK)           |
| factory_id   | VARCHAR(50) | Natural Key (business ID)    |
| factory_name | VARCHAR(100)| Factory name                 |
| location     | VARCHAR(100)| City/Region                  |

---

### 3 DIM_MACHINE
| Column       | Type        | Description                  |
| -------------| ------------| ---------------------------- |
| machine_sk   | INT         | Surrogate Key (PK)           |
| machine_id   | VARCHAR(50) | Natural Key (business ID)    |
| machine_type | VARCHAR(50) | SMT/AOI/FT etc.              |
| factory_sk   | INT         | Factory surrogate key (FK)   |

---

### 4 DIM_PRODUCT
| Column       | Type        | Description                  |
| -------------| ------------| ---------------------------- |
| product_sk   | INT         | Surrogate Key (PK)           |
| product_id   | VARCHAR(50) | Natural Key (business ID)    |
| product_name | VARCHAR(100)| Product name                 |
| product_type | VARCHAR(50) | Product category/type        |

---

### 5 DIM_DEFECT
| Column            | Type        | Description                |
| ------------------| ------------| ---------------------------|
| defect_sk         | INT         | Surrogate Key (PK)         |
| defect_code       | VARCHAR(50) | Natural Key (business ID)  |
| defect_category   | VARCHAR(50) | Category (e.g. visual, functional) |
| defect_description| VARCHAR(200)| Description                |

---

## Fact Tables

### 1 FACT_PRODUCTION
| Column           | Type        | Description                      |
| -----------------| ------------| --------------------------------- |
| production_id    | INT         | Surrogate Key (PK)               |
| date_sk          | INT         | FK to DIM_DATE                   |
| factory_sk       | INT         | FK to DIM_FACTORY                |
| machine_sk       | INT         | FK to DIM_MACHINE                |
| product_sk       | INT         | FK to DIM_PRODUCT                |
| total_units      | INT         | Total produced units             |
| passed_units     | INT         | Passed (OK) units                |
| failed_units     | INT         | Failed (NOK) units               |
| defect_rate      | FLOAT       | failed_units / total_units       |
| avg_cycle_time   | FLOAT       | Average production cycle time (s)|
| created_at       | TIMESTAMP   | Record creation timestamp        |

---

### 2 FACT_DEFECT_DETAIL
| Column           | Type        | Description                      |
| -----------------| ------------| --------------------------------- |
| defect_event_id  | INT         | Surrogate Key (PK)               |
| date_sk          | INT         | FK to DIM_DATE                   |
| factory_sk       | INT         | FK to DIM_FACTORY                |
| machine_sk       | INT         | FK to DIM_MACHINE                |
| product_sk       | INT         | FK to DIM_PRODUCT                |
| defect_sk        | INT         | FK to DIM_DEFECT                 |
| defect_count     | INT         | Number of defects                |
| created_at       | TIMESTAMP   | Record creation timestamp        |

---

### 3 FACT_MACHINE_STATE_LOG
| Column           | Type        | Description                      |
| -----------------| ------------| --------------------------------- |
| state_event_id   | INT         | Surrogate Key (PK)               |
| date_sk          | INT         | FK to DIM_DATE                   |
| factory_sk       | INT         | FK to DIM_FACTORY                |
| machine_sk       | INT         | FK to DIM_MACHINE                |
| status           | VARCHAR(20) | RUNNING, DOWN, IDLE, MAINTENANCE |
| start_time       | TIMESTAMP   | State start time                 |
| end_time         | TIMESTAMP   | State end time                   |
| duration_minutes | FLOAT       | Duration in minutes              |
| created_at       | TIMESTAMP   | Record creation timestamp        |

---

## Notes
- **Surrogate Keys** are autoincrement integer-based primary keys for internal consistency and better performance.
- **Natural Keys** are retained for traceability to source systems.
