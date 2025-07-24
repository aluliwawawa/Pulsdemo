# Stage Plan

This document explains the data cleaning approach for the DEMO project sales module.

---

## 📦 Data Sources (RAW)

1. **RAW\_AR\_LEDGER.csv**
   * Fields: `ar_id`, `customer_id`, `invoice_date`, `due_date`, `paid_date`, `amount`, `ingestion_date`

2. **RAW\_CUSTOMER.csv**
   * Fields: `customer_id`, `customer_name`, `is_KA`, `region_code`, `ingestion_date`

3. **RAW\_SALES\_ORDER.csv**
   * Fields: `order_id`, `customer_id`, `order_date`, `amount`, `region_code`, `ingestion_date`

---

## Cleaning Steps (Stage)

### 1. `STAGE_AR_LEDGER`

* **Date Fields**
  * Convert `invoice_date`, `due_date`, `paid_date` to `DATE` type.
  * For `due_date < invoice_date`, flag it.

---

### 2. `STAGE_CUSTOMER`

* **is\_KA**
  * Convert from 'Y'/'N' → BOOLEAN (`TRUE/FALSE`).

---

### 3.`STAGE_SALES_ORDER`

* **Date Fields**

  * Convert `order_date` to `DATE` type.


At this Stage layer, **no dimensional/fact modeling** is performed. Data is lightly cleaned and standardized for later processing.
