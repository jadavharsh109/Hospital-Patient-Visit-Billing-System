USE hospital_mgmt ;

SELECT * FROM hospital;

# Increase all paid_amount by 5% for “Insurance” payments
UPDATE HOSPITAL
SET paid_amount =paid_amount*1.05
WHERE payment_method = "Insurance";

# Correct any visit records where age < 1 → set to NULL
UPDATE HOSPITAL
SET AGE = NULL
WHERE Age< 1;

DELETE FROM hospital
WHERE billing_amount = 0 ;

# Total, Paid & Outstanding Revenue
SELECT
    ROUND(SUM(billing_amount), 2) AS total_revenue,
    ROUND(SUM(paid_amount), 2) AS paid_revenue,
    ROUND(SUM(billing_amount - paid_amount), 2) AS outstanding_revenue
FROM hospital;

# Revenue by Doctor
SELECT doctor_id, doctor_name,
    SUM(billing_amount) AS total_revenue
FROM hospital
GROUP BY doctor_id, doctor_name
ORDER BY total_revenue DESC;

# REVENUE BY DEPARTMENT
SELECT department,
	ROUND(SUM(billing_amount),2) AS total_revenue
FROM hospital
GROUP BY department
ORDER BY patient_id, patient_name DESC;

# TOP 10 PATIENTS BY SPENDING
SELECT patient_id, patient_name,
	ROUND(SUM(billing_amount),2) AS total_revenue
FROM hospital
GROUP BY patient_id, patient_name
ORDER BY total_revenue DESC;

# Monthly revenue trend
SELECT
    DATE_FORMAT(STR_TO_DATE(visit_date, '%d-%m-%Y'), '%y-%m') AS month,
    round(SUM(billing_amount),2) AS total_revenue
FROM hospital
GROUP BY month
ORDER BY month;

# Average billing per visit type (OPD/IPD/Emergency)
SELECT
    visit_type,
    ROUND(AVG(billing_amount), 2) AS avg_billing
FROM hospital
GROUP BY visit_type;

# Count of visits requiring follow-up
SELECT
    COUNT(*) AS follow_up_visits
FROM hospital
WHERE follow_up_flag = 1;

# List all visits with patient name, doctor name, and department
SELECT
    visit_id,
    patient_name,
    doctor_name,
    department
FROM hospital;

# List all procedures performed with billing amounts
SELECT
    procedure_code,
    procedure_description,
    billing_amount
FROM hospital ;

SELECT
    procedure_code,
    procedure_description,
    round(SUM(billing_amount),2) AS total_billing
FROM hospital
GROUP BY procedure_code, procedure_description
ORDER BY procedure_code;

# Patients whose visit count is above average visit count
SELECT 
    patient_id,
    COUNT(visit_id) AS visit_count
FROM hospital
GROUP BY patient_id
HAVING COUNT(visit_id) > (
    SELECT AVG(visit_count)
    FROM (
        SELECT COUNT(*) AS visit_count
        FROM hospital
        GROUP BY patient_id
    ) AS t
);

SELECT AVG(cnt)
FROM (
    SELECT COUNT(*) AS cnt
    FROM hospital
    GROUP BY patient_id
) t;

SELECT
    patient_id,
    COUNT(*) AS visit_count
FROM hospital
GROUP BY patient_id
HAVING COUNT(*) > 1.11;

-- Visits where billing is above patient’s own average billing
SELECT *
FROM hospital h
WHERE billing_amount >
(
    SELECT AVG(billing_amount)
    FROM hospital
    WHERE patient_id = h.patient_id
);

-- Doctors with revenue higher than average doctor revenue
SELECT doctor_id, doctor_name
FROM hospital
GROUP BY doctor_id, doctor_name
HAVING SUM(billing_amount) >
(
    SELECT AVG(doc_revenue)
    FROM (
        SELECT SUM(billing_amount) AS doc_revenue
        FROM hospital
        GROUP BY doctor_id
    ) d
);

-- Running total of daily revenue
SELECT
    visit_date,
    SUM(billing_amount) AS daily_revenue,
    SUM(SUM(billing_amount)) OVER (ORDER BY visit_date) AS running_total
FROM hospital
GROUP BY visit_date;

-- Ranking doctors based on total revenue
SELECT
    doctor_id,
    doctor_name,
    SUM(billing_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(billing_amount) DESC) AS revenue_rank
FROM hospital
GROUP BY doctor_id, doctor_name;

-- Lag/Lead analysis of daily revenue
SELECT
    visit_date,
    SUM(billing_amount) AS daily_revenue,
    LAG(SUM(billing_amount)) OVER (ORDER BY visit_date) AS prev_day_revenue,
    LEAD(SUM(billing_amount)) OVER (ORDER BY visit_date) AS next_day_revenue
FROM hospital
GROUP BY visit_date;

-- Monthly billing summary view
CREATE VIEW Monthly_Billing_Summary1 AS
SELECT
    DATE_FORMAT(visit_date, '%Y-%m') AS month,
    ROUND(SUM(billing_amount),2) AS total_billing,
    ROUND(SUM(paid_amount),2) AS total_paid
FROM hospital
GROUP BY month;
select * from Monthly_Billing_Summary1;
-- Doctor performance view
CREATE VIEW Doctor_Performance AS
SELECT
    doctor_id,
    doctor_name,
    COUNT(*) AS total_visits,
    SUM(billing_amount) AS total_revenue,
    ROUND(AVG(billing_amount), 2) AS avg_billing
FROM hospital
GROUP BY doctor_id, doctor_name;

select * from Doctor_Performance;

-- High value patients view 
CREATE VIEW High_Value_Patients AS
SELECT
    patient_id,
    patient_name,
    SUM(billing_amount) AS total_spent
FROM hospital
GROUP BY patient_id, patient_name
HAVING total_spent > 50000;

select * from High_Value_Patient;

-- Procedure to settle payment
DELIMITER $$
CREATE PROCEDURE settle_payment(IN v_id INT, IN amt DECIMAL(10,2))
BEGIN
    UPDATE hospital
    SET paid_amount = paid_amount + amt
    WHERE visit_id = v_id;
END $$
DELIMITER ;

-- Procedure to add follow-up flag
DELIMITER $$
CREATE PROCEDURE add_followup(IN v_id INT)
BEGIN
    UPDATE hospital
    SET follow_up_flag = TRUE
    WHERE visit_id = v_id;
END $$
DELIMITER ;

-- Audit table for billing updates
CREATE TABLE audit_log (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    visit_id INT,
    old_billing DECIMAL(10,2),
    new_billing DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from audit_log;
-- Trigger on UPDATE of billing_amount
DELIMITER $$
CREATE TRIGGER billing_update_audit
AFTER UPDATE ON hospital
FOR EACH ROW
BEGIN
    IF OLD.billing_amount <> NEW.billing_amount THEN
        INSERT INTO audit_log (visit_id, old_billing, new_billing)
        VALUES (OLD.visit_id, OLD.billing_amount, NEW.billing_amount);
    END IF;
END $$
DELIMITER 