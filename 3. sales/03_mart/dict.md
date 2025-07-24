# Data Dictionary – MART Layer (P3_MART)

## FACT_SALES
| Column        | Type     | Description                      |
|---------------|----------|----------------------------------|
| SALES_ID      | STRING   | Unique sales transaction ID      |
| CUSTOMER_ID   | STRING   | Linked customer ID (FK)          |
| PRODUCT_ID    | STRING   | Linked product ID (FK)           |
| REGION_CODE   | STRING   | Sales region (e.g. CN, US)       |
| AMOUNT        | NUMBER   | Sales revenue amount             |
| DATE_ID       | DATE     | Transaction date (FK to DIM_DATE)|

---

## FACT_AR
| Column           | Type     | Description                          |
|------------------|----------|--------------------------------------|
| AR_ID            | STRING   | Unique accounts receivable ID        |
| CUSTOMER_ID      | STRING   | Linked customer ID (FK)              |
| AMOUNT           | NUMBER   | AR value                             |
| INVOICE_DATE_ID  | DATE     | Invoice date (FK to DIM_DATE)        |
| DUE_DATE_ID      | DATE     | Payment due date (FK to DIM_DATE)    |
| PAID_DATE_ID     | DATE     | Actual paid date (FK to DIM_DATE)    |

---

## DIM_CUSTOMER
| Column        | Type     | Description                        |
|---------------|----------|------------------------------------|
| CUSTOMER_ID   | STRING   | Unique customer ID (PK)            |
| CUSTOMER_NAME | STRING   | Name of customer                   |
| IS_KEY_ACCOUNT| BOOLEAN  | Whether the customer is a KA       |

---

## DIM_PRODUCT
| Column      | Type     | Description                  |
|-------------|----------|------------------------------|
| PRODUCT_ID  | STRING   | Unique product ID (PK)       |
| PRODUCT_NAME| STRING   | Product name or description  |

---

## DIM_DATE
| Column     | Type     | Description                   |
|------------|----------|-------------------------------|
| DATE_ID    | DATE     | Primary date key (PK)         |
| YEAR       | INT      | Year part of the date         |
| MONTH      | INT      | Month part of the date        |
| DAY        | INT      | Day part of the date          |
| QUARTER    | INT      | Quarter of the year           |
