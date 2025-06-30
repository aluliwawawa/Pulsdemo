# Data Dictionary: MART_MACHINE_WEEKLY

| Column Name          | Type      | Description                                          |
|----------------------|-----------|------------------------------------------------------|
| factory_id           | STRING    | Factory ID (e.g., F1, F2, F3)                        |
| machine_id           | STRING    | Machine ID (e.g., SMT01, AOI01)                      |
| machine_type         | STRING    | Machine Type (SMT, AOI, FT)                          |
| iso_year_week        | STRING    | ISO year-week format (e.g., 2024-W01)                |
| total_units          | NUMBER    | Total units produced                                 |
| passed_units         | NUMBER    | Passed units                                         |
| failed_units         | NUMBER    | Failed units                                         |
| yield_rate_percent   | FLOAT     | Yield = passed_units / total_units * 100             |
| runtime_min          | FLOAT     | Actual runtime in minutes                            |
| planned_time_min     | FLOAT     | Planned time in minutes for the week                 |
| utilization_percent  | FLOAT     | Utilization = runtime_min / planned_time_min * 100   |
| oee_percent          | FLOAT     | OEE = Availability * Performance * Quality * 100     |
| source_table         | STRING    | Data source (SMT/FT/AOI)                             |
| etl_load_time        | TIMESTAMP | ETL load timestamp                                   |

## Primary Key (Logical):
- (factory_id, machine_id, iso_year_week)

## Foreign Keys (Logical):
- factory_id → DIM_FACTORY.factory_id
- machine_id → DIM_MACHINE.machine_id
- iso_year_week → DIM_DATE.iso_year_week

## Calculated Fields Formula:

- **Yield Rate (%)** = (passed_units / total_units) * 100
- **Utilization (%)** = (runtime_min / planned_time_min) * 100
- **Availability** = runtime_min / planned_time_min
- **Performance** = (ideal_cycle_time * total_units) / runtime_min
- **Quality** = passed_units / total_units
- **OEE (%)** = Availability * Performance * Quality * 100
