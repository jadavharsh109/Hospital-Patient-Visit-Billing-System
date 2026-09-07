-- ==========================================================
-- Hospital Patient Visit & Billing Management System
-- Database Schema & Table Initialization
-- Database: hospital_mgmt
-- Author: Harsh Jadav (https://www.linkedin.com/in/harshjadav0901/)
-- ==========================================================

CREATE DATABASE IF NOT EXISTS hospital_mgmt;
USE hospital_mgmt;

-- 1. Main Hospital Clinical & Billing Table (30 Columns)
DROP TABLE IF EXISTS hospital;
CREATE TABLE hospital (
    patient_id VARCHAR(20) NOT NULL,
    visit_id VARCHAR(20) NOT NULL,
    visit_date VARCHAR(20),
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    doctor_id VARCHAR(20),
    doctor_name VARCHAR(100),
    department VARCHAR(50),
    diagnosis_code VARCHAR(20),
    diagnosis_description VARCHAR(255),
    procedure_code VARCHAR(20),
    procedure_description VARCHAR(255),
    prescription_id VARCHAR(20),
    medication VARCHAR(100),
    med_quantity INT,
    med_unit_price DECIMAL(10,2),
    med_total_cost DECIMAL(10,2),
    procedure_cost DECIMAL(10,2),
    other_charges DECIMAL(10,2),
    billing_amount DECIMAL(10,2),
    insurance_provider VARCHAR(100),
    payment_method VARCHAR(50),
    paid_amount DECIMAL(10,2),
    visit_type VARCHAR(30),
    follow_up_flag VARCHAR(5),
    clinic_location VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (visit_id)
);

-- 2. Audit Log Table (Tracking Billing Updates via Triggers)
DROP TABLE IF EXISTS audit_log;
CREATE TABLE audit_log (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    visit_id VARCHAR(20),
    old_billing DECIMAL(10,2),
    new_billing DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- CSV Import Instructions:
-- ==========================================================
-- Method 1 (Recommended): MySQL Workbench Table Data Import Wizard
--   1. Connect to MySQL Workbench and expand 'hospital_mgmt' schema.
--   2. Right-click on table 'hospital' -> select 'Table Data Import Wizard'.
--   3. Browse and select 'data/Patient_data.csv'.
--   4. Verify field mapping and click Next to finish import.

-- Method 2: Command Line LOAD DATA LOCAL INFILE
--   LOAD DATA LOCAL INFILE 'data/Patient_data.csv'
--   INTO TABLE hospital
--   FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
--   IGNORE 1 ROWS;
