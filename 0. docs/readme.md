For practice and demostration

This repo holds the **data models, SQL logic, and documentation**, while Data lives in Snowflake.
--------------------------------------------------------------------------------------

Built based on following sequences for each sectors (1.operational controlling, 2.ProductLifeCycle, 3.Sales controlling)

## 1 Design
Data warehouse modeling, Data Architecture design, Star/Galaxy Schema, setup Modeling.md, Dictionary, and ER-Diagram 
**Reverse Modeling: in demo phase, we design firstly the content of final output, to decide what 'raw' data need to be prepared**

## 2 Raw
Simulate raw data pipelines, create raw tables, insert Dummy data based on business simulation, build sample queries

## 3 Stage
Simulate Data cleaning (DataType, Deduplication, Validation, normalize semi-structured data), create stage tables, dimension tables, build sample queries

## 4 Mart
Simulate Business-oriented data modeling, aggregated dataset, support reporting, analytics and performance monitoring, create mart tables, build sample queries

## 5 Visionlization
Build DA View for PowerBI, Connect with PowerBI Desktop Dashboard

| 层级 | README内容 | Modeling说明内容 |
|------|-----------|----------------|
| **RAW** | - 数据来源(System/API/Upload)<br>- 抓取频率<br>- 原始字段说明<br>- 数据责任人 | - 表结构与数据镜像<br>- 不修改原始数据<br>- 源系统映射(ERD) |
| **STG** | - 清洗规则(Null/类型/异常)<br>- 外部维度(DIM)<br>- 与RAW映射关系 | - 技术模型<br>- 从RAW演变过程<br>- 字段拆分/合并 |
| **MART** | - 业务逻辑(OEE/Yield计算)<br>- 数据粒度(Day/Machine/Product)<br>- KPI定义<br>- BI接口 | - 事实表/维度表设计<br>- Star/Snowflake Schema<br>- 聚合逻辑/数据血缘 |
| **VIEW** | - BI视图说明<br>- 刷新机制<br>- 用途(Dashboard/Analysis/Report) | - 组合MART逻辑<br>- 过滤/权限/RLS<br>- 终端用户结构 |
