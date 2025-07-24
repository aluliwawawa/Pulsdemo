# Stage Layer – Data Quality & Preparation

This stage transforms raw business data into clean, query-ready format for modeling in the Mart layer. It includes basic field standardization and quality validation.

---

## ✅ Included Stage Tables

| Table Name                      | Description                      |
|---------------------------------|----------------------------------|
| `STG_LEDGER`                    | Accounts receivable records      |
| `STG_CUSTOMER`                  | Customer master data             |
| `STG_SALES_ORDER`              | Sales orders data                |

---

## 🛠 Key Cleaning Rules

- Standardized `DATE`, `BOOLEAN`, `NUMBER` types
- Converted `IS_KA` from Y/N → TRUE/FALSE
- Verified `DUE_DATE >= INVOICE_DATE`
- Checked NULLs in primary fields
- Flagged invalid entries into `DQ_REPORT`

---

## 📋 Data Quality Checks

Stored in:  
`P2_STAGE.DQ_REPORT`

| Issue Type         | Description                            |
|--------------------|----------------------------------------|
| `NULL_VALUE`       | Critical fields contain NULLs          |
| `NEGATIVE_AMOUNT`  | Amount fields contain negatives         |
| `DATE_INCONSISTENT`| Due date earlier than invoice date     |
| `INVALID_BOOLEAN`  | Boolean fields not TRUE/FALSE           |
| `TYPE_MISMATCH`    | Field types deviate from expected spec |
