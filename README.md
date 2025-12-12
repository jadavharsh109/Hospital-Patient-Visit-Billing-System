🏥 Hospital Visit & Billing Management System – SQL Project (Single-Table Dataset)

This project demonstrates how a single raw hospital dataset (500+ rows) can be transformed into a fully functional SQL-based management and analytics system.
Using one consolidated table that contains patient, doctor, visit, and billing details, the project performs data cleaning, transformation, reporting, automation, and analytics—similar to a real hospital workflow.

<img width="102.4" height="153.6" alt="image" src="https://github.com/user-attachments/assets/00272abe-0ead-40aa-b1f8-6ce6adb7ea04" />


📌 Key Features
🔧 Data Cleaning & Updates

Increase paid_amount by 5% for Insurance payments

Set age < 1 to NULL

Delete rows where billing_amount = 0

Delete visits of "invalid" patients (manually tagged)

📊 Analytics & Insights

Total, paid, and outstanding revenue

Revenue by doctor & department

Top 10 spending patients

Monthly revenue trend

Average billing by visit type (OPD / IPD / Emergency)

Follow-up visit counts

🔍 SQL Operations
📁 Joins

(Performed logically within the same table using self-joins where needed)

📎 Subqueries

Patients with visit count > average

Visits above patient’s own average billing

Doctors earning above average revenue

🪟 Window Functions

Running total of revenue

Doctor revenue ranking

LAG & LEAD revenue trends

🏗️ Views

Monthly_Billing_Summary

Doctor_Performance

High_Value_Patients

⚙️ Stored Procedures

settle_payment(visit_id, amount)

add_followup(visit_id)

🔥 Triggers

On billing update → log into audit table

On new visit → auto-calculate outstanding amount

🛢️ Tech Stack

MySQL 

SQL analytics, views, procedures, triggers

Single-table relational logic

👨‍💻 Author

Harshkumar Jadav
SQL | Data Analyst | Data Science & ML
