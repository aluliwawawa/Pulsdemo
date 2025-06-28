-- ############################################################
-- 🔍 SECTION 4: SAMPLE QUERIES (for demostration)
-- ############################################################
-- sample1：query daily production of device_SMT
SELECT log_date, factory_id, SUM(total_units) AS total_units
FROM P1_RAW.SMT_LOG
GROUP BY log_date, factory_id
ORDER BY log_date;

-- sample2：query all devices status
SELECT status, COUNT(*)
FROM P1_RAW.MACHINE_STATUS_LOG
GROUP BY status;

-- sample3：query trend of yield rate of device_AOI
SELECT log_date, 
       SUM(passed_units) / NULLIF(SUM(total_units), 0) AS pass_rate
FROM P1_RAW.AOI_LOG
GROUP BY log_date
ORDER BY log_date;

-- ############################################################
-- 💾 SECTION 1: CREATE DATABASE AND SCHEMA
-- ############################################################
CREATE DATABASE IF NOT EXISTS DEMO_PULS_OPERATION;

CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P1_RAW;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P2_STAGE;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P3_MART;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P4_REPORT;
CREATE SCHEMA IF NOT EXISTS DEMO_PULS_OPERATION.P5_BACKUP;

USE DATABASE DEMO_PULS_OPERATION;
USE SCHEMA P1_RAW;

-- ############################################################
-- 🏗️ SECTION 2: CREATE TABLES
-- ############################################################
CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.SMT_LOG (
    log_id INT AUTOINCREMENT PRIMARY KEY,
    factory_id VARCHAR(50),
    machine_id VARCHAR(50),
    product_id VARCHAR(50),
    log_date DATE,
    total_units INT,
    passed_units INT,
    failed_units INT,
    defect_code VARCHAR(50),
    cycle_time_sec FLOAT,
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.AOI_LOG (
    log_id INT AUTOINCREMENT PRIMARY KEY,
    factory_id VARCHAR(50),
    machine_id VARCHAR(50),
    product_id VARCHAR(50),
    log_date DATE,
    total_units INT,
    passed_units INT,
    failed_units INT,
    defect_code VARCHAR(50),
    cycle_time_sec FLOAT,
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.FT_LOG (
    log_id INT AUTOINCREMENT PRIMARY KEY,
    factory_id VARCHAR(50),
    machine_id VARCHAR(50),
    product_id VARCHAR(50),
    log_date DATE,
    total_units INT,
    passed_units INT,
    failed_units INT,
    defect_code VARCHAR(50),
    cycle_time_sec FLOAT,
    created_at TIMESTAMP
);

CREATE OR REPLACE TABLE DEMO_PULS_OPERATION.P1_RAW.MACHINE_STATUS_LOG (
    event_id INT AUTOINCREMENT PRIMARY KEY,
    factory_id VARCHAR(50),
    machine_id VARCHAR(50),
    machine_type VARCHAR(50), -- SMT/AOI/FT
    status VARCHAR(20),       -- RUNNING/DOWN/IDLE/MAINTENANCE
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_minute FLOAT,
    log_date DATE,           
    created_at TIMESTAMP
);

-- ############################################################
-- 🧠 SECTION 3: INSERT DUMMY DATA
-- ############################################################
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-03', 1472, 1212, 260, 'D001', 858.29, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-02', 1096, 1067, 29, 'D002', 733.12, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1001', '2024-06-04', 1271, 1098, 173, 'D004', 1620.74, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1001', '2024-06-01', 891, 834, 57, 'D004', 1019.67, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-01', 1069, 955, 114, 'D003', 1191.45, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-02', 1357, 1107, 250, 'D001', 1066.52, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1002', '2024-06-09', 869, 716, 153, 'D001', 618.52, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1001', '2024-06-02', 534, 477, 57, 'D001', 444.32, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1002', '2024-06-09', 1483, 1327, 156, 'D002', 1028.63, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1002', '2024-06-05', 570, 543, 27, 'D004', 673.63, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-10', 722, 596, 126, 'D004', 744.17, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1001', '2024-06-10', 667, 603, 64, 'D004', 582.52, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-09', 1055, 889, 166, 'D002', 1481.0, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-08', 678, 602, 76, 'D002', 750.73, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-01', 803, 795, 8, 'D004', 682.66, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-06', 1007, 856, 151, 'D002', 711.1, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-04', 1136, 955, 181, 'D002', 795.35, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1001', '2024-06-09', 1292, 1035, 257, 'D001', 742.77, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1002', '2024-06-04', 1367, 1153, 214, 'D004', 1709.0, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1003', '2024-06-07', 1227, 1180, 47, 'D002', 988.05, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-02', 746, 660, 86, 'D001', 743.88, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1002', '2024-06-06', 1270, 1200, 70, 'D003', 1823.16, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-05', 1317, 1145, 172, 'D002', 1876.84, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1002', '2024-06-05', 1316, 1296, 20, 'D001', 975.14, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1003', '2024-06-01', 1259, 1258, 1, 'D001', 1882.22, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1002', '2024-06-01', 943, 868, 75, 'D001', 1350.04, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M01', 'P1002', '2024-06-04', 1082, 966, 116, 'D002', 1507.64, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1002', '2024-06-07', 889, 759, 130, 'D003', 451.27, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-03', 1466, 1283, 183, 'D003', 1216.33, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.SMT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M01', 'P1003', '2024-06-06', 1392, 1275, 117, 'D004', 1636.19, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-07', 1484, 1250, 234, 'D003', 1931.71, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1001', '2024-06-08', 1131, 971, 160, 'D003', 1173.72, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1002', '2024-06-04', 1479, 1392, 87, 'D004', 1978.99, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1003', '2024-06-09', 1216, 1195, 21, 'D004', 1527.28, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1001', '2024-06-04', 1389, 1178, 211, 'D001', 1986.32, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-06', 1112, 981, 131, 'D003', 885.28, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-02', 980, 942, 38, 'D001', 1325.52, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1003', '2024-06-02', 960, 926, 34, 'D003', 937.55, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-01', 808, 661, 147, 'D002', 1202.76, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1003', '2024-06-08', 1271, 1238, 33, 'D001', 1044.87, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1003', '2024-06-10', 1208, 984, 224, 'D003', 786.17, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1001', '2024-06-03', 524, 419, 105, 'D001', 702.84, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1003', '2024-06-04', 719, 583, 136, 'D002', 861.33, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-10', 1137, 1053, 84, 'D001', 957.72, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1002', '2024-06-10', 687, 659, 28, 'D002', 375.17, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-01', 675, 646, 29, 'D004', 513.72, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1003', '2024-06-09', 872, 757, 115, 'D003', 999.31, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1003', '2024-06-04', 1139, 1086, 53, 'D001', 1548.73, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-01', 766, 714, 52, 'D004', 504.65, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-05', 1492, 1239, 253, 'D003', 1557.87, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-09', 775, 720, 55, 'D002', 863.58, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-06', 647, 595, 52, 'D002', 531.81, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-03', 1285, 1125, 160, 'D001', 1345.73, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-04', 1191, 1006, 185, 'D004', 738.96, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1002', '2024-06-04', 1139, 1112, 27, 'D003', 1639.14, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1002', '2024-06-04', 1461, 1411, 50, 'D003', 1347.6, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M02', 'P1001', '2024-06-08', 718, 689, 29, 'D004', 749.21, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1003', '2024-06-05', 1192, 1018, 174, 'D003', 1442.29, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-02', 1467, 1410, 57, 'D004', 2192.71, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.AOI_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M02', 'P1001', '2024-06-05', 828, 776, 52, 'D004', 1021.5, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1002', '2024-06-09', 715, 705, 10, 'D004', 545.08, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-01', 972, 788, 184, 'D001', 857.86, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1003', '2024-06-02', 1143, 1090, 53, 'D004', 1026.38, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-03', 1333, 1225, 108, 'D003', 1358.2, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-01', 516, 450, 66, 'D004', 587.96, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-08', 573, 528, 45, 'D002', 296.93, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1002', '2024-06-07', 825, 751, 74, 'D001', 914.65, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-02', 706, 623, 83, 'D001', 841.14, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1002', '2024-06-05', 722, 678, 44, 'D003', 966.8, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1001', '2024-06-04', 1004, 805, 199, 'D001', 1273.85, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-10', 789, 753, 36, 'D002', 867.49, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1002', '2024-06-08', 1009, 844, 165, 'D001', 844.86, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-07', 1131, 1080, 51, 'D003', 1474.37, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-05', 1183, 1113, 70, 'D002', 778.46, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-03', 1225, 1157, 68, 'D001', 1200.89, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1002', '2024-06-05', 1024, 845, 179, 'D004', 849.75, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1001', '2024-06-03', 1218, 1030, 188, 'D003', 1736.97, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1003', '2024-06-08', 810, 749, 61, 'D001', 538.15, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-02', 588, 503, 85, 'D003', 436.71, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1001', '2024-06-06', 1055, 901, 154, 'D002', 1533.5, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-02', 903, 871, 32, 'D002', 479.19, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-06', 1088, 949, 139, 'D002', 1056.15, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-09', 970, 796, 174, 'D002', 1003.1, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-07', 1378, 1120, 258, 'D001', 1428.98, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1001', '2024-06-01', 1046, 908, 138, 'D001', 801.44, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-05', 1021, 870, 151, 'D003', 1278.32, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F01', 'M03', 'P1002', '2024-06-03', 1162, 1093, 69, 'D003', 929.44, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-02', 553, 542, 11, 'D003', 743.64, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1002', '2024-06-09', 987, 933, 54, 'D001', 655.03, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.FT_LOG (factory_id, machine_id, product_id, log_date, total_units, passed_units, failed_units, defect_code, cycle_time_sec, created_at) VALUES ('F02', 'M03', 'P1003', '2024-06-05', 891, 750, 141, 'D003', 1032.99, '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M01', 'SMT', 'MAINTENANCE', '2024-06-05 02:00:00', '2024-06-05 04:47:00', 167, '2024-06-05', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M02', 'AOI', 'MAINTENANCE', '2024-06-08 02:00:00', '2024-06-08 04:10:00', 130, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M02', 'AOI', 'IDLE', '2024-06-09 12:00:00', '2024-06-09 15:42:00', 222, '2024-06-09', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M01', 'SMT', 'RUNNING', '2024-06-03 00:00:00', '2024-06-03 03:04:00', 184, '2024-06-03', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M03', 'FT', 'RUNNING', '2024-06-02 14:00:00', '2024-06-02 16:22:00', 142, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M02', 'AOI', 'DOWN', '2024-06-08 13:00:00', '2024-06-08 13:59:00', 59, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M03', 'FT', 'DOWN', '2024-06-10 11:00:00', '2024-06-10 11:39:00', 39, '2024-06-10', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M01', 'SMT', 'IDLE', '2024-06-05 16:00:00', '2024-06-05 18:09:00', 129, '2024-06-05', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'IDLE', '2024-06-04 03:00:00', '2024-06-04 03:48:00', 48, '2024-06-04', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M03', 'FT', 'RUNNING', '2024-06-01 14:00:00', '2024-06-01 17:01:00', 181, '2024-06-01', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M03', 'FT', 'DOWN', '2024-06-02 01:00:00', '2024-06-02 02:49:00', 109, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M03', 'FT', 'RUNNING', '2024-06-08 20:00:00', '2024-06-08 22:31:00', 151, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'RUNNING', '2024-06-07 18:00:00', '2024-06-07 19:47:00', 107, '2024-06-07', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M03', 'FT', 'IDLE', '2024-06-08 08:00:00', '2024-06-08 09:35:00', 95, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'DOWN', '2024-06-10 05:00:00', '2024-06-10 08:07:00', 187, '2024-06-10', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'MAINTENANCE', '2024-06-07 19:00:00', '2024-06-07 19:57:00', 57, '2024-06-07', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'RUNNING', '2024-06-01 17:00:00', '2024-06-01 18:07:00', 67, '2024-06-01', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M02', 'AOI', 'IDLE', '2024-06-06 10:00:00', '2024-06-06 12:34:00', 154, '2024-06-06', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'RUNNING', '2024-06-05 00:00:00', '2024-06-05 01:12:00', 72, '2024-06-05', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M01', 'SMT', 'DOWN', '2024-06-06 06:00:00', '2024-06-06 09:47:00', 227, '2024-06-06', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M01', 'SMT', 'IDLE', '2024-06-10 07:00:00', '2024-06-10 09:33:00', 153, '2024-06-10', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M01', 'SMT', 'IDLE', '2024-06-02 19:00:00', '2024-06-02 22:56:00', 236, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'MAINTENANCE', '2024-06-02 13:00:00', '2024-06-02 15:21:00', 141, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'MAINTENANCE', '2024-06-08 01:00:00', '2024-06-08 04:39:00', 219, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M01', 'SMT', 'DOWN', '2024-06-02 02:00:00', '2024-06-02 05:01:00', 181, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M03', 'FT', 'DOWN', '2024-06-08 04:00:00', '2024-06-08 05:11:00', 71, '2024-06-08', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'IDLE', '2024-06-02 01:00:00', '2024-06-02 03:41:00', 161, '2024-06-02', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M03', 'FT', 'IDLE', '2024-06-09 04:00:00', '2024-06-09 05:12:00', 72, '2024-06-09', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F01', 'M01', 'SMT', 'DOWN', '2024-06-01 00:00:00', '2024-06-01 03:37:00', 217, '2024-06-01', '2025-06-28 14:12:36');
INSERT INTO P1_RAW.MACHINE_STATUS_LOG (factory_id, machine_id, machine_type, status, start_time, end_time, duration_minute, log_date, created_at) VALUES ('F02', 'M02', 'AOI', 'IDLE', '2024-06-06 03:00:00', '2024-06-06 06:23:00', 203, '2024-06-06', '2025-06-28 14:12:36');
