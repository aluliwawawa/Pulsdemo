
## 🌟 Mart Layer Design

Mart layer will distinguish Fact and Dimension tables.

### ✅ Fact Tables

1. **FACT\_SALES**

   * Source: `STAGE_SALES_ORDER`
   * Fields:

     * `ORDER_ID`
     * `CUSTOMER_ID`
     * `DATE_ID` (linked to Dim\_Date)
     * `REGION_ID` (linked to Dim\_Region)
     * `AMOUNT`

2. **FACT\_AR**

   * Source: `STAGE_AR_LEDGER`
   * Fields:

     * `AR_ID`
     * `CUSTOMER_ID`
     * `INVOICE_DATE_ID` (linked to Dim\_Date)
     * `DUE_DATE_ID` (linked to Dim\_Date)
     * `PAID_DATE_ID` (linked to Dim\_Date)
     * `REGION_ID` (linked to Dim\_Region)
     * `AMOUNT`

### ✅ Dimension Tables

1. **DIM\_CUSTOMER**

   * Source: `STAGE_CUSTOMER`
   * Fields:

     * `CUSTOMER_ID`
     * `CUSTOMER_NAME`
     * `IS_KA`
     * `REGION_ID` (linked to Dim\_Region)

2. **DIM\_DATE**

   * Generated calendar table
   * Fields:

     * `DATE_ID`
     * `DATE`
     * `YEAR`
     * `MONTH`
     * `DAY`
     * `WEEKDAY`
     * `QUARTER`

3. **DIM\_REGION**

   * Derived from distinct `region_code`
   * Fields:

     * `REGION_ID`
     * `REGION_NAME`

---

## ⚠️ Data Issues Observed in Dummy Data

* **AR Ledger**

  * Some `due_date` is earlier than `invoice_date` (need validation)
  * Check for missing or invalid `paid_date`
* **Customer**

  * `is_KA` is text Y/N instead of boolean
  * Region codes need verification
* **Sales Order**

  * Region codes mismatch in some rows
  * Validate if all `customer_id` exist in `CUSTOMER`
