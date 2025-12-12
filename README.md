🏥 Hospital Visit & Billing Management System (SQL Project)

📌 Overview

This project is a complete SQL-based hospital management and analytics system built using a single-table dataset (500+ rows).
It covers patient visits, billing, payments, follow-ups, and operational analytics through advanced SQL queries, stored procedures, and triggers.

The goal is to simulate real hospital workflows using SQL only.

📑 Dataset Used

The project uses one consolidated table containing:

Patient details

Doctor information

Visit data

Diagnoses

Procedures

Payments & billing

Table Name: hospital

🧱 Table Structure (Single Table)
Column	Description
visit_id (PK)	Unique visit identifier
patient_id	Patient ID
patient_name	Name of the patient
doctor_id	Doctor ID
doctor_name	Name of the doctor
department	Doctor’s department
visit_date	Date of the hospital visit
visit_type	OPD / IPD / Emergency
age	Patient age
diagnosis	Condition diagnosed
procedure_performed	Procedure performed (if any)
follow_up_needed	Y / N
payment_type	Cash / Insurance / Online
billing_amount	Total billing
paid_amount	Amount paid
outstanding_amount	Due amount
status	valid / invalid
🔍 Key SQL Operations
✔ UPDATE Queries

Increase paid_amount by 5% for Insurance payments

Set age = NULL where age < 1

✔ DELETE Queries

Delete rows where billing_amount = 0

Delete visits of patients marked invalid

📊 Insights & Analytics

Total revenue, paid revenue, outstanding amount

Revenue by doctor

Revenue by department

Monthly revenue trend

Top 10 highest billing patients

Visits requiring follow-up

Average billing by visit type (OPD / IPD / Emergency)

🧠 Advanced SQL
JOINS (self-joins within the same table)

Patient–doctor–department mapping

Procedures & billing comparison

SUBQUERIES

Patients with visit count above average

Visits where billing > patient’s own average

Doctors earning above average revenue

WINDOW FUNCTIONS

Running total of daily revenue

Ranking doctors by revenue

LAG/LEAD analysis for revenue trends

🏗️ Views Created

Monthly_Billing_Summary

Doctor_Performance

High_Value_Patients

⚙️ Stored Procedures

settle_payment(visit_id, amount) – updates payment

add_followup(visit_id) – flags visit for follow-up

🔥 Triggers Implemented

On billing update → insert into audit_log

On new visit insert → auto-calculate outstanding_amount

📂 Files Included
Hospital-SQL-Project/
│── patient_data.csv
│── hospital.sql
│── README.md

🚀 Applications

🧾 Hospital reporting and billing insights

⚙️ SQL automation using triggers & procedures

📊 Business intelligence dashboards

🎓 Ideal for learning SQL, analytics & database design

🚀 Future Enhancements

Integrate with Python (Pandas, Matplotlib) for visual insights

Build Power BI dashboards for trends & analytics

Add ML models for revenue prediction
