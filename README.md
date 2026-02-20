# 🏥 Building a Robust Database Solution for an NHS Community Clinic in Newcastle

## Introduction

In this project, I designed and implemented a comprehensive relational database solution for a fictional NHS community clinic in Newcastle upon Tyne. Built using **Microsoft SQL Server (T-SQL)** and developed in **SQL Server Management Studio (SSMS)**, the database manages the full patient journey — from registration and GP appointments through to prescriptions, specialist referrals, medical records, room bookings, and audit compliance.

The solution goes beyond basic CRUD operations to demonstrate advanced T-SQL capabilities including stored procedures with validation logic, audit triggers, common table expressions (CTEs), window functions, and reporting views suitable for real-world clinic dashboards.

## Project Overview

The NHS Community Clinic serves the local Newcastle upon Tyne population across **eight clinical departments**. The database captures every touchpoint in the patient care pathway, enabling the clinic to manage day-to-day operations, track clinical outcomes, monitor prescribing patterns, and maintain a full audit trail for NHS compliance.

### Clinic Departments
- General Practice
- Physiotherapy
- Mental Health Services
- Respiratory Care
- Pharmacy
- Dermatology
- Paediatrics
- Diabetes & Endocrinology

### Key Figures

| Metric | Count |
|--------|-------|
| Database Tables | 11 |
| Registered Patients | 20 |
| Clinic Staff | 15 |
| Appointments (Oct-Dec 2024) | 50 |
| Prescriptions Issued | 20 |
| Specialist Referrals | 10 |
| Medical Records with ICD-10 Codes | 16 |
| Clinic Rooms | 12 |
| Stored Procedures | 5 |
| Database Views | 4 |
| Audit Triggers | 3 |
| Analytical Queries | 20 |

## Database Design

### Entity-Relationship Model

The database was designed using a conceptual entity-relationship diagram (ERD) to map out the relationships between clinical entities before any code was written. This approach ensured data integrity and normalisation from the outset.

### Schema Overview

| Table | Purpose |
|-------|---------|
| `Departments` | Clinic departments with head of department, phone extension, and floor |
| `Staff` | GPs, nurses, specialists, pharmacists, admin, and receptionists |
| `Patients` | Patient demographics, NHS number, registered GP, and emergency contacts |
| `Clinic_Rooms` | Physical rooms with type, capacity, equipment details, and availability |
| `Appointments` | Scheduled and completed appointments linking patients, staff, departments, and rooms |
| `Medications` | Drug reference table with categories, dosage forms, and controlled substance flags |
| `Prescriptions` | Issued prescriptions with medication, dosage, frequency, repeat status, and pharmacy notes |
| `Referrals` | Internal and external referrals with priority levels and outcome tracking |
| `Medical_Records` | Consultation notes, ICD-10 diagnosis codes, treatment plans, and follow-up scheduling |
| `Room_Bookings` | Room allocation for appointments and staff meetings with time-slot management |
| `Audit_Log` | Compliance audit trail recording all INSERT, UPDATE, and DELETE actions across the system |

### Key Relationships

- **Patients to Staff**: Each patient is registered with a named GP
- **Appointments to Patients, Staff, Departments, Rooms**: Central table linking all clinical activity
- **Prescriptions to Patients, Staff, Appointments, Medications**: Full prescribing chain from consultation to dispensing
- **Referrals to Patients, Staff, Appointments, Departments**: Tracks referral pathway from GP to specialist outcome
- **Medical Records to Patients, Appointments, Staff**: Ties diagnoses and treatment plans to specific consultations
- **Room Bookings to Rooms, Appointments, Staff**: Prevents double-booking and tracks room utilisation
- **Audit Log to All Tables**: Automated compliance trail via triggers

## Technical Implementation

### Part 1: Schema Design (DDL)

The schema was built with data integrity as a priority:

- **Primary keys** using `IDENTITY` columns for auto-incrementing IDs
- **Foreign key constraints** enforcing referential integrity across all 11 tables
- **CHECK constraints** validating business rules (e.g., appointment types must be one of: Routine, Urgent, Follow-Up, Telephone, Home Visit, Walk-In)
- **DEFAULT values** for timestamps, status fields, and location defaults
- **Non-clustered indexes** on high-frequency query columns (dates, status fields, foreign keys, postcodes) to optimise performance

### Part 2: Sample Data (DML)

Realistic sample data was created to reflect a genuine NHS community clinic:

- **20 patients** with authentic Newcastle postcodes (NE1 to NE6) and diverse demographics
- **15 staff members** across 6 job roles and 8 departments
- **50 appointments** spanning October to December 2024, with a mix of Completed, No-Show, Cancelled, and Scheduled statuses
- **20 prescriptions** covering 12 medications with proper NHS dosage conventions
- **10 referrals** including internal, external, diagnostic, Two-Week Wait cancer pathway, and emergency mental health referrals
- **16 medical records** using real ICD-10 diagnosis codes (e.g., I10 for hypertension, E11.9 for Type 2 diabetes, F41.1 for generalised anxiety disorder)

### Part 3: Queries and Advanced Features

#### Basic to Intermediate Queries (Queries 1 to 10)

| Query | Description |
|-------|-------------|
| 1 | List all registered patients ordered by surname |
| 2 | Active staff with department and role details |
| 3 | Completed appointments in October 2024 with patient and clinician details |
| 4 | Patients registered with a specific GP |
| 5 | Appointment booking method breakdown (online vs phone vs in-person) |
| 6 | Prescription details with patient, medication, and prescriber information |
| 7 | Urgent and emergency referrals prioritised by severity |
| 8 | Room utilisation analysis (bookings per room and total minutes used) |
| 9 | Patients on repeat prescriptions with medication details |
| 10 | Full medical record history for a specific patient |

#### Aggregate and Analytical Queries (Queries 11 to 15)

| Query | Description |
|-------|-------------|
| 11 | Monthly appointment volumes with no-show rate percentage |
| 12 | Top prescribing clinicians by volume and unique patients |
| 13 | Department workload analysis (appointments, patients, clinical minutes) |
| 14 | Most commonly prescribed medications with repeat count |
| 15 | Patient age demographics using CASE-based grouping |

#### CTEs and Window Functions (Queries 16 to 20)

| Query | Technique | Description |
|-------|-----------|-------------|
| 16 | CTE | Patient appointment frequency and span analysis |
| 17 | CTE | Referral pathway completion rates by type and priority |
| 18 | RANK() | Clinician ranking by appointment volume within each department |
| 19 | SUM() OVER() | Running total of prescriptions by month |
| 20 | LAG() | Patient visit frequency, calculating days between consecutive appointments |

#### Views (4 Reporting Views)

| View | Purpose |
|------|---------|
| `vw_ActivePatientSummary` | Reception dashboard showing patient overview, age, registered GP, and visit history |
| `vw_DailyClinicSchedule` | Daily appointment schedule with full clinician, room, and patient details |
| `vw_PrescriptionDashboard` | Prescription tracking with medication category, prescriber, and pharmacy notes |
| `vw_ReferralTracking` | Referral monitoring with days-since-referral calculation and outcome tracking |

#### Stored Procedures (5 Procedures)

| Procedure | Purpose |
|-----------|---------|
| `sp_RegisterPatient` | New patient registration with NHS number duplication check and GP validation |
| `sp_BookAppointment` | Appointment booking with double-booking prevention for both clinician and room |
| `sp_UpdateAppointmentStatus` | Status management (Complete, Cancel, No-Show) with automatic room booking sync |
| `sp_IssuePrescription` | Prescription creation with patient/medication validation and controlled drug warnings |
| `sp_MonthlyClinicReport` | Comprehensive monthly performance report covering appointments, prescriptions, and referrals |

#### Triggers (3 Audit Triggers)

| Trigger | Purpose |
|---------|---------|
| `trg_AuditPatientUpdate` | Logs all patient record modifications and auto-updates the timestamp |
| `trg_AuditAppointmentUpdate` | Tracks appointment status transitions (e.g., Scheduled to Completed) |
| `trg_AuditNewReferral` | Records all new referrals with priority and destination for compliance tracking |

#### DML Operations

- **UPDATE**: Patient contact details, appointment cancellations, prescription dispensing
- **DELETE**: Safe deletion with EXISTS check (only removes cancelled bookings)

## File Structure

```
NHS_Newcastle_Clinic/
|
|-- NHS_Newcastle_Clinic_Part1_Schema.sql              -- DDL: Tables, constraints, indexes
|-- NHS_Newcastle_Clinic_Part2_SampleData.sql           -- DML: INSERT statements with sample data
|-- NHS_Newcastle_Clinic_Part3_QueriesAndAdvanced.sql   -- Queries, views, SPs, triggers, DML
|-- README.md                                           -- Project documentation
```

## How to Run

1. Open **SQL Server Management Studio (SSMS)**
2. Connect to your SQL Server instance
3. Execute **Part 1** to create the `NHS_Newcastle_Clinic` database and all 11 tables with constraints and indexes
4. Execute **Part 2** to populate all tables with sample data
5. Execute **Part 3** to create views, stored procedures, triggers, and run all 20 analytical queries

**Note**: Each `CREATE PROCEDURE`, `CREATE VIEW`, and `CREATE TRIGGER` statement must be preceded by a `GO` batch separator. The scripts are structured to handle this automatically.

## Tools and Technologies

- **Microsoft SQL Server Express** (LocalDB)
- **SQL Server Management Studio (SSMS)** for development and testing
- **T-SQL** for all database programming
- **Quick Database Diagrams** for ERD design

## Skills Demonstrated

- Relational database design and normalisation (up to 3NF)
- T-SQL programming including stored procedures, triggers, and views
- Complex multi-table JOIN queries (up to 6 tables)
- Aggregate functions with GROUP BY for operational reporting
- Common Table Expressions (CTEs) for readable analytical queries
- Window functions (RANK, LAG, running totals with SUM OVER)
- Data validation using CHECK constraints, FOREIGN KEY constraints, and stored procedure logic
- Indexing strategy for query performance optimisation
- Audit trail implementation for NHS information governance compliance
- DML operations (INSERT, UPDATE, DELETE) with error handling and safety checks
- Healthcare domain knowledge including ICD-10 coding, NHS referral pathways, and prescribing conventions

## Author

**Chikeziri Nnodum** | Data Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/chikeziri-nnodum/) 

## Licence

This project is for portfolio and educational purposes. All patient data is entirely fictional and does not represent real individuals. No real NHS data was used in the creation of this project.
