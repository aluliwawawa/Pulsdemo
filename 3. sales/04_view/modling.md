# View Modeling – KPI Logic

## V_SALES
KPI Fields:
- `MONTHLY_REVENUE`: Sum of sales per month
- `GOAL_ACHIEVEMENT_PERCENT`: Revenue vs fixed goal (73000)
- `KA_PERCENT`: Share of Key Account revenue

Joins:
- FACT_SALES ←→ DIM_CUSTOMER (customer info)
- FACT_SALES ←→ DIM_DATE (date hierarchy)

## V_AR
KPI Fields:
- `TOTAL_AR_AMOUNT`: Total receivable
- `DSO`: calculated for 30 days
- `AGING_0_30`, `AGING_31_60`, `AGING_61_90`: Aging buckets by due date

Joins:
- FACT_AR ←→ DIM_DATE (INVOICE_DATE_ID, DUE_DATE_ID, PAID_DATE_ID)

Filters:
- DSO calculated only for paid records
- Aging buckets calculated using CURRENT_DATE
